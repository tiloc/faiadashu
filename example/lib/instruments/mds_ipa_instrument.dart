class Mds30Ipa110Instrument {
  static const mds30Ipa110Instrument = r'''
{
  "resourceType": "Questionnaire",
  "id": "MDS3.0-IPA-1.10",
  "meta": {
    "versionId": "11",
    "lastUpdated": "2020-09-04T00:51:45.935+00:00",
    "source": "#rm1DuQZi3K5YVRaF",
    "profile": [ "https://impact-fhir.mitre.org/r4/StructureDefinition/del-StandardForm" ]
  },
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">MDS3_0_IPA standard form version 1.10.<br/><br/>The MDS is a powerful tool for implementing standardized assessment and for facilitating care management in nursing homes (NHs) and non-critical access hospital swing beds (SBs).</div>"
  },
  "url": "http://hapi.fhir.org/baseR4/Questionnaire/MDS3.0-IPA-1.10",
  "identifier": [ {
    "use": "official",
    "system": "http://del.cms.gov",
    "value": "Minimum Data Set"
  } ],
  "version": "1.10",
  "name": "MDS3_0_IPA",
  "title": "Minimum Data Set - Interim Payment Assessment",
  "status": "retired",
  "date": "2018-04-30T20:51:52.871Z",
  "publisher": "Division of Nursing Home",
  "description": "The MDS is a powerful tool for implementing standardized assessment and for facilitating care management in nursing homes (NHs) and non-critical access hospital swing beds (SBs).",
  "approvalDate": "2012-04-01",
  "effectivePeriod": {
    "start": "2012-04-01T00:00:00+00:00",
    "end": "2013-09-30T00:00:00+00:00"
  },
  "item": [ {
    "linkId": "Section-39",
    "text": "Admission Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-39/A0220",
      "prefix": "A0220",
      "text": "Admission Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false
    }, {
      "linkId": "Section-39/13",
      "prefix": "13",
      "text": "Assessment Reference Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false
    }, {
      "linkId": "Section-39/14",
      "prefix": "14",
      "text": "Admission Class",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 2
    }, {
      "linkId": "Section-39/17",
      "prefix": "17",
      "text": "Pre-hospital Living With (Code only if item {Pre-hospital Living Setting} is Home)",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 2
    } ]
  }, {
    "linkId": "Section-45",
    "text": "Discharge Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-45/A2500",
      "prefix": "A2500",
      "text": "Program Interruption(s)",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 1
    }, {
      "linkId": "Section-45/40",
      "prefix": "40",
      "text": "Discharge Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false
    }, {
      "linkId": "Section-45/41",
      "prefix": "41",
      "text": "{Patient/Resident} discharged against medical advice?",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 1
    }, {
      "linkId": "Section-45/45",
      "prefix": "45",
      "text": "Discharge to Living With",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 2
    }, {
      "linkId": "Section-45/46",
      "prefix": "46",
      "text": "Diagnosis for Interruption or Death (Code using ICD code)",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 8
    }, {
      "linkId": "Section-45/47",
      "prefix": "47",
      "text": "Complications during rehabilitation stay (Use ICD codes to specify up to six conditions that began with this rehabilitation stay)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-45/47A",
        "prefix": "47A",
        "text": "Complication during rehabilitation stay A",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-45/47B",
        "prefix": "47B",
        "text": "Complication during rehabilitation stay B",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-45/47C",
        "prefix": "47C",
        "text": "Complication during rehabilitation stay C",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-45/47D",
        "prefix": "47D",
        "text": "Complication during rehabilitation stay D",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-45/47E",
        "prefix": "47E",
        "text": "Complication during rehabilitation stay E",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-45/47F",
        "prefix": "47F",
        "text": "Complication during rehabilitation stay F",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      } ]
    }, {
      "linkId": "Section-45/A2525",
      "prefix": "A2525",
      "text": "Program Interruption Dates. Code only if {number of program interruptions} is greater than or equal to 01.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-45/A2525A1",
        "prefix": "A2525A1",
        "text": "First Interruption Date",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      }, {
        "linkId": "Section-45/A2525A2",
        "prefix": "A2525A2",
        "text": "First interruption Return Date",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      }, {
        "linkId": "Section-45/A2525B1",
        "prefix": "A2525B1",
        "text": "Second Interruption Date. Code only if {number of program interruptions} is greater than 01.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      }, {
        "linkId": "Section-45/A2525B2",
        "prefix": "A2525B2",
        "text": "Second Interruption Return Date. Code only if {number of program interruptions} is greater than 01.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      }, {
        "linkId": "Section-45/A2525C1",
        "prefix": "A2525C1",
        "text": "Third Interruption Date. Code only if {number of program interruptions} is greater than 02.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      }, {
        "linkId": "Section-45/A2525C2",
        "prefix": "A2525C2",
        "text": "Third Interruption Return Date. Code only if {number of program interruptions} is greater than 02.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false
      } ]
    } ]
  }, {
    "linkId": "Section-38",
    "text": "Identification Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-38/A0700",
      "prefix": "A0700",
      "text": "Medicaid Number - Enter \"+\" if pending, \"N\" if not a Medicaid recipient",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "+",
          "display": "Enter \"+\" if Medicaid application is pending"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "+",
          "display": "Enter \"+\" if Medicaid application is pending"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Enter \"N\" if not a Medicaid recipient"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Enter \"N\" if not a Medicaid recipient"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (not available or unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (not available or unknown)"
        }
      } ]
    }, {
      "linkId": "Section-38/A0800",
      "prefix": "A0800",
      "text": "Gender",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Male"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Male"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Female"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Female"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information/unable to determine"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information/unable to determine"
        }
      } ]
    }, {
      "linkId": "Section-38/A0900",
      "prefix": "A0900",
      "text": "Birth Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "{Patient/Resident} Birthdate"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "{Patient/Resident} Birthdate"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMYYYY",
          "display": "{Patient/Resident} Birthdate (if day of month is unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMYYYY",
          "display": "{Patient/Resident} Birthdate (if day of month is unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "YYYY",
          "display": "{Patient/Resident} Birthdate (if month and day unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "YYYY",
          "display": "{Patient/Resident} Birthdate (if month and day unknown)"
        }
      } ]
    }, {
      "linkId": "Section-38/A1200",
      "prefix": "A1200",
      "text": "Marital Status",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Never married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Never married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Widowed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Widowed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Separated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Separated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "5",
          "display": "Divorced"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "5",
          "display": "Divorced"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-38/11",
      "prefix": "11",
      "text": "Zip Code of {Patient's/Resident's} Pre-Hospital Residence",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 5
    }, {
      "linkId": "Section-38/1",
      "prefix": "1",
      "text": "{Facility/Provider} Information",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-38/1A",
        "prefix": "1A",
        "text": "{Facility/Provider} Name",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 50
      } ]
    }, {
      "linkId": "Section-38/5B",
      "prefix": "5B",
      "text": "{Patient/Resident} Identification Number",
      "type": "text",
      "repeats": false,
      "readOnly": false,
      "maxLength": 50
    }, {
      "linkId": "Section-38/A1000",
      "prefix": "A1000",
      "text": "Race/Ethnicity: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "American Indian or Alaska Native"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "American Indian or Alaska Native"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Asian"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Asian"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Black or African American"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Black or African American"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Hispanic or Latino"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Hispanic or Latino"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Native Hawaiian or Other Pacific Islander"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Native Hawaiian or Other Pacific Islander"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "White"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "White"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-41",
    "text": "Medical Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-41/23",
      "prefix": "23",
      "text": "Date of Onset of Impairment",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false
    }, {
      "linkId": "Section-41/22",
      "prefix": "22",
      "text": "Etiologic Diagnosis: (Use ICD codes to indicate the etiologic problem that led to the condition for which the {patient/resident} is receiving rehabilitation)",
      "type": "group",
      "repeats": false,
      "readOnly": true
    }, {
      "linkId": "Section-41/24",
      "prefix": "24",
      "text": "Comorbid Conditions. Use ICD codes to enter comorbid medical conditions",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-41/24A",
        "prefix": "24A",
        "text": "Comorbid Condition A",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24B",
        "prefix": "24B",
        "text": "Comorbid Condition B",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24C",
        "prefix": "24C",
        "text": "Comorbid Condition C",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24D",
        "prefix": "24D",
        "text": "Comorbid Condition D",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24E",
        "prefix": "24E",
        "text": "Comorbid Condition E",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24F",
        "prefix": "24F",
        "text": "Comorbid Condition F",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24G",
        "prefix": "24G",
        "text": "Comorbid Condition G",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24H",
        "prefix": "24H",
        "text": "Comorbid Condition H",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24I",
        "prefix": "24I",
        "text": "Comorbid Condition I",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      }, {
        "linkId": "Section-41/24J",
        "prefix": "24J",
        "text": "Comorbid Condition J",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 8
      } ]
    }, {
      "linkId": "Section-41/21",
      "prefix": "21",
      "text": "Impairment group",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-41/21_admission",
        "prefix": "21_admission",
        "text": "Impairment group - admission",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-41/21_discharge",
        "prefix": "21_discharge",
        "text": "Impairment group - discharge",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    } ]
  }, {
    "linkId": "Section-40",
    "text": "Payer Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-40/20",
      "prefix": "20",
      "text": "Payment Source",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-40/20A",
        "prefix": "20A",
        "text": "Primary Source",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 2
      }, {
        "linkId": "Section-40/20B",
        "prefix": "20B",
        "text": "Secondary Source",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 2
      } ]
    } ]
  }, {
    "linkId": "Section-1",
    "text": "Section A: Identification Information",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-1/A0200",
      "prefix": "A0200",
      "text": "Type of Provider",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Nursing home (SNF/NF)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Swing Bed"
        }
      } ]
    }, {
      "linkId": "Section-1/A0700",
      "prefix": "A0700",
      "text": "Medicaid Number - Enter \"+\" if pending, \"N\" if not a Medicaid recipient",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "+",
          "display": "Enter \"+\" if Medicaid application is pending"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "+",
          "display": "Enter \"+\" if Medicaid application is pending"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Enter \"N\" if not a Medicaid recipient"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Enter \"N\" if not a Medicaid recipient"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (not available or unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (not available or unknown)"
        }
      } ]
    }, {
      "linkId": "Section-1/A0800",
      "prefix": "A0800",
      "text": "Gender",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Male"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Male"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Female"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Female"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information/unable to determine"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information/unable to determine"
        }
      } ]
    }, {
      "linkId": "Section-1/A0900",
      "prefix": "A0900",
      "text": "Birth Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "{Patient/Resident} Birthdate"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "{Patient/Resident} Birthdate"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMYYYY",
          "display": "{Patient/Resident} Birthdate (if day of month is unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMYYYY",
          "display": "{Patient/Resident} Birthdate (if day of month is unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "YYYY",
          "display": "{Patient/Resident} Birthdate (if month and day unknown)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "YYYY",
          "display": "{Patient/Resident} Birthdate (if month and day unknown)"
        }
      } ]
    }, {
      "linkId": "Section-1/A1200",
      "prefix": "A1200",
      "text": "Marital Status",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Never married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Never married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Married"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Widowed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Widowed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Separated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Separated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "5",
          "display": "Divorced"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "5",
          "display": "Divorced"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-1/A0410",
      "prefix": "A0410",
      "text": "Unit Certification or Licensure Designation",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Unit is neither Medicare nor Medicaid certified and MDS data is not required by the State"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Unit is neither Medicare nor Medicaid certified but MDS data is required by the State"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Unit is Medicare and/or Medicaid certified"
        }
      } ]
    }, {
      "linkId": "Section-1/A1500",
      "prefix": "A1500",
      "text": "Preadmission Screening and Resident Review (PASRR). Is the resident currently considered by the state level II PASRR process to have serious mental illness and/or intellectual disability or a related condition? Complete only if {admission, annual, significant change, or significant correction}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not a Medicaid-certified unit"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-1/A1600",
      "prefix": "A1600",
      "text": "Entry Date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "Entry date (date of this admission/entry or reentry into the facility)"
        }
      } ]
    }, {
      "linkId": "Section-1/A1700",
      "prefix": "A1700",
      "text": "Type of Entry",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Admission"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Reentry"
        }
      } ]
    }, {
      "linkId": "Section-1/A1800",
      "prefix": "A1800",
      "text": "Entered From",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "01",
          "display": "Community (private home/apt., board/care, assisted living, group home)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "02",
          "display": "Another nursing home or swing bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "03",
          "display": "Acute hospital"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "04",
          "display": "Psychiatric hospital"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "05",
          "display": "Inpatient rehabilitation facility"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "06",
          "display": "ID/DD facility"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "07",
          "display": "Hospice"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "09",
          "display": "Long Term Care Hospital (LTCH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Other"
        }
      } ]
    }, {
      "linkId": "Section-1/A2000",
      "prefix": "A2000",
      "text": "Discharge Date - Complete only if {discharge or death}",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "Discharge date"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-1/A2100",
      "prefix": "A2100",
      "text": "Discharge Status - Complete only if {discharge or death}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "01",
          "display": "Community (private home/apt., board/care, assisted living, group home)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "02",
          "display": "Another nursing home or swing bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "03",
          "display": "Acute hospital"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "04",
          "display": "Psychiatric hospital"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "05",
          "display": "Inpatient rehabilitation facility"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "06",
          "display": "ID/DD facility"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "07",
          "display": "Hospice"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "08",
          "display": "Deceased"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "09",
          "display": "Long Term Care Hospital (LTCH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Other"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-1/A2200",
      "prefix": "A2200",
      "text": "Previous Assessment Reference Date for Significant Correction. Complete only if {significant correction}",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "Previous assessment reference date for significant correction"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-1/A2300",
      "prefix": "A2300",
      "text": "Assessment Reference Date. Observation end date",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "MMDDYYYY",
          "display": "Assessment reference date"
        }
      } ]
    }, {
      "linkId": "Section-1/A0050",
      "prefix": "A0050",
      "text": "Type of Record",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Add new assessment/record"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Modify existing record"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Inactivate existing record"
        }
      } ]
    }, {
      "linkId": "Section-1/A0100",
      "prefix": "A0100",
      "text": "Facility Provider Numbers",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A0100A",
        "prefix": "A0100A",
        "text": "National Provider Identifier (NPI)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A0100B",
        "prefix": "A0100B",
        "text": "CMS Certification Number (CCN)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A0100C",
        "prefix": "A0100C",
        "text": "State Medicaid {Facility/Provider} Number",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A0310",
      "prefix": "A0310",
      "text": "Type of Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A0310A",
        "prefix": "A0310A",
        "text": "Federal OBRA Reason for Assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "01",
            "display": "Admission assessment (required by day 14)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "02",
            "display": "Quarterly review assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "03",
            "display": "Annual assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "04",
            "display": "Significant change in status assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "05",
            "display": "Significant correction to prior comprehensive assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "06",
            "display": "Significant correction to prior quarterly assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-1/A0310B",
        "prefix": "A0310B",
        "text": "PPS Assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "01",
            "display": "5-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "02",
            "display": "14-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "03",
            "display": "30-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "04",
            "display": "60-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "05",
            "display": "90-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "06",
            "display": "Readmission/return assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "07",
            "display": "Unscheduled assessment used for PPS (OMRA, significant or clinical change, or significant correction assessment)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-1/A0310E",
        "prefix": "A0310E",
        "text": "Is this assessment the first assessment since the most recent {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        } ]
      }, {
        "linkId": "Section-1/A0310F",
        "prefix": "A0310F",
        "text": "Entry/discharge reporting",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "01",
            "display": "Entry tracking record"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Discharge assessment - return not anticipated"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "11",
            "display": "Discharge assessment - return anticipated"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "12",
            "display": "Death in facility tracking record"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-1/A0310G",
        "prefix": "A0310G",
        "text": "Type of discharge - Complete only if {discharge assessment}",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Planned"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Unplanned"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A0500",
      "prefix": "A0500",
      "text": "Legal Name of {Patient/Resident}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A0500A",
        "prefix": "A0500A",
        "text": "First name",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A0500B",
        "prefix": "A0500B",
        "text": "Middle initial",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A0500C",
        "prefix": "A0500C",
        "text": "Last name",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 18
      }, {
        "linkId": "Section-1/A0500D",
        "prefix": "A0500D",
        "text": "Suffix",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A0600",
      "prefix": "A0600",
      "text": "Social Security and Medicare Numbers",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A0600A",
        "prefix": "A0600A",
        "text": "Social Security Number",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A0600B",
        "prefix": "A0600B",
        "text": "Medicare number",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A1100",
      "prefix": "A1100",
      "text": "Language",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A1100A",
        "prefix": "A1100A",
        "text": "Does the {patient/resident} need or want an interpreter to communicate with a doctor or health care staff?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-1/A1100B",
        "prefix": "A1100B",
        "text": "Preferred language",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A1300",
      "prefix": "A1300",
      "text": "Optional {Patient/Resident} Items",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A1300A",
        "prefix": "A1300A",
        "text": "Medical record number",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A1300B",
        "prefix": "A1300B",
        "text": "Room number",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A1300C",
        "prefix": "A1300C",
        "text": "Name by which {patent/resident} prefers to be addressed",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-1/A1300D",
        "prefix": "A1300D",
        "text": "Lifetime occupation(s) - put \"/\" between two occupations",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A2400",
      "prefix": "A2400",
      "text": "Medicare Stay. Complete only if {SNF Part A Interrupted Stay}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-1/A2400A",
        "prefix": "A2400A",
        "text": "Has the {patient/resident} had a Medicare-covered stay since the most recent entry?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        } ]
      }, {
        "linkId": "Section-1/A2400B",
        "prefix": "A2400B",
        "text": "Start date of most recent Medicare stay",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Start date of most recent Medicare stay"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-1/A2400C",
        "prefix": "A2400C",
        "text": "End date of most recent Medicare stay. Enter dashes if stay is ongoing",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "End date of most recent Medicare stay"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "--------",
            "display": "Medicare stay is ongoing"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-1/A1000",
      "prefix": "A1000",
      "text": "Race/Ethnicity: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "American Indian or Alaska Native"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "American Indian or Alaska Native"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Asian"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Asian"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Black or African American"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Black or African American"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Hispanic or Latino"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Hispanic or Latino"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Native Hawaiian or Other Pacific Islander"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Native Hawaiian or Other Pacific Islander"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "White"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "White"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-1/A1510",
      "prefix": "A1510",
      "text": "Level II Preadmission Screening and Resident Review (PASRR) Conditions. Complete only if {admission, annual, significant change, or significant correction}: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Serious mental illness"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Intellectual Disability"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Other related conditions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-1/A1550",
      "prefix": "A1550",
      "text": "Conditions Related to ID/DD Status. If the {patient/resident} is 22 years of age or older, complete only if {admission}. If the {patient/resident} is 21 years of age or younger, complete only if {admission, annual, significant change, or significant correction}: Check all conditions that are related to ID/DD status that were manifested before age 22, and are likely to continue indefinitely",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Down syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Autism"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Other organic condition related to ID/DD"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "ID/DD with no organic condition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-2",
    "text": "Section B: Hearing, Speech, and Vision",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-2/B0100",
      "prefix": "B0100",
      "text": "Comatose. Persistent vegetative state/no discernible consciousness",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-2/B0200",
      "prefix": "B0200",
      "text": "Hearing. Ability to hear (with hearing aid or hearing appliances if normally used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - no difficulty in normal conversation, social interaction, listening to TV"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Minimal difficulty - difficulty in some environments (e.g., when person speaks softly or setting is noisy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderate difficulty - speaker has to increase volume and speak distinctly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - absence of useful hearing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0300",
      "prefix": "B0300",
      "text": "Hearing Aid. Hearing aid or other hearing appliance used in completing {Hearing question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0600",
      "prefix": "B0600",
      "text": "Speech Clarity. Select best description of speech pattern",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Clear speech - distinct intelligible words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Unclear speech - slurred or mumbled words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "No speech - absence of spoken words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0700",
      "prefix": "B0700",
      "text": "Makes Self Understood. Ability to express ideas and wants, consider both verbal and non-verbal expression",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understood - difficulty communicating some words or finishing thoughts but is able if prompted or given time"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understood - ability is limited to making concrete requests"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0800",
      "prefix": "B0800",
      "text": "Ability To Understand Others. Understanding verbal content, however able (with hearing aid or device if used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understands - clear comprehension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understands - misses some part/intent of message but comprehends most conversation"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understands - responds adequately to simple, direct communication only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understands"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1000",
      "prefix": "B1000",
      "text": "Vision. Ability to see in adequate light (with glasses or other visual appliances)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - sees fine detail, such as regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Impaired - sees large print, but not regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - limited vision; not able to see newspaper headlines but can identify objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - object identification in question, but eyes appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Severely impaired - no vision or sees only light, colors or shapes; eyes do not appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1200",
      "prefix": "B1200",
      "text": "Corrective lenses (contacts, glasses or magnifying glass) used in completing {Vision question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-2",
    "text": "Section B: Hearing, Speech, and Vision",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-2/B0100",
      "prefix": "B0100",
      "text": "Comatose. Persistent vegetative state/no discernible consciousness",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-2/B0200",
      "prefix": "B0200",
      "text": "Hearing. Ability to hear (with hearing aid or hearing appliances if normally used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - no difficulty in normal conversation, social interaction, listening to TV"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Minimal difficulty - difficulty in some environments (e.g., when person speaks softly or setting is noisy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderate difficulty - speaker has to increase volume and speak distinctly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - absence of useful hearing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0300",
      "prefix": "B0300",
      "text": "Hearing Aid. Hearing aid or other hearing appliance used in completing {Hearing question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0600",
      "prefix": "B0600",
      "text": "Speech Clarity. Select best description of speech pattern",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Clear speech - distinct intelligible words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Unclear speech - slurred or mumbled words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "No speech - absence of spoken words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0700",
      "prefix": "B0700",
      "text": "Makes Self Understood. Ability to express ideas and wants, consider both verbal and non-verbal expression",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understood - difficulty communicating some words or finishing thoughts but is able if prompted or given time"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understood - ability is limited to making concrete requests"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0800",
      "prefix": "B0800",
      "text": "Ability To Understand Others. Understanding verbal content, however able (with hearing aid or device if used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understands - clear comprehension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understands - misses some part/intent of message but comprehends most conversation"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understands - responds adequately to simple, direct communication only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understands"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1000",
      "prefix": "B1000",
      "text": "Vision. Ability to see in adequate light (with glasses or other visual appliances)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - sees fine detail, such as regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Impaired - sees large print, but not regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - limited vision; not able to see newspaper headlines but can identify objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - object identification in question, but eyes appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Severely impaired - no vision or sees only light, colors or shapes; eyes do not appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1200",
      "prefix": "B1200",
      "text": "Corrective lenses (contacts, glasses or magnifying glass) used in completing {Vision question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-2",
    "text": "Section B: Hearing, Speech, and Vision",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-2/B0100",
      "prefix": "B0100",
      "text": "Comatose. Persistent vegetative state/no discernible consciousness",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-2/B0200",
      "prefix": "B0200",
      "text": "Hearing. Ability to hear (with hearing aid or hearing appliances if normally used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - no difficulty in normal conversation, social interaction, listening to TV"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Minimal difficulty - difficulty in some environments (e.g., when person speaks softly or setting is noisy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderate difficulty - speaker has to increase volume and speak distinctly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - absence of useful hearing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0300",
      "prefix": "B0300",
      "text": "Hearing Aid. Hearing aid or other hearing appliance used in completing {Hearing question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0600",
      "prefix": "B0600",
      "text": "Speech Clarity. Select best description of speech pattern",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Clear speech - distinct intelligible words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Unclear speech - slurred or mumbled words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "No speech - absence of spoken words"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0700",
      "prefix": "B0700",
      "text": "Makes Self Understood. Ability to express ideas and wants, consider both verbal and non-verbal expression",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understood - difficulty communicating some words or finishing thoughts but is able if prompted or given time"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understood - ability is limited to making concrete requests"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understood"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B0800",
      "prefix": "B0800",
      "text": "Ability To Understand Others. Understanding verbal content, however able (with hearing aid or device if used)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Understands - clear comprehension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Usually understands - misses some part/intent of message but comprehends most conversation"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Sometimes understands - responds adequately to simple, direct communication only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Rarely/never understands"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1000",
      "prefix": "B1000",
      "text": "Vision. Ability to see in adequate light (with glasses or other visual appliances)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Adequate - sees fine detail, such as regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Impaired - sees large print, but not regular print in newspapers/books"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - limited vision; not able to see newspaper headlines but can identify objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Highly impaired - object identification in question, but eyes appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Severely impaired - no vision or sees only light, colors or shapes; eyes do not appear to follow objects"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-2/B1200",
      "prefix": "B1200",
      "text": "Corrective lenses (contacts, glasses or magnifying glass) used in completing {Vision question}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-3",
    "text": "Section C: Cognitive Patterns",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-3/C0100",
      "prefix": "C0100",
      "text": "Should Brief Interview for Mental Status be Conducted? Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0200",
      "prefix": "C0200",
      "text": "Repetition of Three Words - Ask {patient/resident}: \"I am going to say three words for you to remember. Please repeat the words after I have said all three. The words are: sock, blue, and bed. Now tell me the three words.\" Number of words repeated after first attempt",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "None"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "One"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Two"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Three"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0500",
      "prefix": "C0500",
      "text": "BIMS Summary Score. Add scores for {Brief Interview for Mental Status questions} and fill in total score (00-15). Enter 99 if the {patient/resident} was unable to complete the interview",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "15",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0600",
      "prefix": "C0600",
      "text": "Should the Staff Assessment for Mental Status be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} was able to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes ({patient/resident} was unable to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0700",
      "prefix": "C0700",
      "text": "Short-term Memory OK. Seems or appears to recall after 5 minutes",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0800",
      "prefix": "C0800",
      "text": "Long-term Memory OK. Seems or appears to recall long past",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C1000",
      "prefix": "C1000",
      "text": "Cognitive Skills for Daily Decision Making. Made decisions regarding tasks of daily life",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Independent - decisions consistent/reasonable"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Modified independence - some difficulty in new situations only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - decisions poor; cues/supervision required"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Severely impaired - never/rarely made decisions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0300",
      "prefix": "C0300",
      "text": "BIMS: Temporal Orientation (orientation to year, month, and day)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0300A",
        "prefix": "C0300A",
        "text": "Ask {patient/resident}: \"Please tell me what year it is right now.\" Able to report correct year",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 5 years or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 2 - 5 years"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Missed by 1 year"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300B",
        "prefix": "C0300B",
        "text": "Ask {patient/resident}: \"What month are we in right now?\" Able to report correct month",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 1 month or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 6 days to 1 month"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Accurate within 5 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300C",
        "prefix": "C0300C",
        "text": "Ask {patient/resident}: \"What day of the week is today?\" Able to report correct day of the week",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Incorrect or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0400",
      "prefix": "C0400",
      "text": "Recall. Ask {patient/resident}: \"Let's go back to an earlier question. What were those three words that I asked you to repeat?\" If unable to remember a word, give cue (something to wear; a color; a piece of furniture) for that word.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0400A",
        "prefix": "C0400A",
        "text": "Able to recall \"sock\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"something to wear\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400B",
        "prefix": "C0400B",
        "text": "Able to recall \"blue\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a color\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400C",
        "prefix": "C0400C",
        "text": "Able to recall \"bed\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a piece of furniture\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0900",
      "prefix": "C0900",
      "text": "Memory/Recall Ability: Check all that the {patient/resident} was normally able to recall",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Current season"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Location of own room"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Staff names and faces"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "That he or she is in a nursing home/hospital swing bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were recalled"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-3",
    "text": "Section C: Cognitive Patterns",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-3/C0100",
      "prefix": "C0100",
      "text": "Should Brief Interview for Mental Status be Conducted? Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0200",
      "prefix": "C0200",
      "text": "Repetition of Three Words - Ask {patient/resident}: \"I am going to say three words for you to remember. Please repeat the words after I have said all three. The words are: sock, blue, and bed. Now tell me the three words.\" Number of words repeated after first attempt",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "None"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "One"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Two"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Three"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0500",
      "prefix": "C0500",
      "text": "BIMS Summary Score. Add scores for {Brief Interview for Mental Status questions} and fill in total score (00-15). Enter 99 if the {patient/resident} was unable to complete the interview",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "15",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0600",
      "prefix": "C0600",
      "text": "Should the Staff Assessment for Mental Status be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} was able to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes ({patient/resident} was unable to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0700",
      "prefix": "C0700",
      "text": "Short-term Memory OK. Seems or appears to recall after 5 minutes",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0800",
      "prefix": "C0800",
      "text": "Long-term Memory OK. Seems or appears to recall long past",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C1000",
      "prefix": "C1000",
      "text": "Cognitive Skills for Daily Decision Making. Made decisions regarding tasks of daily life",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Independent - decisions consistent/reasonable"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Modified independence - some difficulty in new situations only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - decisions poor; cues/supervision required"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Severely impaired - never/rarely made decisions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0300",
      "prefix": "C0300",
      "text": "BIMS: Temporal Orientation (orientation to year, month, and day)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0300A",
        "prefix": "C0300A",
        "text": "Ask {patient/resident}: \"Please tell me what year it is right now.\" Able to report correct year",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 5 years or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 2 - 5 years"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Missed by 1 year"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300B",
        "prefix": "C0300B",
        "text": "Ask {patient/resident}: \"What month are we in right now?\" Able to report correct month",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 1 month or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 6 days to 1 month"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Accurate within 5 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300C",
        "prefix": "C0300C",
        "text": "Ask {patient/resident}: \"What day of the week is today?\" Able to report correct day of the week",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Incorrect or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0400",
      "prefix": "C0400",
      "text": "Recall. Ask {patient/resident}: \"Let's go back to an earlier question. What were those three words that I asked you to repeat?\" If unable to remember a word, give cue (something to wear; a color; a piece of furniture) for that word.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0400A",
        "prefix": "C0400A",
        "text": "Able to recall \"sock\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"something to wear\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400B",
        "prefix": "C0400B",
        "text": "Able to recall \"blue\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a color\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400C",
        "prefix": "C0400C",
        "text": "Able to recall \"bed\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a piece of furniture\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0900",
      "prefix": "C0900",
      "text": "Memory/Recall Ability: Check all that the {patient/resident} was normally able to recall",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Current season"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Location of own room"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Staff names and faces"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "That he or she is in a nursing home/hospital swing bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were recalled"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-3",
    "text": "Section C: Cognitive Patterns",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-3/C0100",
      "prefix": "C0100",
      "text": "Should Brief Interview for Mental Status be Conducted? Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0200",
      "prefix": "C0200",
      "text": "Repetition of Three Words - Ask {patient/resident}: \"I am going to say three words for you to remember. Please repeat the words after I have said all three. The words are: sock, blue, and bed. Now tell me the three words.\" Number of words repeated after first attempt",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "None"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "One"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Two"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Three"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0500",
      "prefix": "C0500",
      "text": "BIMS Summary Score. Add scores for {Brief Interview for Mental Status questions} and fill in total score (00-15). Enter 99 if the {patient/resident} was unable to complete the interview",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "15",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0600",
      "prefix": "C0600",
      "text": "Should the Staff Assessment for Mental Status be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} was able to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes ({patient/resident} was unable to complete Brief Interview for Mental Status)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0700",
      "prefix": "C0700",
      "text": "Short-term Memory OK. Seems or appears to recall after 5 minutes",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0800",
      "prefix": "C0800",
      "text": "Long-term Memory OK. Seems or appears to recall long past",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Memory OK"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Memory problem"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C1000",
      "prefix": "C1000",
      "text": "Cognitive Skills for Daily Decision Making. Made decisions regarding tasks of daily life",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Independent - decisions consistent/reasonable"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Modified independence - some difficulty in new situations only"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Moderately impaired - decisions poor; cues/supervision required"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Severely impaired - never/rarely made decisions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-3/C0300",
      "prefix": "C0300",
      "text": "BIMS: Temporal Orientation (orientation to year, month, and day)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0300A",
        "prefix": "C0300A",
        "text": "Ask {patient/resident}: \"Please tell me what year it is right now.\" Able to report correct year",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 5 years or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 2 - 5 years"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Missed by 1 year"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300B",
        "prefix": "C0300B",
        "text": "Ask {patient/resident}: \"What month are we in right now?\" Able to report correct month",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Missed by > 1 month or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Missed by 6 days to 1 month"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Accurate within 5 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0300C",
        "prefix": "C0300C",
        "text": "Ask {patient/resident}: \"What day of the week is today?\" Able to report correct day of the week",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Incorrect or no answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Correct"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0400",
      "prefix": "C0400",
      "text": "Recall. Ask {patient/resident}: \"Let's go back to an earlier question. What were those three words that I asked you to repeat?\" If unable to remember a word, give cue (something to wear; a color; a piece of furniture) for that word.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-3/C0400A",
        "prefix": "C0400A",
        "text": "Able to recall \"sock\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"something to wear\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400B",
        "prefix": "C0400B",
        "text": "Able to recall \"blue\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a color\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-3/C0400C",
        "prefix": "C0400C",
        "text": "Able to recall \"bed\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No - could not recall"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes, after cueing (\"a piece of furniture\")"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Yes, no cue required"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-3/C0900",
      "prefix": "C0900",
      "text": "Memory/Recall Ability: Check all that the {patient/resident} was normally able to recall",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Current season"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Location of own room"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Staff names and faces"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "That he or she is in a nursing home/hospital swing bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were recalled"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-4",
    "text": "Section D: Mood",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-4/D0100",
      "prefix": "D0100",
      "text": "Should {Patient/Resident} Mood Interview be Conducted? - Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0300",
      "prefix": "D0300",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 27. Enter 99 if unable to complete interview (i.e., Symptom Frequency is blank for 3 or more items).",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "27",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0600",
      "prefix": "D0600",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 30.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "30",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0200",
      "prefix": "D0200",
      "text": "{Patient/Resident} Mood Interview (PHQ-9). Say to {patient/resident}: \"Over the last 2 weeks, have you been bothered by any of the following problems?\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0200_1",
        "prefix": "D0200_1",
        "text": "\"Over the last 2 weeks, have you been bothered by any of the following problems?\" if symptom is present, enter 1 (yes) is column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0200_2",
        "prefix": "D0200_2",
        "text": "Ask the {patient/resident}: \"About how often have you been bothered by this?\" Read and show the {patient/resident} a card with the symptom frequency choices.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-4/D0500",
      "prefix": "D0500",
      "text": "Staff Assessment of {Patient/Resident} Mood (PHQ-9-OV*). Do not conduct if {Patient/Resident} Mood Interview was completed. Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors?",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0500_1",
        "prefix": "D0500_1",
        "text": "Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors? If symptom is present, enter 1 (yes) in column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0500_2",
        "prefix": "D0500_2",
        "text": "Over the last 2 weeks, did the resident have any of the following problems or behaviors? If symptom is present, indicate symptom frequency in column 2.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    } ]
  }, {
    "linkId": "Section-4",
    "text": "Section D: Mood",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-4/D0100",
      "prefix": "D0100",
      "text": "Should {Patient/Resident} Mood Interview be Conducted? - Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0300",
      "prefix": "D0300",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 27. Enter 99 if unable to complete interview (i.e., Symptom Frequency is blank for 3 or more items).",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "27",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0600",
      "prefix": "D0600",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 30.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "30",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0200",
      "prefix": "D0200",
      "text": "{Patient/Resident} Mood Interview (PHQ-9). Say to {patient/resident}: \"Over the last 2 weeks, have you been bothered by any of the following problems?\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0200_1",
        "prefix": "D0200_1",
        "text": "\"Over the last 2 weeks, have you been bothered by any of the following problems?\" if symptom is present, enter 1 (yes) is column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0200_2",
        "prefix": "D0200_2",
        "text": "Ask the {patient/resident}: \"About how often have you been bothered by this?\" Read and show the {patient/resident} a card with the symptom frequency choices.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-4/D0500",
      "prefix": "D0500",
      "text": "Staff Assessment of {Patient/Resident} Mood (PHQ-9-OV*). Do not conduct if {Patient/Resident} Mood Interview was completed. Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors?",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0500_1",
        "prefix": "D0500_1",
        "text": "Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors? If symptom is present, enter 1 (yes) in column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0500_2",
        "prefix": "D0500_2",
        "text": "Over the last 2 weeks, did the resident have any of the following problems or behaviors? If symptom is present, indicate symptom frequency in column 2.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    } ]
  }, {
    "linkId": "Section-4",
    "text": "Section D: Mood",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-4/D0100",
      "prefix": "D0100",
      "text": "Should {Patient/Resident} Mood Interview be Conducted? - Attempt to conduct interview with all {patients/residents}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0300",
      "prefix": "D0300",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 27. Enter 99 if unable to complete interview (i.e., Symptom Frequency is blank for 3 or more items).",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "27",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "99",
          "display": "Unable to complete interview"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0600",
      "prefix": "D0600",
      "text": "Total Severity Score. Add scores for all frequency responses in Column 2, Symptom Frequency. Total score must be between 00 and 30.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "30",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-4/D0200",
      "prefix": "D0200",
      "text": "{Patient/Resident} Mood Interview (PHQ-9). Say to {patient/resident}: \"Over the last 2 weeks, have you been bothered by any of the following problems?\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0200_1",
        "prefix": "D0200_1",
        "text": "\"Over the last 2 weeks, have you been bothered by any of the following problems?\" if symptom is present, enter 1 (yes) is column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0200_2",
        "prefix": "D0200_2",
        "text": "Ask the {patient/resident}: \"About how often have you been bothered by this?\" Read and show the {patient/resident} a card with the symptom frequency choices.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-4/D0500",
      "prefix": "D0500",
      "text": "Staff Assessment of {Patient/Resident} Mood (PHQ-9-OV*). Do not conduct if {Patient/Resident} Mood Interview was completed. Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors?",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-4/D0500_1",
        "prefix": "D0500_1",
        "text": "Over the last 2 weeks, did the {patient/resident} have any of the following problems or behaviors? If symptom is present, enter 1 (yes) in column 1.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-4/D0500_2",
        "prefix": "D0500_2",
        "text": "Over the last 2 weeks, did the resident have any of the following problems or behaviors? If symptom is present, indicate symptom frequency in column 2.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    } ]
  }, {
    "linkId": "Section-5",
    "text": "Section E: Behavior",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-5/E0300",
      "prefix": "E0300",
      "text": "Overall Presence of Behavioral Symptoms. Were any behavioral symptoms in {Behavioral Symptom question} coded 1, 2, or 3?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0800",
      "prefix": "E0800",
      "text": "Rejection of Care - Presence & Frequency. Did the {patient/resident} reject evaluation or care (e.g., bloodwork, taking medications, ADL assistance) that is necessary to achieve the {patient's/resident's} goals for health and well-being? Do not include behaviors that have already been addressed (e.g., by discussion or care planning with the {patient/resident} or family), and determined to be consistent with {patient/resident} values, preferences, or goals.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Behavior not exhibited"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Behavior of this type occurred 1 to 3 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Behavior of this type occurred daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0900",
      "prefix": "E0900",
      "text": "Wandering - Presence & Frequency. Has the {patient/resident} wandered?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Behavior not exhibited"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Behavior of this type occurred 1 to 3 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Behavior of this type occurred daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E1100",
      "prefix": "E1100",
      "text": "Change in Behavior or Other Symptoms. Consider all of the symptoms assessed in {Behavior section}. How does {patient's/resident's} current behavior status, care rejection, or wandering compare to prior assessment?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Same"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Improved"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Worse"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "N/A because no prior MDS assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0200",
      "prefix": "E0200",
      "text": "Behavioral Symptom - Presence & Frequency. Note presence of symptoms and their frequency",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0200A",
        "prefix": "E0200A",
        "text": "Physical behavioral symptoms directed towards others (e. g., hitting, kicking, pushing, scratching, grabbing, abusing others sexually)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0200B",
        "prefix": "E0200B",
        "text": "Verbal behavioral symptoms directed toward others (e.g., threatening others, screaming at others, cursing at others)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0200C",
        "prefix": "E0200C",
        "text": "Other behavioral symptoms not directed toward others (e.g., physical symptoms such as hitting or scratching self, pacing, rummaging, public sexual acts, disrobing in public, throwing or smearing food or bodily wastes, or verbal/vocal symptoms like screaming, disruptive sounds)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0500",
      "prefix": "E0500",
      "text": "Impact on {Patient/Resident}. Did any of the identified symptom(s):",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0500A",
        "prefix": "E0500A",
        "text": "Put the {patient/resident} at significant risk for physical illness or injury?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0500B",
        "prefix": "E0500B",
        "text": "Significantly interfere with the {patient's/resident's} care?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0500C",
        "prefix": "E0500C",
        "text": "Significantly interfere with the {patient's/resident's} participation in activities or social interactions?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0600",
      "prefix": "E0600",
      "text": "Impact on Others. Did any of the identified symptom(s):",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0600A",
        "prefix": "E0600A",
        "text": "Put others at significant risk for physical injury?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0600B",
        "prefix": "E0600B",
        "text": "Significantly intrude on the privacy or activity of others?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0600C",
        "prefix": "E0600C",
        "text": "Significantly disrupt care or living environment?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E1000",
      "prefix": "E1000",
      "text": "Wandering - Impact",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E1000A",
        "prefix": "E1000A",
        "text": "Does the wandering place the {patient/resident} at significant risk of getting to a potentially dangerous place (e.g., stairs, outside of the facility)?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E1000B",
        "prefix": "E1000B",
        "text": "Does the wandering significantly intrude on the privacy or activities of others?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0100",
      "prefix": "E0100",
      "text": "Potential Indicators of Psychosis: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Hallucinations (perceptual experiences in the absence of real external sensory stimuli)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Delusions (misconceptions or beliefs that are firmly held, contrary to reality)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-5",
    "text": "Section E: Behavior",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-5/E0300",
      "prefix": "E0300",
      "text": "Overall Presence of Behavioral Symptoms. Were any behavioral symptoms in {Behavioral Symptom question} coded 1, 2, or 3?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0800",
      "prefix": "E0800",
      "text": "Rejection of Care - Presence & Frequency. Did the {patient/resident} reject evaluation or care (e.g., bloodwork, taking medications, ADL assistance) that is necessary to achieve the {patient's/resident's} goals for health and well-being? Do not include behaviors that have already been addressed (e.g., by discussion or care planning with the {patient/resident} or family), and determined to be consistent with {patient/resident} values, preferences, or goals.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Behavior not exhibited"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Behavior of this type occurred 1 to 3 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Behavior of this type occurred daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0900",
      "prefix": "E0900",
      "text": "Wandering - Presence & Frequency. Has the {patient/resident} wandered?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Behavior not exhibited"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Behavior of this type occurred 1 to 3 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Behavior of this type occurred daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E1100",
      "prefix": "E1100",
      "text": "Change in Behavior or Other Symptoms. Consider all of the symptoms assessed in {Behavior section}. How does {patient's/resident's} current behavior status, care rejection, or wandering compare to prior assessment?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Same"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Improved"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Worse"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "N/A because no prior MDS assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-5/E0200",
      "prefix": "E0200",
      "text": "Behavioral Symptom - Presence & Frequency. Note presence of symptoms and their frequency",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0200A",
        "prefix": "E0200A",
        "text": "Physical behavioral symptoms directed towards others (e. g., hitting, kicking, pushing, scratching, grabbing, abusing others sexually)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0200B",
        "prefix": "E0200B",
        "text": "Verbal behavioral symptoms directed toward others (e.g., threatening others, screaming at others, cursing at others)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0200C",
        "prefix": "E0200C",
        "text": "Other behavioral symptoms not directed toward others (e.g., physical symptoms such as hitting or scratching self, pacing, rummaging, public sexual acts, disrobing in public, throwing or smearing food or bodily wastes, or verbal/vocal symptoms like screaming, disruptive sounds)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Behavior not exhibited"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Behavior of this type occurred 1 to 3 days"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Behavior of this type occurred 4 to 6 days, but less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Behavior of this type occurred daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0500",
      "prefix": "E0500",
      "text": "Impact on {Patient/Resident}. Did any of the identified symptom(s):",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0500A",
        "prefix": "E0500A",
        "text": "Put the {patient/resident} at significant risk for physical illness or injury?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0500B",
        "prefix": "E0500B",
        "text": "Significantly interfere with the {patient's/resident's} care?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0500C",
        "prefix": "E0500C",
        "text": "Significantly interfere with the {patient's/resident's} participation in activities or social interactions?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0600",
      "prefix": "E0600",
      "text": "Impact on Others. Did any of the identified symptom(s):",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E0600A",
        "prefix": "E0600A",
        "text": "Put others at significant risk for physical injury?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0600B",
        "prefix": "E0600B",
        "text": "Significantly intrude on the privacy or activity of others?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E0600C",
        "prefix": "E0600C",
        "text": "Significantly disrupt care or living environment?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E1000",
      "prefix": "E1000",
      "text": "Wandering - Impact",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-5/E1000A",
        "prefix": "E1000A",
        "text": "Does the wandering place the {patient/resident} at significant risk of getting to a potentially dangerous place (e.g., stairs, outside of the facility)?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-5/E1000B",
        "prefix": "E1000B",
        "text": "Does the wandering significantly intrude on the privacy or activities of others?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-5/E0100",
      "prefix": "E0100",
      "text": "Potential Indicators of Psychosis: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Hallucinations (perceptual experiences in the absence of real external sensory stimuli)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Delusions (misconceptions or beliefs that are firmly held, contrary to reality)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-6",
    "text": "Section F: Preferences for Customary Routine and Activities",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-6/F0300",
      "prefix": "F0300",
      "text": "Should Interview for Daily and Activity Preferences be Conducted? Attempt to interview all {patients/residents} able to communicate. If {patient/resident} is unable to complete, attempt to complete interview with family member or significant other",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood and family/significant other not available)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0600",
      "prefix": "F0600",
      "text": "Daily and Activity Preferences Primary Respondent. Indicate primary respondent for Daily and Activity Preferences",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "{Patient/Resident}"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Family or significant other (close friend or other representative)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Interview could not be completed by {patient/resident} or family/significant other (\"No response\" to 3 or more items)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0700",
      "prefix": "F0700",
      "text": "Should the Staff Assessment of Daily and Activity Preferences be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (because Interview for Daily and Activity Preferences was completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (because 3 or more items in Interview for Daily and Activity Preferences were not completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0400",
      "prefix": "F0400",
      "text": "Interview for Daily Preferences. Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0400A",
        "prefix": "F0400A",
        "text": "how important is it to you to choose what clothes to wear?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400B",
        "prefix": "F0400B",
        "text": "how important is it to you to take care of your personal belongings or things?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400C",
        "prefix": "F0400C",
        "text": "how important is it to you to choose between a tub bath, shower, bed bath, or sponge bath?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400D",
        "prefix": "F0400D",
        "text": "how important is it to you to have snacks available between meals?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400E",
        "prefix": "F0400E",
        "text": "how important is it to you to choose your own bedtime?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400F",
        "prefix": "F0400F",
        "text": "how important is it to you to have your family or a close friend involved in discussions about your care?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400G",
        "prefix": "F0400G",
        "text": "how important is it to you to be able to use the phone in private?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400H",
        "prefix": "F0400H",
        "text": "how important is it to you to have a place to lock your things to keep them safe?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0500",
      "prefix": "F0500",
      "text": "Interview for Activity Preferences: Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0500A",
        "prefix": "F0500A",
        "text": "how important is it to you to have books, newspapers, and magazines to read?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500B",
        "prefix": "F0500B",
        "text": "how important is it to you to listen to music you like?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500C",
        "prefix": "F0500C",
        "text": "how important is it to you to be around animals such as pets?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500D",
        "prefix": "F0500D",
        "text": "how important is it to you to keep up with the news?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500E",
        "prefix": "F0500E",
        "text": "how important is it to you to do things with groups of people?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500F",
        "prefix": "F0500F",
        "text": "how important is it to you to do your favorite activities?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500G",
        "prefix": "F0500G",
        "text": "how important is it to you to go outside to get fresh air when the weather is good?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500H",
        "prefix": "F0500H",
        "text": "how important is it to you to participate in religious services or practices?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0800",
      "prefix": "F0800",
      "text": "Staff Assessment of Daily and Activity Preferences. Do not conduct if Interview for Daily and Activity Preferences was completed. {Patient/Resident} Prefers: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Choosing clothes to wear"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Caring for personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Receiving tub bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Receiving shower"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Receiving bed bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Receiving sponge bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Snacks between meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Staying up past 8:00 p.m."
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Family or significant other involvement in care discussions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "J",
          "display": "Use of phone in private"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "K",
          "display": "Place to lock personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "L",
          "display": "Reading books, newspapers, or magazines"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "M",
          "display": "Listening to music"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Being around animals such as pets"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "O",
          "display": "Keeping up with the news"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "P",
          "display": "Doing things with groups of people"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Q",
          "display": "Participating in favorite activities"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "R",
          "display": "Spending time away from the nursing home"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "S",
          "display": "Spending time outdoors"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "T",
          "display": "Participating in religious activities or practices"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-6",
    "text": "Section F: Preferences for Customary Routine and Activities",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-6/F0300",
      "prefix": "F0300",
      "text": "Should Interview for Daily and Activity Preferences be Conducted? Attempt to interview all {patients/residents} able to communicate. If {patient/resident} is unable to complete, attempt to complete interview with family member or significant other",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood and family/significant other not available)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0600",
      "prefix": "F0600",
      "text": "Daily and Activity Preferences Primary Respondent. Indicate primary respondent for Daily and Activity Preferences",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "{Patient/Resident}"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Family or significant other (close friend or other representative)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Interview could not be completed by {patient/resident} or family/significant other (\"No response\" to 3 or more items)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0700",
      "prefix": "F0700",
      "text": "Should the Staff Assessment of Daily and Activity Preferences be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (because Interview for Daily and Activity Preferences was completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (because 3 or more items in Interview for Daily and Activity Preferences were not completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0400",
      "prefix": "F0400",
      "text": "Interview for Daily Preferences. Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0400A",
        "prefix": "F0400A",
        "text": "how important is it to you to choose what clothes to wear?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400B",
        "prefix": "F0400B",
        "text": "how important is it to you to take care of your personal belongings or things?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400C",
        "prefix": "F0400C",
        "text": "how important is it to you to choose between a tub bath, shower, bed bath, or sponge bath?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400D",
        "prefix": "F0400D",
        "text": "how important is it to you to have snacks available between meals?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400E",
        "prefix": "F0400E",
        "text": "how important is it to you to choose your own bedtime?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400F",
        "prefix": "F0400F",
        "text": "how important is it to you to have your family or a close friend involved in discussions about your care?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400G",
        "prefix": "F0400G",
        "text": "how important is it to you to be able to use the phone in private?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400H",
        "prefix": "F0400H",
        "text": "how important is it to you to have a place to lock your things to keep them safe?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0500",
      "prefix": "F0500",
      "text": "Interview for Activity Preferences: Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0500A",
        "prefix": "F0500A",
        "text": "how important is it to you to have books, newspapers, and magazines to read?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500B",
        "prefix": "F0500B",
        "text": "how important is it to you to listen to music you like?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500C",
        "prefix": "F0500C",
        "text": "how important is it to you to be around animals such as pets?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500D",
        "prefix": "F0500D",
        "text": "how important is it to you to keep up with the news?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500E",
        "prefix": "F0500E",
        "text": "how important is it to you to do things with groups of people?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500F",
        "prefix": "F0500F",
        "text": "how important is it to you to do your favorite activities?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500G",
        "prefix": "F0500G",
        "text": "how important is it to you to go outside to get fresh air when the weather is good?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500H",
        "prefix": "F0500H",
        "text": "how important is it to you to participate in religious services or practices?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0800",
      "prefix": "F0800",
      "text": "Staff Assessment of Daily and Activity Preferences. Do not conduct if Interview for Daily and Activity Preferences was completed. {Patient/Resident} Prefers: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Choosing clothes to wear"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Caring for personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Receiving tub bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Receiving shower"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Receiving bed bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Receiving sponge bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Snacks between meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Staying up past 8:00 p.m."
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Family or significant other involvement in care discussions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "J",
          "display": "Use of phone in private"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "K",
          "display": "Place to lock personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "L",
          "display": "Reading books, newspapers, or magazines"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "M",
          "display": "Listening to music"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Being around animals such as pets"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "O",
          "display": "Keeping up with the news"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "P",
          "display": "Doing things with groups of people"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Q",
          "display": "Participating in favorite activities"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "R",
          "display": "Spending time away from the nursing home"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "S",
          "display": "Spending time outdoors"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "T",
          "display": "Participating in religious activities or practices"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-6",
    "text": "Section F: Preferences for Customary Routine and Activities",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-6/F0300",
      "prefix": "F0300",
      "text": "Should Interview for Daily and Activity Preferences be Conducted? Attempt to interview all {patients/residents} able to communicate. If {patient/resident} is unable to complete, attempt to complete interview with family member or significant other",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood and family/significant other not available)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0600",
      "prefix": "F0600",
      "text": "Daily and Activity Preferences Primary Respondent. Indicate primary respondent for Daily and Activity Preferences",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "{Patient/Resident}"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Family or significant other (close friend or other representative)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Interview could not be completed by {patient/resident} or family/significant other (\"No response\" to 3 or more items)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0700",
      "prefix": "F0700",
      "text": "Should the Staff Assessment of Daily and Activity Preferences be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (because Interview for Daily and Activity Preferences was completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (because 3 or more items in Interview for Daily and Activity Preferences were not completed by {patient/resident} or family/significant other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-6/F0400",
      "prefix": "F0400",
      "text": "Interview for Daily Preferences. Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0400A",
        "prefix": "F0400A",
        "text": "how important is it to you to choose what clothes to wear?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400B",
        "prefix": "F0400B",
        "text": "how important is it to you to take care of your personal belongings or things?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400C",
        "prefix": "F0400C",
        "text": "how important is it to you to choose between a tub bath, shower, bed bath, or sponge bath?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400D",
        "prefix": "F0400D",
        "text": "how important is it to you to have snacks available between meals?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400E",
        "prefix": "F0400E",
        "text": "how important is it to you to choose your own bedtime?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400F",
        "prefix": "F0400F",
        "text": "how important is it to you to have your family or a close friend involved in discussions about your care?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400G",
        "prefix": "F0400G",
        "text": "how important is it to you to be able to use the phone in private?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0400H",
        "prefix": "F0400H",
        "text": "how important is it to you to have a place to lock your things to keep them safe?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0500",
      "prefix": "F0500",
      "text": "Interview for Activity Preferences: Show {patient/resident} the response options and say: \"While you are in this {facility/setting}...\"",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-6/F0500A",
        "prefix": "F0500A",
        "text": "how important is it to you to have books, newspapers, and magazines to read?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500B",
        "prefix": "F0500B",
        "text": "how important is it to you to listen to music you like?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500C",
        "prefix": "F0500C",
        "text": "how important is it to you to be around animals such as pets?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500D",
        "prefix": "F0500D",
        "text": "how important is it to you to keep up with the news?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500E",
        "prefix": "F0500E",
        "text": "how important is it to you to do things with groups of people?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500F",
        "prefix": "F0500F",
        "text": "how important is it to you to do your favorite activities?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500G",
        "prefix": "F0500G",
        "text": "how important is it to you to go outside to get fresh air when the weather is good?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-6/F0500H",
        "prefix": "F0500H",
        "text": "how important is it to you to participate in religious services or practices?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Somewhat important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not very important"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Not important at all"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Important, but can't do or no choice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "No response or non-responsive"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-6/F0800",
      "prefix": "F0800",
      "text": "Staff Assessment of Daily and Activity Preferences. Do not conduct if Interview for Daily and Activity Preferences was completed. {Patient/Resident} Prefers: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Choosing clothes to wear"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Caring for personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Receiving tub bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Receiving shower"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Receiving bed bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Receiving sponge bath"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Snacks between meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Staying up past 8:00 p.m."
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Family or significant other involvement in care discussions"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "J",
          "display": "Use of phone in private"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "K",
          "display": "Place to lock personal belongings"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "L",
          "display": "Reading books, newspapers, or magazines"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "M",
          "display": "Listening to music"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "N",
          "display": "Being around animals such as pets"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "O",
          "display": "Keeping up with the news"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "P",
          "display": "Doing things with groups of people"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Q",
          "display": "Participating in favorite activities"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "R",
          "display": "Spending time away from the nursing home"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "S",
          "display": "Spending time outdoors"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "T",
          "display": "Participating in religious activities or practices"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-7",
    "text": "Section G: Functional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-7/G0110",
      "prefix": "G0110",
      "text": "Activities of Daily Living (ADL) Assistance. Refer to the ADL flow chart in the {manual} to facilitate accurate coding",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0110_1",
        "prefix": "G0110_1",
        "text": "Activities of Daily Living (ADL) Assistance. Code for the {patient's/resident's} performance over all shifts - not including set-up. If the ADL activity occurred 3 or more times at various levels of assistance, code the most-dependent - except for total dependence, which requires full staff performance every time.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-7/G0110_2",
        "prefix": "G0110_2",
        "text": "Activities of Daily Living (ADL) assistance. Code for most support provided over all shifts; code regardless of {patient's/resident's} self-performance classification",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-7/G0110J1",
        "prefix": "G0110J1",
        "text": "Personal hygiene - how {patient/resident} maintains personal hygiene, including combing hair, brushing teeth, shaving, applying makeup, washing/drying face and hands (excludes baths and showers) - Self-Performance",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Independent - no help or staff oversight at any time"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Supervision - oversight, encouragement or cueing"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Limited assistance - {patient/resident} highly involved in activity; staff provide guided maneuvering of limbs or other non-weight-bearing assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Extensive assistance - {patient/resident} involved in activity, staff provide weight-bearing support"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Total dependence - full staff performance every time during entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Activity occurred only once or twice - activity did occur but only once or twice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur - activity did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0110J2",
        "prefix": "G0110J2",
        "text": "Personal hygiene - how {patient/resident} maintains personal hygiene, including combing hair, brushing teeth, shaving, applying makeup, washing/drying face and hands (excludes baths and showers) - Support",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No setup or physical help from staff"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Setup help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "One person physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Two+ persons physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "ADL activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0120",
      "prefix": "G0120",
      "text": "Bathing. How {patient/resident} takes full-body bath/shower, sponge bath, and transfers in/out of tub/shower (excludes washing of back and hair). Code for most dependent in self-performance and support",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0120A",
        "prefix": "G0120A",
        "text": "Bathing - Self performance",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Independent - no help provided"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Supervision - oversight help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Physical help limited to transfer only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Physical help in part of bathing activity"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Total dependence"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0120B",
        "prefix": "G0120B",
        "text": "Bathing - Support provided. (Bathing support codes are as defined in {ADL question, column 2, ADL Support Provided})",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No setup or physical help from staff"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Setup help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "One person physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Two+ persons physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "ADL activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0300",
      "prefix": "G0300",
      "text": "Balance During Transitions and Walking. After observing the {patient/resident}, code the following walking and transition items for most dependent.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0300A",
        "prefix": "G0300A",
        "text": "Moving from seated to standing position",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300B",
        "prefix": "G0300B",
        "text": "Walking (with assistive device if used)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300C",
        "prefix": "G0300C",
        "text": "Turning around and facing the opposite direction while walking",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300D",
        "prefix": "G0300D",
        "text": "Moving on and off toilet",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300E",
        "prefix": "G0300E",
        "text": "Surface-to-surface transfer (transfer between bed and chair or wheelchair)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0400",
      "prefix": "G0400",
      "text": "Functional Limitation in Range of Motion. Code for limitation that interfered with daily functions or placed {patient/resident} at risk of injury",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0400A",
        "prefix": "G0400A",
        "text": "Upper extremity (shoulder, elbow, wrist, hand)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No impairment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Impairment on one side"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Impairment on both sides"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0400B",
        "prefix": "G0400B",
        "text": "Lower extremity (hip, knee, ankle, foot)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No impairment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Impairment on one side"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Impairment on both sides"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0900",
      "prefix": "G0900",
      "text": "Functional Rehabilitation Potential. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0900A",
        "prefix": "G0900A",
        "text": "{Patient/Resident} believes he or she is capable of increased independence in at least some ADL's",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-7/G0900B",
        "prefix": "G0900B",
        "text": "Direct care staff believe {patient/resident} is capable of increased independence in at least some ADL's",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0600",
      "prefix": "G0600",
      "text": "Mobility Devices: Check all that were normally used",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Cane/crutch"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Walker"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Wheelchair (manual or electric)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Limb prosthesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were used"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-7",
    "text": "Section G: Functional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-7/G0110",
      "prefix": "G0110",
      "text": "Activities of Daily Living (ADL) Assistance. Refer to the ADL flow chart in the {manual} to facilitate accurate coding",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0110_1",
        "prefix": "G0110_1",
        "text": "Activities of Daily Living (ADL) Assistance. Code for the {patient's/resident's} performance over all shifts - not including set-up. If the ADL activity occurred 3 or more times at various levels of assistance, code the most-dependent - except for total dependence, which requires full staff performance every time.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-7/G0110_2",
        "prefix": "G0110_2",
        "text": "Activities of Daily Living (ADL) assistance. Code for most support provided over all shifts; code regardless of {patient's/resident's} self-performance classification",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-7/G0110J1",
        "prefix": "G0110J1",
        "text": "Personal hygiene - how {patient/resident} maintains personal hygiene, including combing hair, brushing teeth, shaving, applying makeup, washing/drying face and hands (excludes baths and showers) - Self-Performance",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Independent - no help or staff oversight at any time"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Supervision - oversight, encouragement or cueing"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Limited assistance - {patient/resident} highly involved in activity; staff provide guided maneuvering of limbs or other non-weight-bearing assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Extensive assistance - {patient/resident} involved in activity, staff provide weight-bearing support"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Total dependence - full staff performance every time during entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Activity occurred only once or twice - activity did occur but only once or twice"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur - activity did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0110J2",
        "prefix": "G0110J2",
        "text": "Personal hygiene - how {patient/resident} maintains personal hygiene, including combing hair, brushing teeth, shaving, applying makeup, washing/drying face and hands (excludes baths and showers) - Support",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No setup or physical help from staff"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Setup help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "One person physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Two+ persons physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "ADL activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0120",
      "prefix": "G0120",
      "text": "Bathing. How {patient/resident} takes full-body bath/shower, sponge bath, and transfers in/out of tub/shower (excludes washing of back and hair). Code for most dependent in self-performance and support",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0120A",
        "prefix": "G0120A",
        "text": "Bathing - Self performance",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Independent - no help provided"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Supervision - oversight help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Physical help limited to transfer only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Physical help in part of bathing activity"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Total dependence"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0120B",
        "prefix": "G0120B",
        "text": "Bathing - Support provided. (Bathing support codes are as defined in {ADL question, column 2, ADL Support Provided})",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No setup or physical help from staff"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Setup help only"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "One person physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Two+ persons physical assist"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "ADL activity itself did not occur or family and/or non-facility staff provided care 100% of the time for that activity over the entire 7-day period"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0300",
      "prefix": "G0300",
      "text": "Balance During Transitions and Walking. After observing the {patient/resident}, code the following walking and transition items for most dependent.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0300A",
        "prefix": "G0300A",
        "text": "Moving from seated to standing position",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300B",
        "prefix": "G0300B",
        "text": "Walking (with assistive device if used)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300C",
        "prefix": "G0300C",
        "text": "Turning around and facing the opposite direction while walking",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300D",
        "prefix": "G0300D",
        "text": "Moving on and off toilet",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0300E",
        "prefix": "G0300E",
        "text": "Surface-to-surface transfer (transfer between bed and chair or wheelchair)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Steady at all times"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not steady, but able to stabilize without staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Not steady, only able to stabilize with staff assistance"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Activity did not occur"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0400",
      "prefix": "G0400",
      "text": "Functional Limitation in Range of Motion. Code for limitation that interfered with daily functions or placed {patient/resident} at risk of injury",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0400A",
        "prefix": "G0400A",
        "text": "Upper extremity (shoulder, elbow, wrist, hand)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No impairment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Impairment on one side"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Impairment on both sides"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-7/G0400B",
        "prefix": "G0400B",
        "text": "Lower extremity (hip, knee, ankle, foot)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No impairment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Impairment on one side"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Impairment on both sides"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0900",
      "prefix": "G0900",
      "text": "Functional Rehabilitation Potential. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-7/G0900A",
        "prefix": "G0900A",
        "text": "{Patient/Resident} believes he or she is capable of increased independence in at least some ADL's",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-7/G0900B",
        "prefix": "G0900B",
        "text": "Direct care staff believe {patient/resident} is capable of increased independence in at least some ADL's",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-7/G0600",
      "prefix": "G0600",
      "text": "Mobility Devices: Check all that were normally used",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Cane/crutch"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Walker"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Wheelchair (manual or electric)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Limb prosthesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were used"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-8",
    "text": "Section H: Bladder and Bowel",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-8/H0300",
      "prefix": "H0300",
      "text": "Urinary continence - Select the one category that best describes the {patient/resident}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (less than 7 episodes of incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (7 or more episodes of urinary incontinence, but at least one episode of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had a catheter (indwelling, condom), urinary ostomy, or no urine output for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0400",
      "prefix": "H0400",
      "text": "Bowel Continence - Select the one category that best describes the {patient/resident}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (one episode of bowel incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (2 or more episodes of bowel incontinence, but at least one continent bowel movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent bowel movements)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had an ostomy or did not have a bowel movement for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0500",
      "prefix": "H0500",
      "text": "Bowel Toileting Program. Is a toileting program currently being used to manage the {patient's/resident's} bowel continence?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0600",
      "prefix": "H0600",
      "text": "Bowel Patterns. Constipation present?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0200",
      "prefix": "H0200",
      "text": "Urinary Toileting Program",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-8/H0200A",
        "prefix": "H0200A",
        "text": "Has a trial of a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) been attempted on {admission} or since urinary incontinence was noted in this {facility/setting}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200B",
        "prefix": "H0200B",
        "text": "Response - What was the {patient's/resident's} response to the trial program?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No improvement"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Decreased wetness"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Completely dry (continent)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine or trial in progress"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200C",
        "prefix": "H0200C",
        "text": "Current toileting program or trial - Is a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) currently being used to manage the {patient's/resident's} urinary continence?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-8/H0100",
      "prefix": "H0100",
      "text": "Appliances: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Indwelling catheter (including suprapubic catheter and nephrostomy tube)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "External catheter"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Ostomy (including urostomy, ileostomy, and colostomy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Intermittent catheterization"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-8",
    "text": "Section H: Bladder and Bowel",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-8/H0300",
      "prefix": "H0300",
      "text": "Urinary continence - Select the one category that best describes the {patient/resident}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (less than 7 episodes of incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (7 or more episodes of urinary incontinence, but at least one episode of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had a catheter (indwelling, condom), urinary ostomy, or no urine output for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0400",
      "prefix": "H0400",
      "text": "Bowel Continence - Select the one category that best describes the {patient/resident}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (one episode of bowel incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (2 or more episodes of bowel incontinence, but at least one continent bowel movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent bowel movements)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had an ostomy or did not have a bowel movement for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0500",
      "prefix": "H0500",
      "text": "Bowel Toileting Program. Is a toileting program currently being used to manage the {patient's/resident's} bowel continence?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0600",
      "prefix": "H0600",
      "text": "Bowel Patterns. Constipation present?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0200",
      "prefix": "H0200",
      "text": "Urinary Toileting Program",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-8/H0200A",
        "prefix": "H0200A",
        "text": "Has a trial of a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) been attempted on {admission} or since urinary incontinence was noted in this {facility/setting}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200B",
        "prefix": "H0200B",
        "text": "Response - What was the {patient's/resident's} response to the trial program?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No improvement"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Decreased wetness"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Completely dry (continent)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine or trial in progress"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200C",
        "prefix": "H0200C",
        "text": "Current toileting program or trial - Is a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) currently being used to manage the {patient's/resident's} urinary continence?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-8/H0100",
      "prefix": "H0100",
      "text": "Appliances: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Indwelling catheter (including suprapubic catheter and nephrostomy tube)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "External catheter"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Ostomy (including urostomy, ileostomy, and colostomy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Intermittent catheterization"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-8",
    "text": "Section H: Bladder and Bowel",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-8/H0300",
      "prefix": "H0300",
      "text": "Urinary continence - Select the one category that best describes the {patient/resident}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (less than 7 episodes of incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (7 or more episodes of urinary incontinence, but at least one episode of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had a catheter (indwelling, condom), urinary ostomy, or no urine output for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0400",
      "prefix": "H0400",
      "text": "Bowel Continence - Select the one category that best describes the {patient/resident}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (one episode of bowel incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (2 or more episodes of bowel incontinence, but at least one continent bowel movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent bowel movements)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had an ostomy or did not have a bowel movement for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0500",
      "prefix": "H0500",
      "text": "Bowel Toileting Program. Is a toileting program currently being used to manage the {patient's/resident's} bowel continence?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0600",
      "prefix": "H0600",
      "text": "Bowel Patterns. Constipation present?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0200",
      "prefix": "H0200",
      "text": "Urinary Toileting Program",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-8/H0200A",
        "prefix": "H0200A",
        "text": "Has a trial of a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) been attempted on {admission} or since urinary incontinence was noted in this {facility/setting}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200B",
        "prefix": "H0200B",
        "text": "Response - What was the {patient's/resident's} response to the trial program?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No improvement"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Decreased wetness"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Completely dry (continent)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine or trial in progress"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200C",
        "prefix": "H0200C",
        "text": "Current toileting program or trial - Is a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) currently being used to manage the {patient's/resident's} urinary continence?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-8/H0100",
      "prefix": "H0100",
      "text": "Appliances: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Indwelling catheter (including suprapubic catheter and nephrostomy tube)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "External catheter"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Ostomy (including urostomy, ileostomy, and colostomy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Intermittent catheterization"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-8",
    "text": "Section H: Bladder and Bowel",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-8/H0300",
      "prefix": "H0300",
      "text": "Urinary continence - Select the one category that best describes the {patient/resident}",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (less than 7 episodes of incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (7 or more episodes of urinary incontinence, but at least one episode of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent voiding)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had a catheter (indwelling, condom), urinary ostomy, or no urine output for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0400",
      "prefix": "H0400",
      "text": "Bowel Continence - Select the one category that best describes the {patient/resident}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Always continent"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Occasionally incontinent (one episode of bowel incontinence)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently incontinent (2 or more episodes of bowel incontinence, but at least one continent bowel movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Always incontinent (no episodes of continent bowel movements)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Not rated, {patient/resident} had an ostomy or did not have a bowel movement for the entire 7 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0500",
      "prefix": "H0500",
      "text": "Bowel Toileting Program. Is a toileting program currently being used to manage the {patient's/resident's} bowel continence?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0600",
      "prefix": "H0600",
      "text": "Bowel Patterns. Constipation present?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-8/H0200",
      "prefix": "H0200",
      "text": "Urinary Toileting Program",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-8/H0200A",
        "prefix": "H0200A",
        "text": "Has a trial of a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) been attempted on {admission} or since urinary incontinence was noted in this {facility/setting}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200B",
        "prefix": "H0200B",
        "text": "Response - What was the {patient's/resident's} response to the trial program?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No improvement"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Decreased wetness"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Completely dry (continent)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine or trial in progress"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-8/H0200C",
        "prefix": "H0200C",
        "text": "Current toileting program or trial - Is a toileting program (e.g., scheduled toileting, prompted voiding, or bladder training) currently being used to manage the {patient's/resident's} urinary continence?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-8/H0100",
      "prefix": "H0100",
      "text": "Appliances: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Indwelling catheter (including suprapubic catheter and nephrostomy tube)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "External catheter"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Ostomy (including urostomy, ileostomy, and colostomy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Intermittent catheterization"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-9",
    "text": "Section I: Active Diagnoses",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-9/I8000",
      "prefix": "I8000",
      "text": "Additional active diagnoses. Enter diagnosis on line and ICD code in boxes. Include the decimal for the code in the appropriate box.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-9/I8000A",
        "prefix": "I8000A",
        "text": "Additional active diagnosis A.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000B",
        "prefix": "I8000B",
        "text": "Additional active diagnosis B.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000C",
        "prefix": "I8000C",
        "text": "Additional active diagnosis C.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000D",
        "prefix": "I8000D",
        "text": "Additional active diagnosis D.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000E",
        "prefix": "I8000E",
        "text": "Additional active diagnosis E.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000F",
        "prefix": "I8000F",
        "text": "Additional active diagnosis F.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000G",
        "prefix": "I8000G",
        "text": "Additional active diagnosis G.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000H",
        "prefix": "I8000H",
        "text": "Additional active diagnosis H.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000I",
        "prefix": "I8000I",
        "text": "Additional active diagnosis I.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000J",
        "prefix": "I8000J",
        "text": "Additional active diagnosis J.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-9/I0000",
      "prefix": "I0000",
      "text": "Active Diagnoses in the last 7 days: Check all that apply. Diagnoses listed in parentheses are provided as examples and should not be considered as all-inclusive lists",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0100",
          "display": "Cancer (with or without metastasis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0200",
          "display": "Anemia (e.g., aplastic, iron deficiency, pernicious, and sickle cell)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0300",
          "display": "Atrial Fibrillation or Other Dysrhythmias (e.g., bradycardias and tachycardias)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0400",
          "display": "Coronary Artery Disease (CAD) (e.g., angina, myocardial infarction, and atherosclerotic heart disease (ASHD))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0500",
          "display": "Deep Venous Thrombosis (DVT), Pulmonary Embolus (PE), or Pulmonary Thrombo-Embolism (PTE)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0600",
          "display": "Heart Failure (e.g., congestive heart failure (CHF) and pulmonary edema)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0700",
          "display": "Hypertension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0800",
          "display": "Orthostatic Hypotension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0900",
          "display": "Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1100",
          "display": "Cirrhosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1200",
          "display": "Gastroesophageal Reflux Disease (GERD) or Ulcer (e.g., esophageal, gastric, and peptic ulcers)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1300",
          "display": "Ulcerative Colitis, Crohn's Disease, or Inflammatory Bowel Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1400",
          "display": "Benign Prostatic Hyperplasia (BPH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1500",
          "display": "Renal Insufficiency, Renal Failure, or End-Stage Renal Disease (ESRD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1550",
          "display": "Neurogenic Bladder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1650",
          "display": "Obstructive Uropathy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1700",
          "display": "Multidrug-Resistant Organism (MDRO)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2000",
          "display": "Pneumonia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2100",
          "display": "Septicemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2200",
          "display": "Tuberculosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2300",
          "display": "Urinary Tract Infection (UTI) (LAST 30 DAYS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2400",
          "display": "Viral Hepatitis (e.g., Hepatitis A, B, C, D, and E)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2500",
          "display": "Wound Infection (other than foot)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2900",
          "display": "Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3100",
          "display": "Hyponatremia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3200",
          "display": "Hyperkalemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3300",
          "display": "Hyperlipidemia (e.g., hypercholesterolemia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3400",
          "display": "Thyroid Disorder (e.g., hypothyroidism, hyperthyroidism, and Hashimoto's thyroiditis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3700",
          "display": "Arthritis (e.g., degenerative joint disease (DJD), osteoarthritis, and rheumatoid arthritis (RA))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3800",
          "display": "Osteoporosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3900",
          "display": "Hip Fracture - any hip fracture that has a relationship to current status, treatments, monitoring (e.g., sub-capital fractures, and fractures of the trochanter and femoral neck)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4000",
          "display": "Other Fracture"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4200",
          "display": "Alzheimer's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4300",
          "display": "Aphasia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4400",
          "display": "Cerebral Palsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4500",
          "display": "Cerebrovascular Accident (CVA), Transient Ischemic Attack (TIA), or Stroke"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4800",
          "display": "Non-Alzheimer's Dementia (e.g. Lewy body dementia, vascular or multi-infarct dementia; mixed dementia; frontotemporal dementia such as Pick's disease; and dementia related to stroke, Parkinson's or Creutzfeldt-Jakob diseases)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4900",
          "display": "Hemiplegia or Hemiparesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5000",
          "display": "Paraplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5100",
          "display": "Quadriplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5200",
          "display": "Multiple Sclerosis (MS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5250",
          "display": "Huntington's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5300",
          "display": "Parkinson's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5350",
          "display": "Tourette's Syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5400",
          "display": "Seizure Disorder or Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5500",
          "display": "Traumatic Brain Injury (TBI)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5600",
          "display": "Malnutrition (protein or calorie) or at risk for malnutrition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5700",
          "display": "Anxiety Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5800",
          "display": "Depression (other than bipolar)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5900",
          "display": "Bipolar Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5950",
          "display": "Psychotic Disorder (other than schizophrenia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6000",
          "display": "Schizophrenia (e.g., schizoaffective and schizophreniform disorders)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6100",
          "display": "Post Traumatic Stress Disorder (PTSD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6200",
          "display": "Asthma, Chronic Obstructive Pulmonary Disease (COPD), or Chronic Lung Disease (e.g., chronic bronchitis and restrictive lung diseases such as asbestosis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6300",
          "display": "Respiratory Failure"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6500",
          "display": "Cataracts, Glaucoma, or Macular Degeneration"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I7900",
          "display": "None of the above active diagnoses"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-9",
    "text": "Section I: Active Diagnoses",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-9/I8000",
      "prefix": "I8000",
      "text": "Additional active diagnoses. Enter diagnosis on line and ICD code in boxes. Include the decimal for the code in the appropriate box.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-9/I8000A",
        "prefix": "I8000A",
        "text": "Additional active diagnosis A.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000B",
        "prefix": "I8000B",
        "text": "Additional active diagnosis B.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000C",
        "prefix": "I8000C",
        "text": "Additional active diagnosis C.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000D",
        "prefix": "I8000D",
        "text": "Additional active diagnosis D.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000E",
        "prefix": "I8000E",
        "text": "Additional active diagnosis E.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000F",
        "prefix": "I8000F",
        "text": "Additional active diagnosis F.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000G",
        "prefix": "I8000G",
        "text": "Additional active diagnosis G.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000H",
        "prefix": "I8000H",
        "text": "Additional active diagnosis H.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000I",
        "prefix": "I8000I",
        "text": "Additional active diagnosis I.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000J",
        "prefix": "I8000J",
        "text": "Additional active diagnosis J.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-9/I0000",
      "prefix": "I0000",
      "text": "Active Diagnoses in the last 7 days: Check all that apply. Diagnoses listed in parentheses are provided as examples and should not be considered as all-inclusive lists",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0100",
          "display": "Cancer (with or without metastasis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0200",
          "display": "Anemia (e.g., aplastic, iron deficiency, pernicious, and sickle cell)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0300",
          "display": "Atrial Fibrillation or Other Dysrhythmias (e.g., bradycardias and tachycardias)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0400",
          "display": "Coronary Artery Disease (CAD) (e.g., angina, myocardial infarction, and atherosclerotic heart disease (ASHD))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0500",
          "display": "Deep Venous Thrombosis (DVT), Pulmonary Embolus (PE), or Pulmonary Thrombo-Embolism (PTE)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0600",
          "display": "Heart Failure (e.g., congestive heart failure (CHF) and pulmonary edema)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0700",
          "display": "Hypertension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0800",
          "display": "Orthostatic Hypotension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0900",
          "display": "Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1100",
          "display": "Cirrhosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1200",
          "display": "Gastroesophageal Reflux Disease (GERD) or Ulcer (e.g., esophageal, gastric, and peptic ulcers)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1300",
          "display": "Ulcerative Colitis, Crohn's Disease, or Inflammatory Bowel Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1400",
          "display": "Benign Prostatic Hyperplasia (BPH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1500",
          "display": "Renal Insufficiency, Renal Failure, or End-Stage Renal Disease (ESRD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1550",
          "display": "Neurogenic Bladder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1650",
          "display": "Obstructive Uropathy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1700",
          "display": "Multidrug-Resistant Organism (MDRO)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2000",
          "display": "Pneumonia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2100",
          "display": "Septicemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2200",
          "display": "Tuberculosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2300",
          "display": "Urinary Tract Infection (UTI) (LAST 30 DAYS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2400",
          "display": "Viral Hepatitis (e.g., Hepatitis A, B, C, D, and E)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2500",
          "display": "Wound Infection (other than foot)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2900",
          "display": "Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3100",
          "display": "Hyponatremia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3200",
          "display": "Hyperkalemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3300",
          "display": "Hyperlipidemia (e.g., hypercholesterolemia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3400",
          "display": "Thyroid Disorder (e.g., hypothyroidism, hyperthyroidism, and Hashimoto's thyroiditis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3700",
          "display": "Arthritis (e.g., degenerative joint disease (DJD), osteoarthritis, and rheumatoid arthritis (RA))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3800",
          "display": "Osteoporosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3900",
          "display": "Hip Fracture - any hip fracture that has a relationship to current status, treatments, monitoring (e.g., sub-capital fractures, and fractures of the trochanter and femoral neck)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4000",
          "display": "Other Fracture"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4200",
          "display": "Alzheimer's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4300",
          "display": "Aphasia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4400",
          "display": "Cerebral Palsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4500",
          "display": "Cerebrovascular Accident (CVA), Transient Ischemic Attack (TIA), or Stroke"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4800",
          "display": "Non-Alzheimer's Dementia (e.g. Lewy body dementia, vascular or multi-infarct dementia; mixed dementia; frontotemporal dementia such as Pick's disease; and dementia related to stroke, Parkinson's or Creutzfeldt-Jakob diseases)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4900",
          "display": "Hemiplegia or Hemiparesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5000",
          "display": "Paraplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5100",
          "display": "Quadriplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5200",
          "display": "Multiple Sclerosis (MS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5250",
          "display": "Huntington's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5300",
          "display": "Parkinson's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5350",
          "display": "Tourette's Syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5400",
          "display": "Seizure Disorder or Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5500",
          "display": "Traumatic Brain Injury (TBI)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5600",
          "display": "Malnutrition (protein or calorie) or at risk for malnutrition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5700",
          "display": "Anxiety Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5800",
          "display": "Depression (other than bipolar)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5900",
          "display": "Bipolar Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5950",
          "display": "Psychotic Disorder (other than schizophrenia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6000",
          "display": "Schizophrenia (e.g., schizoaffective and schizophreniform disorders)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6100",
          "display": "Post Traumatic Stress Disorder (PTSD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6200",
          "display": "Asthma, Chronic Obstructive Pulmonary Disease (COPD), or Chronic Lung Disease (e.g., chronic bronchitis and restrictive lung diseases such as asbestosis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6300",
          "display": "Respiratory Failure"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6500",
          "display": "Cataracts, Glaucoma, or Macular Degeneration"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I7900",
          "display": "None of the above active diagnoses"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-9",
    "text": "Section I: Active Diagnoses",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-9/I8000",
      "prefix": "I8000",
      "text": "Additional active diagnoses. Enter diagnosis on line and ICD code in boxes. Include the decimal for the code in the appropriate box.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-9/I8000A",
        "prefix": "I8000A",
        "text": "Additional active diagnosis A.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000B",
        "prefix": "I8000B",
        "text": "Additional active diagnosis B.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000C",
        "prefix": "I8000C",
        "text": "Additional active diagnosis C.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000D",
        "prefix": "I8000D",
        "text": "Additional active diagnosis D.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000E",
        "prefix": "I8000E",
        "text": "Additional active diagnosis E.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000F",
        "prefix": "I8000F",
        "text": "Additional active diagnosis F.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000G",
        "prefix": "I8000G",
        "text": "Additional active diagnosis G.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000H",
        "prefix": "I8000H",
        "text": "Additional active diagnosis H.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000I",
        "prefix": "I8000I",
        "text": "Additional active diagnosis I.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000J",
        "prefix": "I8000J",
        "text": "Additional active diagnosis J.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-9/I0000",
      "prefix": "I0000",
      "text": "Active Diagnoses in the last 7 days: Check all that apply. Diagnoses listed in parentheses are provided as examples and should not be considered as all-inclusive lists",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0100",
          "display": "Cancer (with or without metastasis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0200",
          "display": "Anemia (e.g., aplastic, iron deficiency, pernicious, and sickle cell)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0300",
          "display": "Atrial Fibrillation or Other Dysrhythmias (e.g., bradycardias and tachycardias)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0400",
          "display": "Coronary Artery Disease (CAD) (e.g., angina, myocardial infarction, and atherosclerotic heart disease (ASHD))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0500",
          "display": "Deep Venous Thrombosis (DVT), Pulmonary Embolus (PE), or Pulmonary Thrombo-Embolism (PTE)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0600",
          "display": "Heart Failure (e.g., congestive heart failure (CHF) and pulmonary edema)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0700",
          "display": "Hypertension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0800",
          "display": "Orthostatic Hypotension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0900",
          "display": "Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1100",
          "display": "Cirrhosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1200",
          "display": "Gastroesophageal Reflux Disease (GERD) or Ulcer (e.g., esophageal, gastric, and peptic ulcers)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1300",
          "display": "Ulcerative Colitis, Crohn's Disease, or Inflammatory Bowel Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1400",
          "display": "Benign Prostatic Hyperplasia (BPH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1500",
          "display": "Renal Insufficiency, Renal Failure, or End-Stage Renal Disease (ESRD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1550",
          "display": "Neurogenic Bladder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1650",
          "display": "Obstructive Uropathy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1700",
          "display": "Multidrug-Resistant Organism (MDRO)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2000",
          "display": "Pneumonia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2100",
          "display": "Septicemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2200",
          "display": "Tuberculosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2300",
          "display": "Urinary Tract Infection (UTI) (LAST 30 DAYS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2400",
          "display": "Viral Hepatitis (e.g., Hepatitis A, B, C, D, and E)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2500",
          "display": "Wound Infection (other than foot)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2900",
          "display": "Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3100",
          "display": "Hyponatremia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3200",
          "display": "Hyperkalemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3300",
          "display": "Hyperlipidemia (e.g., hypercholesterolemia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3400",
          "display": "Thyroid Disorder (e.g., hypothyroidism, hyperthyroidism, and Hashimoto's thyroiditis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3700",
          "display": "Arthritis (e.g., degenerative joint disease (DJD), osteoarthritis, and rheumatoid arthritis (RA))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3800",
          "display": "Osteoporosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3900",
          "display": "Hip Fracture - any hip fracture that has a relationship to current status, treatments, monitoring (e.g., sub-capital fractures, and fractures of the trochanter and femoral neck)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4000",
          "display": "Other Fracture"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4200",
          "display": "Alzheimer's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4300",
          "display": "Aphasia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4400",
          "display": "Cerebral Palsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4500",
          "display": "Cerebrovascular Accident (CVA), Transient Ischemic Attack (TIA), or Stroke"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4800",
          "display": "Non-Alzheimer's Dementia (e.g. Lewy body dementia, vascular or multi-infarct dementia; mixed dementia; frontotemporal dementia such as Pick's disease; and dementia related to stroke, Parkinson's or Creutzfeldt-Jakob diseases)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4900",
          "display": "Hemiplegia or Hemiparesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5000",
          "display": "Paraplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5100",
          "display": "Quadriplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5200",
          "display": "Multiple Sclerosis (MS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5250",
          "display": "Huntington's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5300",
          "display": "Parkinson's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5350",
          "display": "Tourette's Syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5400",
          "display": "Seizure Disorder or Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5500",
          "display": "Traumatic Brain Injury (TBI)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5600",
          "display": "Malnutrition (protein or calorie) or at risk for malnutrition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5700",
          "display": "Anxiety Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5800",
          "display": "Depression (other than bipolar)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5900",
          "display": "Bipolar Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5950",
          "display": "Psychotic Disorder (other than schizophrenia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6000",
          "display": "Schizophrenia (e.g., schizoaffective and schizophreniform disorders)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6100",
          "display": "Post Traumatic Stress Disorder (PTSD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6200",
          "display": "Asthma, Chronic Obstructive Pulmonary Disease (COPD), or Chronic Lung Disease (e.g., chronic bronchitis and restrictive lung diseases such as asbestosis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6300",
          "display": "Respiratory Failure"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6500",
          "display": "Cataracts, Glaucoma, or Macular Degeneration"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I7900",
          "display": "None of the above active diagnoses"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-9",
    "text": "Section I: Active Diagnoses",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-9/I8000",
      "prefix": "I8000",
      "text": "Additional active diagnoses. Enter diagnosis on line and ICD code in boxes. Include the decimal for the code in the appropriate box.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-9/I8000A",
        "prefix": "I8000A",
        "text": "Additional active diagnosis A.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000B",
        "prefix": "I8000B",
        "text": "Additional active diagnosis B.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000C",
        "prefix": "I8000C",
        "text": "Additional active diagnosis C.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000D",
        "prefix": "I8000D",
        "text": "Additional active diagnosis D.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000E",
        "prefix": "I8000E",
        "text": "Additional active diagnosis E.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000F",
        "prefix": "I8000F",
        "text": "Additional active diagnosis F.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000G",
        "prefix": "I8000G",
        "text": "Additional active diagnosis G.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000H",
        "prefix": "I8000H",
        "text": "Additional active diagnosis H.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000I",
        "prefix": "I8000I",
        "text": "Additional active diagnosis I.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000J",
        "prefix": "I8000J",
        "text": "Additional active diagnosis J.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-9/I0000",
      "prefix": "I0000",
      "text": "Active Diagnoses in the last 7 days: Check all that apply. Diagnoses listed in parentheses are provided as examples and should not be considered as all-inclusive lists",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0100",
          "display": "Cancer (with or without metastasis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0200",
          "display": "Anemia (e.g., aplastic, iron deficiency, pernicious, and sickle cell)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0300",
          "display": "Atrial Fibrillation or Other Dysrhythmias (e.g., bradycardias and tachycardias)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0400",
          "display": "Coronary Artery Disease (CAD) (e.g., angina, myocardial infarction, and atherosclerotic heart disease (ASHD))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0500",
          "display": "Deep Venous Thrombosis (DVT), Pulmonary Embolus (PE), or Pulmonary Thrombo-Embolism (PTE)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0600",
          "display": "Heart Failure (e.g., congestive heart failure (CHF) and pulmonary edema)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0700",
          "display": "Hypertension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0800",
          "display": "Orthostatic Hypotension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0900",
          "display": "Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1100",
          "display": "Cirrhosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1200",
          "display": "Gastroesophageal Reflux Disease (GERD) or Ulcer (e.g., esophageal, gastric, and peptic ulcers)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1300",
          "display": "Ulcerative Colitis, Crohn's Disease, or Inflammatory Bowel Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1400",
          "display": "Benign Prostatic Hyperplasia (BPH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1500",
          "display": "Renal Insufficiency, Renal Failure, or End-Stage Renal Disease (ESRD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1550",
          "display": "Neurogenic Bladder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1650",
          "display": "Obstructive Uropathy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1700",
          "display": "Multidrug-Resistant Organism (MDRO)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2000",
          "display": "Pneumonia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2100",
          "display": "Septicemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2200",
          "display": "Tuberculosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2300",
          "display": "Urinary Tract Infection (UTI) (LAST 30 DAYS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2400",
          "display": "Viral Hepatitis (e.g., Hepatitis A, B, C, D, and E)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2500",
          "display": "Wound Infection (other than foot)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2900",
          "display": "Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3100",
          "display": "Hyponatremia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3200",
          "display": "Hyperkalemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3300",
          "display": "Hyperlipidemia (e.g., hypercholesterolemia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3400",
          "display": "Thyroid Disorder (e.g., hypothyroidism, hyperthyroidism, and Hashimoto's thyroiditis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3700",
          "display": "Arthritis (e.g., degenerative joint disease (DJD), osteoarthritis, and rheumatoid arthritis (RA))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3800",
          "display": "Osteoporosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3900",
          "display": "Hip Fracture - any hip fracture that has a relationship to current status, treatments, monitoring (e.g., sub-capital fractures, and fractures of the trochanter and femoral neck)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4000",
          "display": "Other Fracture"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4200",
          "display": "Alzheimer's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4300",
          "display": "Aphasia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4400",
          "display": "Cerebral Palsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4500",
          "display": "Cerebrovascular Accident (CVA), Transient Ischemic Attack (TIA), or Stroke"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4800",
          "display": "Non-Alzheimer's Dementia (e.g. Lewy body dementia, vascular or multi-infarct dementia; mixed dementia; frontotemporal dementia such as Pick's disease; and dementia related to stroke, Parkinson's or Creutzfeldt-Jakob diseases)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4900",
          "display": "Hemiplegia or Hemiparesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5000",
          "display": "Paraplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5100",
          "display": "Quadriplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5200",
          "display": "Multiple Sclerosis (MS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5250",
          "display": "Huntington's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5300",
          "display": "Parkinson's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5350",
          "display": "Tourette's Syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5400",
          "display": "Seizure Disorder or Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5500",
          "display": "Traumatic Brain Injury (TBI)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5600",
          "display": "Malnutrition (protein or calorie) or at risk for malnutrition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5700",
          "display": "Anxiety Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5800",
          "display": "Depression (other than bipolar)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5900",
          "display": "Bipolar Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5950",
          "display": "Psychotic Disorder (other than schizophrenia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6000",
          "display": "Schizophrenia (e.g., schizoaffective and schizophreniform disorders)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6100",
          "display": "Post Traumatic Stress Disorder (PTSD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6200",
          "display": "Asthma, Chronic Obstructive Pulmonary Disease (COPD), or Chronic Lung Disease (e.g., chronic bronchitis and restrictive lung diseases such as asbestosis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6300",
          "display": "Respiratory Failure"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6500",
          "display": "Cataracts, Glaucoma, or Macular Degeneration"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I7900",
          "display": "None of the above active diagnoses"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-9",
    "text": "Section I: Active Diagnoses",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-9/I8000",
      "prefix": "I8000",
      "text": "Additional active diagnoses. Enter diagnosis on line and ICD code in boxes. Include the decimal for the code in the appropriate box.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-9/I8000A",
        "prefix": "I8000A",
        "text": "Additional active diagnosis A.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000B",
        "prefix": "I8000B",
        "text": "Additional active diagnosis B.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000C",
        "prefix": "I8000C",
        "text": "Additional active diagnosis C.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000D",
        "prefix": "I8000D",
        "text": "Additional active diagnosis D.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000E",
        "prefix": "I8000E",
        "text": "Additional active diagnosis E.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000F",
        "prefix": "I8000F",
        "text": "Additional active diagnosis F.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000G",
        "prefix": "I8000G",
        "text": "Additional active diagnosis G.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000H",
        "prefix": "I8000H",
        "text": "Additional active diagnosis H.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000I",
        "prefix": "I8000I",
        "text": "Additional active diagnosis I.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      }, {
        "linkId": "Section-9/I8000J",
        "prefix": "I8000J",
        "text": "Additional active diagnosis J.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (no diagnosis code)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-9/I0000",
      "prefix": "I0000",
      "text": "Active Diagnoses in the last 7 days: Check all that apply. Diagnoses listed in parentheses are provided as examples and should not be considered as all-inclusive lists",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0100",
          "display": "Cancer (with or without metastasis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0200",
          "display": "Anemia (e.g., aplastic, iron deficiency, pernicious, and sickle cell)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0300",
          "display": "Atrial Fibrillation or Other Dysrhythmias (e.g., bradycardias and tachycardias)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0400",
          "display": "Coronary Artery Disease (CAD) (e.g., angina, myocardial infarction, and atherosclerotic heart disease (ASHD))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0500",
          "display": "Deep Venous Thrombosis (DVT), Pulmonary Embolus (PE), or Pulmonary Thrombo-Embolism (PTE)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0600",
          "display": "Heart Failure (e.g., congestive heart failure (CHF) and pulmonary edema)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0700",
          "display": "Hypertension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0800",
          "display": "Orthostatic Hypotension"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I0900",
          "display": "Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1100",
          "display": "Cirrhosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1200",
          "display": "Gastroesophageal Reflux Disease (GERD) or Ulcer (e.g., esophageal, gastric, and peptic ulcers)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1300",
          "display": "Ulcerative Colitis, Crohn's Disease, or Inflammatory Bowel Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1400",
          "display": "Benign Prostatic Hyperplasia (BPH)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1500",
          "display": "Renal Insufficiency, Renal Failure, or End-Stage Renal Disease (ESRD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1550",
          "display": "Neurogenic Bladder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1650",
          "display": "Obstructive Uropathy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I1700",
          "display": "Multidrug-Resistant Organism (MDRO)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2000",
          "display": "Pneumonia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2100",
          "display": "Septicemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2200",
          "display": "Tuberculosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2300",
          "display": "Urinary Tract Infection (UTI) (LAST 30 DAYS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2400",
          "display": "Viral Hepatitis (e.g., Hepatitis A, B, C, D, and E)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2500",
          "display": "Wound Infection (other than foot)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I2900",
          "display": "Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3100",
          "display": "Hyponatremia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3200",
          "display": "Hyperkalemia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3300",
          "display": "Hyperlipidemia (e.g., hypercholesterolemia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3400",
          "display": "Thyroid Disorder (e.g., hypothyroidism, hyperthyroidism, and Hashimoto's thyroiditis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3700",
          "display": "Arthritis (e.g., degenerative joint disease (DJD), osteoarthritis, and rheumatoid arthritis (RA))"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3800",
          "display": "Osteoporosis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I3900",
          "display": "Hip Fracture - any hip fracture that has a relationship to current status, treatments, monitoring (e.g., sub-capital fractures, and fractures of the trochanter and femoral neck)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4000",
          "display": "Other Fracture"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4200",
          "display": "Alzheimer's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4300",
          "display": "Aphasia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4400",
          "display": "Cerebral Palsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4500",
          "display": "Cerebrovascular Accident (CVA), Transient Ischemic Attack (TIA), or Stroke"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4800",
          "display": "Non-Alzheimer's Dementia (e.g. Lewy body dementia, vascular or multi-infarct dementia; mixed dementia; frontotemporal dementia such as Pick's disease; and dementia related to stroke, Parkinson's or Creutzfeldt-Jakob diseases)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I4900",
          "display": "Hemiplegia or Hemiparesis"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5000",
          "display": "Paraplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5100",
          "display": "Quadriplegia"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5200",
          "display": "Multiple Sclerosis (MS)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5250",
          "display": "Huntington's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5300",
          "display": "Parkinson's Disease"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5350",
          "display": "Tourette's Syndrome"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5400",
          "display": "Seizure Disorder or Epilepsy"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5500",
          "display": "Traumatic Brain Injury (TBI)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5600",
          "display": "Malnutrition (protein or calorie) or at risk for malnutrition"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5700",
          "display": "Anxiety Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5800",
          "display": "Depression (other than bipolar)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5900",
          "display": "Bipolar Disorder"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I5950",
          "display": "Psychotic Disorder (other than schizophrenia)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6000",
          "display": "Schizophrenia (e.g., schizoaffective and schizophreniform disorders)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6100",
          "display": "Post Traumatic Stress Disorder (PTSD)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6200",
          "display": "Asthma, Chronic Obstructive Pulmonary Disease (COPD), or Chronic Lung Disease (e.g., chronic bronchitis and restrictive lung diseases such as asbestosis)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6300",
          "display": "Respiratory Failure"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I6500",
          "display": "Cataracts, Glaucoma, or Macular Degeneration"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I7900",
          "display": "None of the above active diagnoses"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-10",
    "text": "Section J: Health Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-10/J0200",
      "prefix": "J0200",
      "text": "Should Pain Assessment Interview be Conducted? Attempt to conduct interview with all {patients/residents}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0300",
      "prefix": "J0300",
      "text": "Pain Presence. Ask {patient/resident} \"Have you had pain or hurting at any time in the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0400",
      "prefix": "J0400",
      "text": "Pain Frequency. Ask {patient/resident} \"How much of the time have you experienced pain or hurting over the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Almost constantly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Occasionally"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Rarely"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1300",
      "prefix": "J1300",
      "text": "Current Tobacco Use",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1400",
      "prefix": "J1400",
      "text": "Prognosis. Does the {patient/resident} have a condition or chronic disease that may result in a life expectancy of less than 6 months? (Requires physician documentation)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1800",
      "prefix": "J1800",
      "text": "Has the {patient/resident} had any falls since {admission}?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J0850",
      "prefix": "J0850",
      "text": "Frequency of Indicator of Pain or Possible Pain in the last 5 days. Frequency with which {patient/resident} complains or shows evidence of pain or possible pain.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Indicators of pain or possible pain observed 1 to 2 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Indicators of pain or possible pain observed 3 to 4 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Indicators of pain or possible pain observed daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0700",
      "prefix": "J0700",
      "text": "Should the Staff Assessment for Pain be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (Pain frequency answered)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (Unable to answer pain frequency)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0100",
      "prefix": "J0100",
      "text": "Pain Management - Complete for all {patients/residents}, regardless of current pain level. At any time in the last 5 days, has the {patient/resident}:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0100A",
        "prefix": "J0100A",
        "text": "Received scheduled pain medication regimen?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100B",
        "prefix": "J0100B",
        "text": "Received PRN pain medications OR was offered and declined?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100C",
        "prefix": "J0100C",
        "text": "Received non-medication intervention for pain?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0500",
      "prefix": "J0500",
      "text": "Pain Effect on Function",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0500A",
        "prefix": "J0500A",
        "text": "Ask {patient/resident} \"Over the past 5 days, has pain made it hard for you to sleep at night?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0500B",
        "prefix": "J0500B",
        "text": "Ask {patient/resident} \"Over the past 5 days, have you limited your day-to-day activities because of pain?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0600",
      "prefix": "J0600",
      "text": "Pain Intensity - Administer ONLY ONE of the following pain intensity questions (A or B)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0600A",
        "prefix": "J0600A",
        "text": "Numeric Rating Scale (00-10). Ask {patient/resident} \"Please rate your worst pain over the last 5 days on a zero to ten scale, with zero being no pain and ten as the worst pain you can imagine.\" (Show {patient/resident} 00-10 pain scale) Enter two-digit response. Enter 99 if unable to answer.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0600B",
        "prefix": "J0600B",
        "text": "Verbal Descriptor Scale. Ask {patient/resident} \"Please rate the intensity of your worst pain over the last 5 days.\" (Show {patient/resident} verbal scale)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Mild"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Moderate"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Severe"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Very severe, horrible"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1700",
      "prefix": "J1700",
      "text": "Fall History on {Admission}. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1700A",
        "prefix": "J1700A",
        "text": "Did the {patient/resident} have a fall any time in the last month prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700B",
        "prefix": "J1700B",
        "text": "Did the {patient/resident} have a fall any time in the last 2-6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700C",
        "prefix": "J1700C",
        "text": "Did the {patient/resident} have any fracture related to a fall in the 6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1900",
      "prefix": "J1900",
      "text": "Number of Falls Since {Admission} or Prior Assessment whichever is most recent",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1900A",
        "prefix": "J1900A",
        "text": "No injury - No evidence of any injury is noted on physical assessment by the nurse or primary care clinician; no complaints of pain or injury by the {patient/resident}; no change in the {patient's/resident's} behavior is noted after the fall.",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900B",
        "prefix": "J1900B",
        "text": "Injury (except major) - Skin tears, abrasions, lacerations, superficial bruises, hematomas and sprains; or any fall-related injury that causes the {patient/resident} to complain of pain",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900C",
        "prefix": "J1900C",
        "text": "Major injury - Bone fractures, joint dislocations, closed head injuries with altered consciousness, subdural hematoma",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0800",
      "prefix": "J0800",
      "text": "Staff Assessment for Pain. Indicators of Pain or Possible Pain in the last 5 days: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Non-verbal sounds (e.g., crying, whining, gasping, moaning, or groaning)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vocal complaints of pain (e.g., that hurts, ouch, stop)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Facial expressions (e.g., grimaces, winces, wrinkled forehead, furrowed brow, clenched teeth or jaw)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Protective body movements or postures (e.g., bracing, guarding, rubbing or massaging a body part/area, clutching or holding a body part during movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of these signs observed or documented"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1100",
      "prefix": "J1100",
      "text": "Shortness of Breath (dyspnea): Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Shortness of breath or trouble breathing with exertion (e.g., walking, bathing, transferring)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Shortness of breath or trouble breathing when sitting at rest"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Shortness of breath or trouble breathing when lying flat"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1550",
      "prefix": "J1550",
      "text": "Problem Conditions: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Fever"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vomiting"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Dehydrated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Internal bleeding"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-10",
    "text": "Section J: Health Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-10/J0200",
      "prefix": "J0200",
      "text": "Should Pain Assessment Interview be Conducted? Attempt to conduct interview with all {patients/residents}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0300",
      "prefix": "J0300",
      "text": "Pain Presence. Ask {patient/resident} \"Have you had pain or hurting at any time in the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0400",
      "prefix": "J0400",
      "text": "Pain Frequency. Ask {patient/resident} \"How much of the time have you experienced pain or hurting over the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Almost constantly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Occasionally"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Rarely"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1300",
      "prefix": "J1300",
      "text": "Current Tobacco Use",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1400",
      "prefix": "J1400",
      "text": "Prognosis. Does the {patient/resident} have a condition or chronic disease that may result in a life expectancy of less than 6 months? (Requires physician documentation)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1800",
      "prefix": "J1800",
      "text": "Has the {patient/resident} had any falls since {admission}?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J0850",
      "prefix": "J0850",
      "text": "Frequency of Indicator of Pain or Possible Pain in the last 5 days. Frequency with which {patient/resident} complains or shows evidence of pain or possible pain.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Indicators of pain or possible pain observed 1 to 2 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Indicators of pain or possible pain observed 3 to 4 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Indicators of pain or possible pain observed daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0700",
      "prefix": "J0700",
      "text": "Should the Staff Assessment for Pain be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (Pain frequency answered)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (Unable to answer pain frequency)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0100",
      "prefix": "J0100",
      "text": "Pain Management - Complete for all {patients/residents}, regardless of current pain level. At any time in the last 5 days, has the {patient/resident}:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0100A",
        "prefix": "J0100A",
        "text": "Received scheduled pain medication regimen?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100B",
        "prefix": "J0100B",
        "text": "Received PRN pain medications OR was offered and declined?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100C",
        "prefix": "J0100C",
        "text": "Received non-medication intervention for pain?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0500",
      "prefix": "J0500",
      "text": "Pain Effect on Function",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0500A",
        "prefix": "J0500A",
        "text": "Ask {patient/resident} \"Over the past 5 days, has pain made it hard for you to sleep at night?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0500B",
        "prefix": "J0500B",
        "text": "Ask {patient/resident} \"Over the past 5 days, have you limited your day-to-day activities because of pain?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0600",
      "prefix": "J0600",
      "text": "Pain Intensity - Administer ONLY ONE of the following pain intensity questions (A or B)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0600A",
        "prefix": "J0600A",
        "text": "Numeric Rating Scale (00-10). Ask {patient/resident} \"Please rate your worst pain over the last 5 days on a zero to ten scale, with zero being no pain and ten as the worst pain you can imagine.\" (Show {patient/resident} 00-10 pain scale) Enter two-digit response. Enter 99 if unable to answer.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0600B",
        "prefix": "J0600B",
        "text": "Verbal Descriptor Scale. Ask {patient/resident} \"Please rate the intensity of your worst pain over the last 5 days.\" (Show {patient/resident} verbal scale)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Mild"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Moderate"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Severe"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Very severe, horrible"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1700",
      "prefix": "J1700",
      "text": "Fall History on {Admission}. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1700A",
        "prefix": "J1700A",
        "text": "Did the {patient/resident} have a fall any time in the last month prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700B",
        "prefix": "J1700B",
        "text": "Did the {patient/resident} have a fall any time in the last 2-6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700C",
        "prefix": "J1700C",
        "text": "Did the {patient/resident} have any fracture related to a fall in the 6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1900",
      "prefix": "J1900",
      "text": "Number of Falls Since {Admission} or Prior Assessment whichever is most recent",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1900A",
        "prefix": "J1900A",
        "text": "No injury - No evidence of any injury is noted on physical assessment by the nurse or primary care clinician; no complaints of pain or injury by the {patient/resident}; no change in the {patient's/resident's} behavior is noted after the fall.",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900B",
        "prefix": "J1900B",
        "text": "Injury (except major) - Skin tears, abrasions, lacerations, superficial bruises, hematomas and sprains; or any fall-related injury that causes the {patient/resident} to complain of pain",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900C",
        "prefix": "J1900C",
        "text": "Major injury - Bone fractures, joint dislocations, closed head injuries with altered consciousness, subdural hematoma",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0800",
      "prefix": "J0800",
      "text": "Staff Assessment for Pain. Indicators of Pain or Possible Pain in the last 5 days: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Non-verbal sounds (e.g., crying, whining, gasping, moaning, or groaning)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vocal complaints of pain (e.g., that hurts, ouch, stop)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Facial expressions (e.g., grimaces, winces, wrinkled forehead, furrowed brow, clenched teeth or jaw)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Protective body movements or postures (e.g., bracing, guarding, rubbing or massaging a body part/area, clutching or holding a body part during movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of these signs observed or documented"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1100",
      "prefix": "J1100",
      "text": "Shortness of Breath (dyspnea): Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Shortness of breath or trouble breathing with exertion (e.g., walking, bathing, transferring)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Shortness of breath or trouble breathing when sitting at rest"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Shortness of breath or trouble breathing when lying flat"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1550",
      "prefix": "J1550",
      "text": "Problem Conditions: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Fever"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vomiting"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Dehydrated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Internal bleeding"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-10",
    "text": "Section J: Health Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-10/J0200",
      "prefix": "J0200",
      "text": "Should Pain Assessment Interview be Conducted? Attempt to conduct interview with all {patients/residents}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0300",
      "prefix": "J0300",
      "text": "Pain Presence. Ask {patient/resident} \"Have you had pain or hurting at any time in the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0400",
      "prefix": "J0400",
      "text": "Pain Frequency. Ask {patient/resident} \"How much of the time have you experienced pain or hurting over the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Almost constantly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Occasionally"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Rarely"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1300",
      "prefix": "J1300",
      "text": "Current Tobacco Use",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1400",
      "prefix": "J1400",
      "text": "Prognosis. Does the {patient/resident} have a condition or chronic disease that may result in a life expectancy of less than 6 months? (Requires physician documentation)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1800",
      "prefix": "J1800",
      "text": "Has the {patient/resident} had any falls since {admission}?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J0850",
      "prefix": "J0850",
      "text": "Frequency of Indicator of Pain or Possible Pain in the last 5 days. Frequency with which {patient/resident} complains or shows evidence of pain or possible pain.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Indicators of pain or possible pain observed 1 to 2 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Indicators of pain or possible pain observed 3 to 4 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Indicators of pain or possible pain observed daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0700",
      "prefix": "J0700",
      "text": "Should the Staff Assessment for Pain be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (Pain frequency answered)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (Unable to answer pain frequency)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0100",
      "prefix": "J0100",
      "text": "Pain Management - Complete for all {patients/residents}, regardless of current pain level. At any time in the last 5 days, has the {patient/resident}:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0100A",
        "prefix": "J0100A",
        "text": "Received scheduled pain medication regimen?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100B",
        "prefix": "J0100B",
        "text": "Received PRN pain medications OR was offered and declined?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100C",
        "prefix": "J0100C",
        "text": "Received non-medication intervention for pain?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0500",
      "prefix": "J0500",
      "text": "Pain Effect on Function",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0500A",
        "prefix": "J0500A",
        "text": "Ask {patient/resident} \"Over the past 5 days, has pain made it hard for you to sleep at night?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0500B",
        "prefix": "J0500B",
        "text": "Ask {patient/resident} \"Over the past 5 days, have you limited your day-to-day activities because of pain?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0600",
      "prefix": "J0600",
      "text": "Pain Intensity - Administer ONLY ONE of the following pain intensity questions (A or B)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0600A",
        "prefix": "J0600A",
        "text": "Numeric Rating Scale (00-10). Ask {patient/resident} \"Please rate your worst pain over the last 5 days on a zero to ten scale, with zero being no pain and ten as the worst pain you can imagine.\" (Show {patient/resident} 00-10 pain scale) Enter two-digit response. Enter 99 if unable to answer.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0600B",
        "prefix": "J0600B",
        "text": "Verbal Descriptor Scale. Ask {patient/resident} \"Please rate the intensity of your worst pain over the last 5 days.\" (Show {patient/resident} verbal scale)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Mild"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Moderate"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Severe"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Very severe, horrible"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1700",
      "prefix": "J1700",
      "text": "Fall History on {Admission}. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1700A",
        "prefix": "J1700A",
        "text": "Did the {patient/resident} have a fall any time in the last month prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700B",
        "prefix": "J1700B",
        "text": "Did the {patient/resident} have a fall any time in the last 2-6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700C",
        "prefix": "J1700C",
        "text": "Did the {patient/resident} have any fracture related to a fall in the 6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1900",
      "prefix": "J1900",
      "text": "Number of Falls Since {Admission} or Prior Assessment whichever is most recent",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1900A",
        "prefix": "J1900A",
        "text": "No injury - No evidence of any injury is noted on physical assessment by the nurse or primary care clinician; no complaints of pain or injury by the {patient/resident}; no change in the {patient's/resident's} behavior is noted after the fall.",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900B",
        "prefix": "J1900B",
        "text": "Injury (except major) - Skin tears, abrasions, lacerations, superficial bruises, hematomas and sprains; or any fall-related injury that causes the {patient/resident} to complain of pain",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900C",
        "prefix": "J1900C",
        "text": "Major injury - Bone fractures, joint dislocations, closed head injuries with altered consciousness, subdural hematoma",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0800",
      "prefix": "J0800",
      "text": "Staff Assessment for Pain. Indicators of Pain or Possible Pain in the last 5 days: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Non-verbal sounds (e.g., crying, whining, gasping, moaning, or groaning)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vocal complaints of pain (e.g., that hurts, ouch, stop)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Facial expressions (e.g., grimaces, winces, wrinkled forehead, furrowed brow, clenched teeth or jaw)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Protective body movements or postures (e.g., bracing, guarding, rubbing or massaging a body part/area, clutching or holding a body part during movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of these signs observed or documented"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1100",
      "prefix": "J1100",
      "text": "Shortness of Breath (dyspnea): Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Shortness of breath or trouble breathing with exertion (e.g., walking, bathing, transferring)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Shortness of breath or trouble breathing when sitting at rest"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Shortness of breath or trouble breathing when lying flat"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1550",
      "prefix": "J1550",
      "text": "Problem Conditions: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Fever"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vomiting"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Dehydrated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Internal bleeding"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-10",
    "text": "Section J: Health Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-10/J0200",
      "prefix": "J0200",
      "text": "Should Pain Assessment Interview be Conducted? Attempt to conduct interview with all {patients/residents}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0300",
      "prefix": "J0300",
      "text": "Pain Presence. Ask {patient/resident} \"Have you had pain or hurting at any time in the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0400",
      "prefix": "J0400",
      "text": "Pain Frequency. Ask {patient/resident} \"How much of the time have you experienced pain or hurting over the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Almost constantly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Occasionally"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Rarely"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1300",
      "prefix": "J1300",
      "text": "Current Tobacco Use",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1400",
      "prefix": "J1400",
      "text": "Prognosis. Does the {patient/resident} have a condition or chronic disease that may result in a life expectancy of less than 6 months? (Requires physician documentation)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1800",
      "prefix": "J1800",
      "text": "Has the {patient/resident} had any falls since {admission}?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J0850",
      "prefix": "J0850",
      "text": "Frequency of Indicator of Pain or Possible Pain in the last 5 days. Frequency with which {patient/resident} complains or shows evidence of pain or possible pain.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Indicators of pain or possible pain observed 1 to 2 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Indicators of pain or possible pain observed 3 to 4 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Indicators of pain or possible pain observed daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0700",
      "prefix": "J0700",
      "text": "Should the Staff Assessment for Pain be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (Pain frequency answered)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (Unable to answer pain frequency)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0100",
      "prefix": "J0100",
      "text": "Pain Management - Complete for all {patients/residents}, regardless of current pain level. At any time in the last 5 days, has the {patient/resident}:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0100A",
        "prefix": "J0100A",
        "text": "Received scheduled pain medication regimen?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100B",
        "prefix": "J0100B",
        "text": "Received PRN pain medications OR was offered and declined?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100C",
        "prefix": "J0100C",
        "text": "Received non-medication intervention for pain?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0500",
      "prefix": "J0500",
      "text": "Pain Effect on Function",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0500A",
        "prefix": "J0500A",
        "text": "Ask {patient/resident} \"Over the past 5 days, has pain made it hard for you to sleep at night?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0500B",
        "prefix": "J0500B",
        "text": "Ask {patient/resident} \"Over the past 5 days, have you limited your day-to-day activities because of pain?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0600",
      "prefix": "J0600",
      "text": "Pain Intensity - Administer ONLY ONE of the following pain intensity questions (A or B)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0600A",
        "prefix": "J0600A",
        "text": "Numeric Rating Scale (00-10). Ask {patient/resident} \"Please rate your worst pain over the last 5 days on a zero to ten scale, with zero being no pain and ten as the worst pain you can imagine.\" (Show {patient/resident} 00-10 pain scale) Enter two-digit response. Enter 99 if unable to answer.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0600B",
        "prefix": "J0600B",
        "text": "Verbal Descriptor Scale. Ask {patient/resident} \"Please rate the intensity of your worst pain over the last 5 days.\" (Show {patient/resident} verbal scale)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Mild"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Moderate"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Severe"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Very severe, horrible"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1700",
      "prefix": "J1700",
      "text": "Fall History on {Admission}. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1700A",
        "prefix": "J1700A",
        "text": "Did the {patient/resident} have a fall any time in the last month prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700B",
        "prefix": "J1700B",
        "text": "Did the {patient/resident} have a fall any time in the last 2-6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700C",
        "prefix": "J1700C",
        "text": "Did the {patient/resident} have any fracture related to a fall in the 6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1900",
      "prefix": "J1900",
      "text": "Number of Falls Since {Admission} or Prior Assessment whichever is most recent",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1900A",
        "prefix": "J1900A",
        "text": "No injury - No evidence of any injury is noted on physical assessment by the nurse or primary care clinician; no complaints of pain or injury by the {patient/resident}; no change in the {patient's/resident's} behavior is noted after the fall.",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900B",
        "prefix": "J1900B",
        "text": "Injury (except major) - Skin tears, abrasions, lacerations, superficial bruises, hematomas and sprains; or any fall-related injury that causes the {patient/resident} to complain of pain",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900C",
        "prefix": "J1900C",
        "text": "Major injury - Bone fractures, joint dislocations, closed head injuries with altered consciousness, subdural hematoma",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0800",
      "prefix": "J0800",
      "text": "Staff Assessment for Pain. Indicators of Pain or Possible Pain in the last 5 days: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Non-verbal sounds (e.g., crying, whining, gasping, moaning, or groaning)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vocal complaints of pain (e.g., that hurts, ouch, stop)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Facial expressions (e.g., grimaces, winces, wrinkled forehead, furrowed brow, clenched teeth or jaw)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Protective body movements or postures (e.g., bracing, guarding, rubbing or massaging a body part/area, clutching or holding a body part during movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of these signs observed or documented"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1100",
      "prefix": "J1100",
      "text": "Shortness of Breath (dyspnea): Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Shortness of breath or trouble breathing with exertion (e.g., walking, bathing, transferring)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Shortness of breath or trouble breathing when sitting at rest"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Shortness of breath or trouble breathing when lying flat"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1550",
      "prefix": "J1550",
      "text": "Problem Conditions: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Fever"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vomiting"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Dehydrated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Internal bleeding"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-10",
    "text": "Section J: Health Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-10/J0200",
      "prefix": "J0200",
      "text": "Should Pain Assessment Interview be Conducted? Attempt to conduct interview with all {patients/residents}.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No ({patient/resident} is rarely/never understood)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0300",
      "prefix": "J0300",
      "text": "Pain Presence. Ask {patient/resident} \"Have you had pain or hurting at any time in the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0400",
      "prefix": "J0400",
      "text": "Pain Frequency. Ask {patient/resident} \"How much of the time have you experienced pain or hurting over the last 5 days?\"",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Almost constantly"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Frequently"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Occasionally"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Rarely"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Unable to answer"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1300",
      "prefix": "J1300",
      "text": "Current Tobacco Use",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1400",
      "prefix": "J1400",
      "text": "Prognosis. Does the {patient/resident} have a condition or chronic disease that may result in a life expectancy of less than 6 months? (Requires physician documentation)",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1800",
      "prefix": "J1800",
      "text": "Has the {patient/resident} had any falls since {admission}?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J0850",
      "prefix": "J0850",
      "text": "Frequency of Indicator of Pain or Possible Pain in the last 5 days. Frequency with which {patient/resident} complains or shows evidence of pain or possible pain.",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Indicators of pain or possible pain observed 1 to 2 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Indicators of pain or possible pain observed 3 to 4 days"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Indicators of pain or possible pain observed daily"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0700",
      "prefix": "J0700",
      "text": "Should the Staff Assessment for Pain be Conducted?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No (Pain frequency answered)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes (Unable to answer pain frequency)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J0100",
      "prefix": "J0100",
      "text": "Pain Management - Complete for all {patients/residents}, regardless of current pain level. At any time in the last 5 days, has the {patient/resident}:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0100A",
        "prefix": "J0100A",
        "text": "Received scheduled pain medication regimen?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100B",
        "prefix": "J0100B",
        "text": "Received PRN pain medications OR was offered and declined?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-10/J0100C",
        "prefix": "J0100C",
        "text": "Received non-medication intervention for pain?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0500",
      "prefix": "J0500",
      "text": "Pain Effect on Function",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0500A",
        "prefix": "J0500A",
        "text": "Ask {patient/resident} \"Over the past 5 days, has pain made it hard for you to sleep at night?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0500B",
        "prefix": "J0500B",
        "text": "Ask {patient/resident} \"Over the past 5 days, have you limited your day-to-day activities because of pain?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0600",
      "prefix": "J0600",
      "text": "Pain Intensity - Administer ONLY ONE of the following pain intensity questions (A or B)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J0600A",
        "prefix": "J0600A",
        "text": "Numeric Rating Scale (00-10). Ask {patient/resident} \"Please rate your worst pain over the last 5 days on a zero to ten scale, with zero being no pain and ten as the worst pain you can imagine.\" (Show {patient/resident} 00-10 pain scale) Enter two-digit response. Enter 99 if unable to answer.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "10",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J0600B",
        "prefix": "J0600B",
        "text": "Verbal Descriptor Scale. Ask {patient/resident} \"Please rate the intensity of your worst pain over the last 5 days.\" (Show {patient/resident} verbal scale)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Mild"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Moderate"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Severe"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Very severe, horrible"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to answer"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1700",
      "prefix": "J1700",
      "text": "Fall History on {Admission}. Complete only if {admission}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1700A",
        "prefix": "J1700A",
        "text": "Did the {patient/resident} have a fall any time in the last month prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700B",
        "prefix": "J1700B",
        "text": "Did the {patient/resident} have a fall any time in the last 2-6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1700C",
        "prefix": "J1700C",
        "text": "Did the {patient/resident} have any fracture related to a fall in the 6 months prior to {admission}?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unable to determine"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J1900",
      "prefix": "J1900",
      "text": "Number of Falls Since {Admission} or Prior Assessment whichever is most recent",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-10/J1900A",
        "prefix": "J1900A",
        "text": "No injury - No evidence of any injury is noted on physical assessment by the nurse or primary care clinician; no complaints of pain or injury by the {patient/resident}; no change in the {patient's/resident's} behavior is noted after the fall.",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900B",
        "prefix": "J1900B",
        "text": "Injury (except major) - Skin tears, abrasions, lacerations, superficial bruises, hematomas and sprains; or any fall-related injury that causes the {patient/resident} to complain of pain",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-10/J1900C",
        "prefix": "J1900C",
        "text": "Major injury - Bone fractures, joint dislocations, closed head injuries with altered consciousness, subdural hematoma",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "None"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "One"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Two or more"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-10/J0800",
      "prefix": "J0800",
      "text": "Staff Assessment for Pain. Indicators of Pain or Possible Pain in the last 5 days: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Non-verbal sounds (e.g., crying, whining, gasping, moaning, or groaning)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vocal complaints of pain (e.g., that hurts, ouch, stop)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Facial expressions (e.g., grimaces, winces, wrinkled forehead, furrowed brow, clenched teeth or jaw)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Protective body movements or postures (e.g., bracing, guarding, rubbing or massaging a body part/area, clutching or holding a body part during movement)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of these signs observed or documented"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-10/J1100",
      "prefix": "J1100",
      "text": "Shortness of Breath (dyspnea): Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Shortness of breath or trouble breathing with exertion (e.g., walking, bathing, transferring)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Shortness of breath or trouble breathing when sitting at rest"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Shortness of breath or trouble breathing when lying flat"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-10/J1550",
      "prefix": "J1550",
      "text": "Problem Conditions: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Fever"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Vomiting"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Dehydrated"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Internal bleeding"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-11",
    "text": "Section K: Swallowing/Nutritional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-11/K0300",
      "prefix": "K0300",
      "text": "Weight Loss. Loss of 5% or more in the last month or loss of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0310",
      "prefix": "K0310",
      "text": "Weight Gain. Gain of 5% or more in the last month or gain of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0200",
      "prefix": "K0200",
      "text": "Height and Weight - While measuring, if the number is X.1 - X.4 round down; X.5 or greater round up",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0200A",
        "prefix": "K0200A",
        "text": "Height (in inches). Record most recent height measure since {admission}",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-11/K0200B",
        "prefix": "K0200B",
        "text": "Weight (in pounds). Base weight on most recent measure in last {specify time period in days}; measure weight consistently, according to standard {facility/setting} practice (e.g., in a.m. after voiding, before meal, with shoes off, etc.)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "000",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "999",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-11/K0100",
      "prefix": "K0100",
      "text": "Swallowing Disorder. Signs and symptoms of possible swallowing disorder: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Loss of liquids/solids from mouth when eating or drinking"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Holding food in mouth/cheeks or residual food in mouth after meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Coughing or choking during meals or when swallowing medications"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Complaints of difficulty or pain with swallowing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0510",
      "prefix": "K0510",
      "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed during the last 7 days",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0510_1",
        "prefix": "K0510_1",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while not a {patient/resident} of this {facility} and within the last 7 days. If {patient/resident} entered 7 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-11/K0510_2",
        "prefix": "K0510_2",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while a {patient/resident} of this {facility} and within the last 7 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-11",
    "text": "Section K: Swallowing/Nutritional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-11/K0300",
      "prefix": "K0300",
      "text": "Weight Loss. Loss of 5% or more in the last month or loss of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0310",
      "prefix": "K0310",
      "text": "Weight Gain. Gain of 5% or more in the last month or gain of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0200",
      "prefix": "K0200",
      "text": "Height and Weight - While measuring, if the number is X.1 - X.4 round down; X.5 or greater round up",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0200A",
        "prefix": "K0200A",
        "text": "Height (in inches). Record most recent height measure since {admission}",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-11/K0200B",
        "prefix": "K0200B",
        "text": "Weight (in pounds). Base weight on most recent measure in last {specify time period in days}; measure weight consistently, according to standard {facility/setting} practice (e.g., in a.m. after voiding, before meal, with shoes off, etc.)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "000",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "999",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-11/K0100",
      "prefix": "K0100",
      "text": "Swallowing Disorder. Signs and symptoms of possible swallowing disorder: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Loss of liquids/solids from mouth when eating or drinking"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Holding food in mouth/cheeks or residual food in mouth after meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Coughing or choking during meals or when swallowing medications"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Complaints of difficulty or pain with swallowing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0510",
      "prefix": "K0510",
      "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed during the last 7 days",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0510_1",
        "prefix": "K0510_1",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while not a {patient/resident} of this {facility} and within the last 7 days. If {patient/resident} entered 7 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-11/K0510_2",
        "prefix": "K0510_2",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while a {patient/resident} of this {facility} and within the last 7 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-11",
    "text": "Section K: Swallowing/Nutritional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-11/K0300",
      "prefix": "K0300",
      "text": "Weight Loss. Loss of 5% or more in the last month or loss of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0310",
      "prefix": "K0310",
      "text": "Weight Gain. Gain of 5% or more in the last month or gain of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0200",
      "prefix": "K0200",
      "text": "Height and Weight - While measuring, if the number is X.1 - X.4 round down; X.5 or greater round up",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0200A",
        "prefix": "K0200A",
        "text": "Height (in inches). Record most recent height measure since {admission}",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-11/K0200B",
        "prefix": "K0200B",
        "text": "Weight (in pounds). Base weight on most recent measure in last {specify time period in days}; measure weight consistently, according to standard {facility/setting} practice (e.g., in a.m. after voiding, before meal, with shoes off, etc.)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "000",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "999",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-11/K0100",
      "prefix": "K0100",
      "text": "Swallowing Disorder. Signs and symptoms of possible swallowing disorder: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Loss of liquids/solids from mouth when eating or drinking"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Holding food in mouth/cheeks or residual food in mouth after meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Coughing or choking during meals or when swallowing medications"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Complaints of difficulty or pain with swallowing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0510",
      "prefix": "K0510",
      "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed during the last 7 days",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0510_1",
        "prefix": "K0510_1",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while not a {patient/resident} of this {facility} and within the last 7 days. If {patient/resident} entered 7 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-11/K0510_2",
        "prefix": "K0510_2",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while a {patient/resident} of this {facility} and within the last 7 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-11",
    "text": "Section K: Swallowing/Nutritional Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-11/K0300",
      "prefix": "K0300",
      "text": "Weight Loss. Loss of 5% or more in the last month or loss of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-loss regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0310",
      "prefix": "K0310",
      "text": "Weight Gain. Gain of 5% or more in the last month or gain of 10% or more in last 6 months",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No or unknown"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes, on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes, not on physician-prescribed weight-gain regimen"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0200",
      "prefix": "K0200",
      "text": "Height and Weight - While measuring, if the number is X.1 - X.4 round down; X.5 or greater round up",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0200A",
        "prefix": "K0200A",
        "text": "Height (in inches). Record most recent height measure since {admission}",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-11/K0200B",
        "prefix": "K0200B",
        "text": "Weight (in pounds). Base weight on most recent measure in last {specify time period in days}; measure weight consistently, according to standard {facility/setting} practice (e.g., in a.m. after voiding, before meal, with shoes off, etc.)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "000",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "999",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-11/K0100",
      "prefix": "K0100",
      "text": "Swallowing Disorder. Signs and symptoms of possible swallowing disorder: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Loss of liquids/solids from mouth when eating or drinking"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Holding food in mouth/cheeks or residual food in mouth after meals"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Coughing or choking during meals or when swallowing medications"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Complaints of difficulty or pain with swallowing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-11/K0510",
      "prefix": "K0510",
      "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed during the last 7 days",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-11/K0510_1",
        "prefix": "K0510_1",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while not a {patient/resident} of this {facility} and within the last 7 days. If {patient/resident} entered 7 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-11/K0510_2",
        "prefix": "K0510_2",
        "text": "Nutritional Approaches: Check all of the following nutritional approaches that were performed while a {patient/resident} of this {facility} and within the last 7 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Parenteral/IV feeding"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Feeding tube (e.g., nasogastric or abdominal (PEG))"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Mechanically altered diet - require change in texture of food or liquids (e.g., pureed food, thickened liquids)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Therapeutic diet (e.g., low salt, diabetic, low cholesterol)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-12",
    "text": "Section L: Oral/Dental Status",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-12/L0200",
      "prefix": "L0200",
      "text": "Dental: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Broken or loosely fitting full or partial denture (chipped, cracked, uncleanable, or loose)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "No natural teeth or tooth fragment(s) (edentulous)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Abnormal mouth tissue (ulcers, masses, oral lesions, including under denture or partial if one is worn)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Obvious or likely cavity or broken natural teeth"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Inflamed or bleeding gums or loose natural teeth"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Mouth or facial pain, discomfort or difficulty with chewing"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Unable to examine"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were present"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-13",
    "text": "Section M: Skin Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-13/M0150",
      "prefix": "M0150",
      "text": "Risk of Pressure Ulcers/Injuries. Is this {patient/resident} at risk of developing pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0210",
      "prefix": "M0210",
      "text": "Unhealed Pressure Ulcers/Injuries. Does this {patient/resident} have one or more unhealed pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0700",
      "prefix": "M0700",
      "text": "Most Severe Tissue Type for Any Pressure Ulcer. Select the best description of the most severe type of tissue present in any pressure ulcer bed",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Epithelial tissue - new skin growing in superficial ulcer. It can be light pink and shiny, even in persons with darkly pigmented skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Granulation tissue - pink or red tissue with shiny, moist, granular appearance"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Slough - yellow or white tissue that adheres to the ulcer bed in strings or thick clumps, or is mucinous"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Eschar - black, brown, or tan tissue that adheres firmly to the wound bed or ulcer edges, may be softer or harder than surrounding skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-13/M1030",
      "prefix": "M1030",
      "text": "Number of Venous and Arterial Ulcers. Enter the total number of venous and arterial ulcers present",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0300",
      "prefix": "M0300",
      "text": "Current Number of Unhealed Pressure Ulcers/Injuries at Each Stage",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0300A",
        "prefix": "M0300A",
        "text": "Stage 1: Intact skin with non-blanchable redness of a localized area usually over a bony prominence. Darkly pigmented skin may not have a visible blanching; in dark skin tones only it may appear with persistent blue or purple hues",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300B",
        "prefix": "M0300B",
        "text": "Stage 2: Partial thickness loss of dermis presenting as a shallow open ulcer with a red or pink wound bed, without slough. May also present as an intact or open/ruptured blister.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300C",
        "prefix": "M0300C",
        "text": "Stage 3: Full thickness tissue loss. Subcutaneous fat may be visible but bone, tendon or muscle is not exposed. Slough may be present but does not obscure the depth of tissue loss. May include undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300D",
        "prefix": "M0300D",
        "text": "Stage 4: Full thickness tissue loss with exposed bone, tendon or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300E",
        "prefix": "M0300E",
        "text": "Unstageable - Non-removable dressing/device: Known but not stageable due to non-removable dressing/device",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300F",
        "prefix": "M0300F",
        "text": "Unstageable - Slough and/or eschar: Known but not stageable due to coverage of wound bed by slough and/or eschar",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300G",
        "prefix": "M0300G",
        "text": "Unstageable - Deep tissue injury",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-13/M0610",
      "prefix": "M0610",
      "text": "Dimensions of Unhealed Stage 3 or 4 Pressure Ulcers or Eschar. If the {patient/resident} has one or more unhealed Stage 3 or 4 pressure ulcers or an unstageable pressure ulcer due to slough or eschar, identify the pressure ulcer with the largest surface area (length x width) and record in centimeters:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0610A",
        "prefix": "M0610A",
        "text": "Pressure ulcer length. Longest length from head to toe",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610B",
        "prefix": "M0610B",
        "text": "Pressure ulcer width. Widest width of the same pressure ulcer, side-to-side perpendicular (90-degree angle) to length",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610C",
        "prefix": "M0610C",
        "text": "Pressure ulcer depth. Depth of the same pressure ulcer from the visible surface to the deepest area (if depth is unknown, enter a dash in each box)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-13/M0100",
      "prefix": "M0100",
      "text": "Determination of Pressure Ulcer/Injury Risk: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "{Patient/Resident} has a pressure ulcer/injury, a scar over bony prominence, or a non-removable dressing/device"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Formal assessment instrument/tool (e.g., Braden, Norton, or other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Clinical assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1040",
      "prefix": "M1040",
      "text": "Other Ulcers, Wounds and Skin Problems: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Infection of the foot (e.g., cellulitis, purulent drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Diabetic foot ulcer(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Other open lesion(s) on the foot"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Open lesion(s) other than ulcers, rashes, cuts (e.g., cancer lesion)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Surgical wound(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Burn(s) (second or third degree)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Skin tear(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Moisture Associated Skin Damage (MASD) (e.g., incontinence-associated dermatitis [IAD], perspiration, drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were present"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1200",
      "prefix": "M1200",
      "text": "Skin and Ulcer/Injury Treatments: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Pressure reducing device for chair"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Pressure reducing device for bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Turning/repositioning program"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Nutrition or hydration intervention to manage skin problems"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Pressure ulcer/injury care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Surgical wound care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Application of nonsurgical dressings (with or without topical medications) other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Applications of ointments/medications other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Application of dressings to feet (with or without topical medications)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were provided"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-13",
    "text": "Section M: Skin Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-13/M0150",
      "prefix": "M0150",
      "text": "Risk of Pressure Ulcers/Injuries. Is this {patient/resident} at risk of developing pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0210",
      "prefix": "M0210",
      "text": "Unhealed Pressure Ulcers/Injuries. Does this {patient/resident} have one or more unhealed pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0700",
      "prefix": "M0700",
      "text": "Most Severe Tissue Type for Any Pressure Ulcer. Select the best description of the most severe type of tissue present in any pressure ulcer bed",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Epithelial tissue - new skin growing in superficial ulcer. It can be light pink and shiny, even in persons with darkly pigmented skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Granulation tissue - pink or red tissue with shiny, moist, granular appearance"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Slough - yellow or white tissue that adheres to the ulcer bed in strings or thick clumps, or is mucinous"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Eschar - black, brown, or tan tissue that adheres firmly to the wound bed or ulcer edges, may be softer or harder than surrounding skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-13/M1030",
      "prefix": "M1030",
      "text": "Number of Venous and Arterial Ulcers. Enter the total number of venous and arterial ulcers present",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0300",
      "prefix": "M0300",
      "text": "Current Number of Unhealed Pressure Ulcers/Injuries at Each Stage",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0300A",
        "prefix": "M0300A",
        "text": "Stage 1: Intact skin with non-blanchable redness of a localized area usually over a bony prominence. Darkly pigmented skin may not have a visible blanching; in dark skin tones only it may appear with persistent blue or purple hues",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300B",
        "prefix": "M0300B",
        "text": "Stage 2: Partial thickness loss of dermis presenting as a shallow open ulcer with a red or pink wound bed, without slough. May also present as an intact or open/ruptured blister.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300C",
        "prefix": "M0300C",
        "text": "Stage 3: Full thickness tissue loss. Subcutaneous fat may be visible but bone, tendon or muscle is not exposed. Slough may be present but does not obscure the depth of tissue loss. May include undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300D",
        "prefix": "M0300D",
        "text": "Stage 4: Full thickness tissue loss with exposed bone, tendon or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300E",
        "prefix": "M0300E",
        "text": "Unstageable - Non-removable dressing/device: Known but not stageable due to non-removable dressing/device",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300F",
        "prefix": "M0300F",
        "text": "Unstageable - Slough and/or eschar: Known but not stageable due to coverage of wound bed by slough and/or eschar",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300G",
        "prefix": "M0300G",
        "text": "Unstageable - Deep tissue injury",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-13/M0610",
      "prefix": "M0610",
      "text": "Dimensions of Unhealed Stage 3 or 4 Pressure Ulcers or Eschar. If the {patient/resident} has one or more unhealed Stage 3 or 4 pressure ulcers or an unstageable pressure ulcer due to slough or eschar, identify the pressure ulcer with the largest surface area (length x width) and record in centimeters:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0610A",
        "prefix": "M0610A",
        "text": "Pressure ulcer length. Longest length from head to toe",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610B",
        "prefix": "M0610B",
        "text": "Pressure ulcer width. Widest width of the same pressure ulcer, side-to-side perpendicular (90-degree angle) to length",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610C",
        "prefix": "M0610C",
        "text": "Pressure ulcer depth. Depth of the same pressure ulcer from the visible surface to the deepest area (if depth is unknown, enter a dash in each box)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-13/M0100",
      "prefix": "M0100",
      "text": "Determination of Pressure Ulcer/Injury Risk: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "{Patient/Resident} has a pressure ulcer/injury, a scar over bony prominence, or a non-removable dressing/device"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Formal assessment instrument/tool (e.g., Braden, Norton, or other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Clinical assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1040",
      "prefix": "M1040",
      "text": "Other Ulcers, Wounds and Skin Problems: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Infection of the foot (e.g., cellulitis, purulent drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Diabetic foot ulcer(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Other open lesion(s) on the foot"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Open lesion(s) other than ulcers, rashes, cuts (e.g., cancer lesion)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Surgical wound(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Burn(s) (second or third degree)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Skin tear(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Moisture Associated Skin Damage (MASD) (e.g., incontinence-associated dermatitis [IAD], perspiration, drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were present"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1200",
      "prefix": "M1200",
      "text": "Skin and Ulcer/Injury Treatments: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Pressure reducing device for chair"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Pressure reducing device for bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Turning/repositioning program"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Nutrition or hydration intervention to manage skin problems"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Pressure ulcer/injury care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Surgical wound care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Application of nonsurgical dressings (with or without topical medications) other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Applications of ointments/medications other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Application of dressings to feet (with or without topical medications)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were provided"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-13",
    "text": "Section M: Skin Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-13/M0150",
      "prefix": "M0150",
      "text": "Risk of Pressure Ulcers/Injuries. Is this {patient/resident} at risk of developing pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0210",
      "prefix": "M0210",
      "text": "Unhealed Pressure Ulcers/Injuries. Does this {patient/resident} have one or more unhealed pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0700",
      "prefix": "M0700",
      "text": "Most Severe Tissue Type for Any Pressure Ulcer. Select the best description of the most severe type of tissue present in any pressure ulcer bed",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Epithelial tissue - new skin growing in superficial ulcer. It can be light pink and shiny, even in persons with darkly pigmented skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Granulation tissue - pink or red tissue with shiny, moist, granular appearance"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Slough - yellow or white tissue that adheres to the ulcer bed in strings or thick clumps, or is mucinous"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Eschar - black, brown, or tan tissue that adheres firmly to the wound bed or ulcer edges, may be softer or harder than surrounding skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-13/M1030",
      "prefix": "M1030",
      "text": "Number of Venous and Arterial Ulcers. Enter the total number of venous and arterial ulcers present",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0300",
      "prefix": "M0300",
      "text": "Current Number of Unhealed Pressure Ulcers/Injuries at Each Stage",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0300A",
        "prefix": "M0300A",
        "text": "Stage 1: Intact skin with non-blanchable redness of a localized area usually over a bony prominence. Darkly pigmented skin may not have a visible blanching; in dark skin tones only it may appear with persistent blue or purple hues",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300B",
        "prefix": "M0300B",
        "text": "Stage 2: Partial thickness loss of dermis presenting as a shallow open ulcer with a red or pink wound bed, without slough. May also present as an intact or open/ruptured blister.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300C",
        "prefix": "M0300C",
        "text": "Stage 3: Full thickness tissue loss. Subcutaneous fat may be visible but bone, tendon or muscle is not exposed. Slough may be present but does not obscure the depth of tissue loss. May include undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300D",
        "prefix": "M0300D",
        "text": "Stage 4: Full thickness tissue loss with exposed bone, tendon or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300E",
        "prefix": "M0300E",
        "text": "Unstageable - Non-removable dressing/device: Known but not stageable due to non-removable dressing/device",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300F",
        "prefix": "M0300F",
        "text": "Unstageable - Slough and/or eschar: Known but not stageable due to coverage of wound bed by slough and/or eschar",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300G",
        "prefix": "M0300G",
        "text": "Unstageable - Deep tissue injury",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-13/M0610",
      "prefix": "M0610",
      "text": "Dimensions of Unhealed Stage 3 or 4 Pressure Ulcers or Eschar. If the {patient/resident} has one or more unhealed Stage 3 or 4 pressure ulcers or an unstageable pressure ulcer due to slough or eschar, identify the pressure ulcer with the largest surface area (length x width) and record in centimeters:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0610A",
        "prefix": "M0610A",
        "text": "Pressure ulcer length. Longest length from head to toe",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610B",
        "prefix": "M0610B",
        "text": "Pressure ulcer width. Widest width of the same pressure ulcer, side-to-side perpendicular (90-degree angle) to length",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610C",
        "prefix": "M0610C",
        "text": "Pressure ulcer depth. Depth of the same pressure ulcer from the visible surface to the deepest area (if depth is unknown, enter a dash in each box)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-13/M0100",
      "prefix": "M0100",
      "text": "Determination of Pressure Ulcer/Injury Risk: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "{Patient/Resident} has a pressure ulcer/injury, a scar over bony prominence, or a non-removable dressing/device"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Formal assessment instrument/tool (e.g., Braden, Norton, or other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Clinical assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1040",
      "prefix": "M1040",
      "text": "Other Ulcers, Wounds and Skin Problems: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Infection of the foot (e.g., cellulitis, purulent drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Diabetic foot ulcer(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Other open lesion(s) on the foot"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Open lesion(s) other than ulcers, rashes, cuts (e.g., cancer lesion)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Surgical wound(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Burn(s) (second or third degree)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Skin tear(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Moisture Associated Skin Damage (MASD) (e.g., incontinence-associated dermatitis [IAD], perspiration, drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were present"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1200",
      "prefix": "M1200",
      "text": "Skin and Ulcer/Injury Treatments: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Pressure reducing device for chair"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Pressure reducing device for bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Turning/repositioning program"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Nutrition or hydration intervention to manage skin problems"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Pressure ulcer/injury care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Surgical wound care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Application of nonsurgical dressings (with or without topical medications) other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Applications of ointments/medications other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Application of dressings to feet (with or without topical medications)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were provided"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-13",
    "text": "Section M: Skin Conditions",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-13/M0150",
      "prefix": "M0150",
      "text": "Risk of Pressure Ulcers/Injuries. Is this {patient/resident} at risk of developing pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0210",
      "prefix": "M0210",
      "text": "Unhealed Pressure Ulcers/Injuries. Does this {patient/resident} have one or more unhealed pressure ulcers/injuries?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0700",
      "prefix": "M0700",
      "text": "Most Severe Tissue Type for Any Pressure Ulcer. Select the best description of the most severe type of tissue present in any pressure ulcer bed",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Epithelial tissue - new skin growing in superficial ulcer. It can be light pink and shiny, even in persons with darkly pigmented skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Granulation tissue - pink or red tissue with shiny, moist, granular appearance"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "3",
          "display": "Slough - yellow or white tissue that adheres to the ulcer bed in strings or thick clumps, or is mucinous"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "4",
          "display": "Eschar - black, brown, or tan tissue that adheres firmly to the wound bed or ulcer edges, may be softer or harder than surrounding skin"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-13/M1030",
      "prefix": "M1030",
      "text": "Number of Venous and Arterial Ulcers. Enter the total number of venous and arterial ulcers present",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "9",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M0300",
      "prefix": "M0300",
      "text": "Current Number of Unhealed Pressure Ulcers/Injuries at Each Stage",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0300A",
        "prefix": "M0300A",
        "text": "Stage 1: Intact skin with non-blanchable redness of a localized area usually over a bony prominence. Darkly pigmented skin may not have a visible blanching; in dark skin tones only it may appear with persistent blue or purple hues",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300B",
        "prefix": "M0300B",
        "text": "Stage 2: Partial thickness loss of dermis presenting as a shallow open ulcer with a red or pink wound bed, without slough. May also present as an intact or open/ruptured blister.",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300C",
        "prefix": "M0300C",
        "text": "Stage 3: Full thickness tissue loss. Subcutaneous fat may be visible but bone, tendon or muscle is not exposed. Slough may be present but does not obscure the depth of tissue loss. May include undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300D",
        "prefix": "M0300D",
        "text": "Stage 4: Full thickness tissue loss with exposed bone, tendon or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300E",
        "prefix": "M0300E",
        "text": "Unstageable - Non-removable dressing/device: Known but not stageable due to non-removable dressing/device",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300F",
        "prefix": "M0300F",
        "text": "Unstageable - Slough and/or eschar: Known but not stageable due to coverage of wound bed by slough and/or eschar",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-13/M0300G",
        "prefix": "M0300G",
        "text": "Unstageable - Deep tissue injury",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-13/M0610",
      "prefix": "M0610",
      "text": "Dimensions of Unhealed Stage 3 or 4 Pressure Ulcers or Eschar. If the {patient/resident} has one or more unhealed Stage 3 or 4 pressure ulcers or an unstageable pressure ulcer due to slough or eschar, identify the pressure ulcer with the largest surface area (length x width) and record in centimeters:",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-13/M0610A",
        "prefix": "M0610A",
        "text": "Pressure ulcer length. Longest length from head to toe",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum length (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610B",
        "prefix": "M0610B",
        "text": "Pressure ulcer width. Widest width of the same pressure ulcer, side-to-side perpendicular (90-degree angle) to length",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum width (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-13/M0610C",
        "prefix": "M0610C",
        "text": "Pressure ulcer depth. Depth of the same pressure ulcer from the visible surface to the deepest area (if depth is unknown, enter a dash in each box)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00.0",
            "display": "Minimum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99.9",
            "display": "Maximum depth (cm)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-13/M0100",
      "prefix": "M0100",
      "text": "Determination of Pressure Ulcer/Injury Risk: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "{Patient/Resident} has a pressure ulcer/injury, a scar over bony prominence, or a non-removable dressing/device"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Formal assessment instrument/tool (e.g., Braden, Norton, or other)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Clinical assessment"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1040",
      "prefix": "M1040",
      "text": "Other Ulcers, Wounds and Skin Problems: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Infection of the foot (e.g., cellulitis, purulent drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Diabetic foot ulcer(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Other open lesion(s) on the foot"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Open lesion(s) other than ulcers, rashes, cuts (e.g., cancer lesion)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Surgical wound(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Burn(s) (second or third degree)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Skin tear(s)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Moisture Associated Skin Damage (MASD) (e.g., incontinence-associated dermatitis [IAD], perspiration, drainage)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were present"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-13/M1200",
      "prefix": "M1200",
      "text": "Skin and Ulcer/Injury Treatments: Check all that apply",
      "type": "choice",
      "repeats": true,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "A",
          "display": "Pressure reducing device for chair"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "B",
          "display": "Pressure reducing device for bed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "C",
          "display": "Turning/repositioning program"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "D",
          "display": "Nutrition or hydration intervention to manage skin problems"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "E",
          "display": "Pressure ulcer/injury care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "F",
          "display": "Surgical wound care"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "G",
          "display": "Application of nonsurgical dressings (with or without topical medications) other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "H",
          "display": "Applications of ointments/medications other than to feet"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "I",
          "display": "Application of dressings to feet (with or without topical medications)"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "Z",
          "display": "None of the above were provided"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    } ]
  }, {
    "linkId": "Section-14",
    "text": "Section N: Medications",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-14/N0300",
      "prefix": "N0300",
      "text": "Injections. Record the number of days that injections of any type were received during the last 7 days or since {admission} if less than 7 days.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "7",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-14/N0350",
      "prefix": "N0350",
      "text": "Insulin",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0350A",
        "prefix": "N0350A",
        "text": "Insulin injections - Record the number of days that insulin injections were received during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-14/N0350B",
        "prefix": "N0350B",
        "text": "Orders for insulin - Record the number of days the physician (or authorized assistant or practitioner) changed the {patient's/resident's} insulin orders during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-14/N0410",
      "prefix": "N0410",
      "text": "Medications Received. Indicate the number of DAYS the {patient/resident} received the following medications by pharmacological classification, not how it is used, during the last 7 days or since {admission} if less than 7 days. Enter \"0\" if medication was not received by the {patient/resident} during the last 7 days.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0410A",
        "prefix": "N0410A",
        "text": "Antipsychotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410B",
        "prefix": "N0410B",
        "text": "Antianxiety",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410C",
        "prefix": "N0410C",
        "text": "Antidepressant",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410D",
        "prefix": "N0410D",
        "text": "Hypnotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410E",
        "prefix": "N0410E",
        "text": "Anticoagulant (e.g., warfarin, heparin, or low-molecular weight heparin)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410F",
        "prefix": "N0410F",
        "text": "Antibiotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410G",
        "prefix": "N0410G",
        "text": "Diuretic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-14",
    "text": "Section N: Medications",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-14/N0300",
      "prefix": "N0300",
      "text": "Injections. Record the number of days that injections of any type were received during the last 7 days or since {admission} if less than 7 days.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "7",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-14/N0350",
      "prefix": "N0350",
      "text": "Insulin",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0350A",
        "prefix": "N0350A",
        "text": "Insulin injections - Record the number of days that insulin injections were received during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-14/N0350B",
        "prefix": "N0350B",
        "text": "Orders for insulin - Record the number of days the physician (or authorized assistant or practitioner) changed the {patient's/resident's} insulin orders during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-14/N0410",
      "prefix": "N0410",
      "text": "Medications Received. Indicate the number of DAYS the {patient/resident} received the following medications by pharmacological classification, not how it is used, during the last 7 days or since {admission} if less than 7 days. Enter \"0\" if medication was not received by the {patient/resident} during the last 7 days.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0410A",
        "prefix": "N0410A",
        "text": "Antipsychotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410B",
        "prefix": "N0410B",
        "text": "Antianxiety",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410C",
        "prefix": "N0410C",
        "text": "Antidepressant",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410D",
        "prefix": "N0410D",
        "text": "Hypnotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410E",
        "prefix": "N0410E",
        "text": "Anticoagulant (e.g., warfarin, heparin, or low-molecular weight heparin)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410F",
        "prefix": "N0410F",
        "text": "Antibiotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410G",
        "prefix": "N0410G",
        "text": "Diuretic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-14",
    "text": "Section N: Medications",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-14/N0300",
      "prefix": "N0300",
      "text": "Injections. Record the number of days that injections of any type were received during the last 7 days or since {admission} if less than 7 days.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "7",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-14/N0350",
      "prefix": "N0350",
      "text": "Insulin",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0350A",
        "prefix": "N0350A",
        "text": "Insulin injections - Record the number of days that insulin injections were received during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-14/N0350B",
        "prefix": "N0350B",
        "text": "Orders for insulin - Record the number of days the physician (or authorized assistant or practitioner) changed the {patient's/resident's} insulin orders during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-14/N0410",
      "prefix": "N0410",
      "text": "Medications Received. Indicate the number of DAYS the {patient/resident} received the following medications by pharmacological classification, not how it is used, during the last 7 days or since {admission} if less than 7 days. Enter \"0\" if medication was not received by the {patient/resident} during the last 7 days.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0410A",
        "prefix": "N0410A",
        "text": "Antipsychotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410B",
        "prefix": "N0410B",
        "text": "Antianxiety",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410C",
        "prefix": "N0410C",
        "text": "Antidepressant",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410D",
        "prefix": "N0410D",
        "text": "Hypnotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410E",
        "prefix": "N0410E",
        "text": "Anticoagulant (e.g., warfarin, heparin, or low-molecular weight heparin)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410F",
        "prefix": "N0410F",
        "text": "Antibiotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410G",
        "prefix": "N0410G",
        "text": "Diuretic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-14",
    "text": "Section N: Medications",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-14/N0300",
      "prefix": "N0300",
      "text": "Injections. Record the number of days that injections of any type were received during the last 7 days or since {admission} if less than 7 days.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "7",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-14/N0350",
      "prefix": "N0350",
      "text": "Insulin",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0350A",
        "prefix": "N0350A",
        "text": "Insulin injections - Record the number of days that insulin injections were received during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-14/N0350B",
        "prefix": "N0350B",
        "text": "Orders for insulin - Record the number of days the physician (or authorized assistant or practitioner) changed the {patient's/resident's} insulin orders during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-14/N0410",
      "prefix": "N0410",
      "text": "Medications Received. Indicate the number of DAYS the {patient/resident} received the following medications by pharmacological classification, not how it is used, during the last 7 days or since {admission} if less than 7 days. Enter \"0\" if medication was not received by the {patient/resident} during the last 7 days.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0410A",
        "prefix": "N0410A",
        "text": "Antipsychotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410B",
        "prefix": "N0410B",
        "text": "Antianxiety",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410C",
        "prefix": "N0410C",
        "text": "Antidepressant",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410D",
        "prefix": "N0410D",
        "text": "Hypnotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410E",
        "prefix": "N0410E",
        "text": "Anticoagulant (e.g., warfarin, heparin, or low-molecular weight heparin)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410F",
        "prefix": "N0410F",
        "text": "Antibiotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410G",
        "prefix": "N0410G",
        "text": "Diuretic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-14",
    "text": "Section N: Medications",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-14/N0300",
      "prefix": "N0300",
      "text": "Injections. Record the number of days that injections of any type were received during the last 7 days or since {admission} if less than 7 days.",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "7",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-14/N0350",
      "prefix": "N0350",
      "text": "Insulin",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0350A",
        "prefix": "N0350A",
        "text": "Insulin injections - Record the number of days that insulin injections were received during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-14/N0350B",
        "prefix": "N0350B",
        "text": "Orders for insulin - Record the number of days the physician (or authorized assistant or practitioner) changed the {patient's/resident's} insulin orders during the last 7 days or since {admission} if less than 7 days.",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-14/N0410",
      "prefix": "N0410",
      "text": "Medications Received. Indicate the number of DAYS the {patient/resident} received the following medications by pharmacological classification, not how it is used, during the last 7 days or since {admission} if less than 7 days. Enter \"0\" if medication was not received by the {patient/resident} during the last 7 days.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-14/N0410A",
        "prefix": "N0410A",
        "text": "Antipsychotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410B",
        "prefix": "N0410B",
        "text": "Antianxiety",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410C",
        "prefix": "N0410C",
        "text": "Antidepressant",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410D",
        "prefix": "N0410D",
        "text": "Hypnotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410E",
        "prefix": "N0410E",
        "text": "Anticoagulant (e.g., warfarin, heparin, or low-molecular weight heparin)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410F",
        "prefix": "N0410F",
        "text": "Antibiotic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-14/N0410G",
        "prefix": "N0410G",
        "text": "Diuretic",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-15",
    "text": "Section O: Special Treatments, Procedures, and Programs",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-15/O0600",
      "prefix": "O0600",
      "text": "Physician Examinations. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) examine the {patient/resident}?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0700",
      "prefix": "O0700",
      "text": "Physician Orders. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) change the {patient's/resident's} orders?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0250",
      "prefix": "O0250",
      "text": "Influenza Vaccine - Refer to the current version of the {manual} for current influenza vaccination season and reporting period",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0250A",
        "prefix": "O0250A",
        "text": "Did the {patient/resident} receive the influenza vaccine in this {facility/setting} for this year's influenza vaccination season?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250B",
        "prefix": "O0250B",
        "text": "Date influenza vaccine received",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Date influenza vaccine received"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250C",
        "prefix": "O0250C",
        "text": "If influenza vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/resident} not in facility during this year's influenza vaccination season"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Received outside of this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "6",
            "display": "Inability to obtain influenza vaccine due to a declared shortage"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0300",
      "prefix": "O0300",
      "text": "Pneumococcal Vaccine",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0300A",
        "prefix": "O0300A",
        "text": "Is the {patient's/resident's} Pneumococcal vaccination up to date?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0300B",
        "prefix": "O0300B",
        "text": "If Pneumococcal vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0400",
      "prefix": "O0400",
      "text": "Therapies",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0400A",
        "prefix": "O0400A",
        "text": "Speech-Language Pathology and Audiology Services",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400B",
        "prefix": "O0400B",
        "text": "Occupational Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400C",
        "prefix": "O0400C",
        "text": "Physical Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400D",
        "prefix": "O0400D",
        "text": "Respiratory Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400E",
        "prefix": "O0400E",
        "text": "Psychological Therapy (by any licensed mental health professional)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400F",
        "prefix": "O0400F",
        "text": "Recreational Therapy (includes recreational and music therapy)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-15/O0450",
      "prefix": "O0450",
      "text": "Resumption of Therapy",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0450A",
        "prefix": "O0450A",
        "text": "Has a previous rehabilitation therapy regimen (speech, occupational, and/or physical therapy) ended, as reported on this {End of Therapy}, and has this regimen now resumed at exactly the same level for each discipline?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0500",
      "prefix": "O0500",
      "text": "Restorative Nursing Programs. Record the number of days each of the following restorative programs was performed (for at least 15 minutes a day) in the last 7 calendar days (enter 0 if none or less than 15 minutes daily)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0500A",
        "prefix": "O0500A",
        "text": "Technique. Range of motion (passive)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500B",
        "prefix": "O0500B",
        "text": "Technique. Range of motion (active)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500C",
        "prefix": "O0500C",
        "text": "Technique. Splint or brace assistance",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500D",
        "prefix": "O0500D",
        "text": "Training and Skill Practice in. Bed mobility",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500E",
        "prefix": "O0500E",
        "text": "Training and Skill Practice in. Transfer",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500F",
        "prefix": "O0500F",
        "text": "Training and Skill Practice in. Walking",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500G",
        "prefix": "O0500G",
        "text": "Training and Skill Practice in. Dressing and/or grooming",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500H",
        "prefix": "O0500H",
        "text": "Training and Skill Practice in. Eating and/or swallowing",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500I",
        "prefix": "O0500I",
        "text": "Training and Skill Practice in. Amputation/prostheses care",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500J",
        "prefix": "O0500J",
        "text": "Training and Skill Practice in. Communication",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0100",
      "prefix": "O0100",
      "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed",
      "type": "text",
      "repeats": true,
      "readOnly": false,
      "maxLength": 1,
      "item": [ {
        "linkId": "Section-15/O0100_1",
        "prefix": "O0100_1",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while not a {patient/resident} of this {facility} and within the last 14 days.  If {patient/resident} last entered 14 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-15/O0100_2",
        "prefix": "O0100_2",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while a {patient/resident} of this {facility} and within the last 14 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "L",
            "display": "Respite care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-15",
    "text": "Section O: Special Treatments, Procedures, and Programs",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-15/O0600",
      "prefix": "O0600",
      "text": "Physician Examinations. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) examine the {patient/resident}?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0700",
      "prefix": "O0700",
      "text": "Physician Orders. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) change the {patient's/resident's} orders?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0250",
      "prefix": "O0250",
      "text": "Influenza Vaccine - Refer to the current version of the {manual} for current influenza vaccination season and reporting period",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0250A",
        "prefix": "O0250A",
        "text": "Did the {patient/resident} receive the influenza vaccine in this {facility/setting} for this year's influenza vaccination season?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250B",
        "prefix": "O0250B",
        "text": "Date influenza vaccine received",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Date influenza vaccine received"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250C",
        "prefix": "O0250C",
        "text": "If influenza vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/resident} not in facility during this year's influenza vaccination season"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Received outside of this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "6",
            "display": "Inability to obtain influenza vaccine due to a declared shortage"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0300",
      "prefix": "O0300",
      "text": "Pneumococcal Vaccine",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0300A",
        "prefix": "O0300A",
        "text": "Is the {patient's/resident's} Pneumococcal vaccination up to date?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0300B",
        "prefix": "O0300B",
        "text": "If Pneumococcal vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0400",
      "prefix": "O0400",
      "text": "Therapies",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0400A",
        "prefix": "O0400A",
        "text": "Speech-Language Pathology and Audiology Services",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400B",
        "prefix": "O0400B",
        "text": "Occupational Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400C",
        "prefix": "O0400C",
        "text": "Physical Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400D",
        "prefix": "O0400D",
        "text": "Respiratory Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400E",
        "prefix": "O0400E",
        "text": "Psychological Therapy (by any licensed mental health professional)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400F",
        "prefix": "O0400F",
        "text": "Recreational Therapy (includes recreational and music therapy)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-15/O0450",
      "prefix": "O0450",
      "text": "Resumption of Therapy",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0450A",
        "prefix": "O0450A",
        "text": "Has a previous rehabilitation therapy regimen (speech, occupational, and/or physical therapy) ended, as reported on this {End of Therapy}, and has this regimen now resumed at exactly the same level for each discipline?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0500",
      "prefix": "O0500",
      "text": "Restorative Nursing Programs. Record the number of days each of the following restorative programs was performed (for at least 15 minutes a day) in the last 7 calendar days (enter 0 if none or less than 15 minutes daily)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0500A",
        "prefix": "O0500A",
        "text": "Technique. Range of motion (passive)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500B",
        "prefix": "O0500B",
        "text": "Technique. Range of motion (active)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500C",
        "prefix": "O0500C",
        "text": "Technique. Splint or brace assistance",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500D",
        "prefix": "O0500D",
        "text": "Training and Skill Practice in. Bed mobility",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500E",
        "prefix": "O0500E",
        "text": "Training and Skill Practice in. Transfer",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500F",
        "prefix": "O0500F",
        "text": "Training and Skill Practice in. Walking",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500G",
        "prefix": "O0500G",
        "text": "Training and Skill Practice in. Dressing and/or grooming",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500H",
        "prefix": "O0500H",
        "text": "Training and Skill Practice in. Eating and/or swallowing",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500I",
        "prefix": "O0500I",
        "text": "Training and Skill Practice in. Amputation/prostheses care",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500J",
        "prefix": "O0500J",
        "text": "Training and Skill Practice in. Communication",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0100",
      "prefix": "O0100",
      "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed",
      "type": "text",
      "repeats": true,
      "readOnly": false,
      "maxLength": 1,
      "item": [ {
        "linkId": "Section-15/O0100_1",
        "prefix": "O0100_1",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while not a {patient/resident} of this {facility} and within the last 14 days.  If {patient/resident} last entered 14 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-15/O0100_2",
        "prefix": "O0100_2",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while a {patient/resident} of this {facility} and within the last 14 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "L",
            "display": "Respite care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-15",
    "text": "Section O: Special Treatments, Procedures, and Programs",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-15/O0600",
      "prefix": "O0600",
      "text": "Physician Examinations. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) examine the {patient/resident}?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0700",
      "prefix": "O0700",
      "text": "Physician Orders. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) change the {patient's/resident's} orders?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0250",
      "prefix": "O0250",
      "text": "Influenza Vaccine - Refer to the current version of the {manual} for current influenza vaccination season and reporting period",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0250A",
        "prefix": "O0250A",
        "text": "Did the {patient/resident} receive the influenza vaccine in this {facility/setting} for this year's influenza vaccination season?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250B",
        "prefix": "O0250B",
        "text": "Date influenza vaccine received",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Date influenza vaccine received"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250C",
        "prefix": "O0250C",
        "text": "If influenza vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/resident} not in facility during this year's influenza vaccination season"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Received outside of this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "6",
            "display": "Inability to obtain influenza vaccine due to a declared shortage"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0300",
      "prefix": "O0300",
      "text": "Pneumococcal Vaccine",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0300A",
        "prefix": "O0300A",
        "text": "Is the {patient's/resident's} Pneumococcal vaccination up to date?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0300B",
        "prefix": "O0300B",
        "text": "If Pneumococcal vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0400",
      "prefix": "O0400",
      "text": "Therapies",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0400A",
        "prefix": "O0400A",
        "text": "Speech-Language Pathology and Audiology Services",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400B",
        "prefix": "O0400B",
        "text": "Occupational Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400C",
        "prefix": "O0400C",
        "text": "Physical Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400D",
        "prefix": "O0400D",
        "text": "Respiratory Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400E",
        "prefix": "O0400E",
        "text": "Psychological Therapy (by any licensed mental health professional)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400F",
        "prefix": "O0400F",
        "text": "Recreational Therapy (includes recreational and music therapy)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-15/O0450",
      "prefix": "O0450",
      "text": "Resumption of Therapy",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0450A",
        "prefix": "O0450A",
        "text": "Has a previous rehabilitation therapy regimen (speech, occupational, and/or physical therapy) ended, as reported on this {End of Therapy}, and has this regimen now resumed at exactly the same level for each discipline?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0500",
      "prefix": "O0500",
      "text": "Restorative Nursing Programs. Record the number of days each of the following restorative programs was performed (for at least 15 minutes a day) in the last 7 calendar days (enter 0 if none or less than 15 minutes daily)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0500A",
        "prefix": "O0500A",
        "text": "Technique. Range of motion (passive)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500B",
        "prefix": "O0500B",
        "text": "Technique. Range of motion (active)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500C",
        "prefix": "O0500C",
        "text": "Technique. Splint or brace assistance",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500D",
        "prefix": "O0500D",
        "text": "Training and Skill Practice in. Bed mobility",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500E",
        "prefix": "O0500E",
        "text": "Training and Skill Practice in. Transfer",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500F",
        "prefix": "O0500F",
        "text": "Training and Skill Practice in. Walking",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500G",
        "prefix": "O0500G",
        "text": "Training and Skill Practice in. Dressing and/or grooming",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500H",
        "prefix": "O0500H",
        "text": "Training and Skill Practice in. Eating and/or swallowing",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500I",
        "prefix": "O0500I",
        "text": "Training and Skill Practice in. Amputation/prostheses care",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500J",
        "prefix": "O0500J",
        "text": "Training and Skill Practice in. Communication",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0100",
      "prefix": "O0100",
      "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed",
      "type": "text",
      "repeats": true,
      "readOnly": false,
      "maxLength": 1,
      "item": [ {
        "linkId": "Section-15/O0100_1",
        "prefix": "O0100_1",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while not a {patient/resident} of this {facility} and within the last 14 days.  If {patient/resident} last entered 14 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-15/O0100_2",
        "prefix": "O0100_2",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while a {patient/resident} of this {facility} and within the last 14 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "L",
            "display": "Respite care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-15",
    "text": "Section O: Special Treatments, Procedures, and Programs",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-15/O0600",
      "prefix": "O0600",
      "text": "Physician Examinations. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) examine the {patient/resident}?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0700",
      "prefix": "O0700",
      "text": "Physician Orders. Over the last 14 days, on how many days did the physician (or authorized assistant or practitioner) change the {patient's/resident's} orders?",
      "type": "open-choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "00",
          "display": "Minimum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "14",
          "display": "Maximum value"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-15/O0250",
      "prefix": "O0250",
      "text": "Influenza Vaccine - Refer to the current version of the {manual} for current influenza vaccination season and reporting period",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0250A",
        "prefix": "O0250A",
        "text": "Did the {patient/resident} receive the influenza vaccine in this {facility/setting} for this year's influenza vaccination season?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250B",
        "prefix": "O0250B",
        "text": "Date influenza vaccine received",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Date influenza vaccine received"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-15/O0250C",
        "prefix": "O0250C",
        "text": "If influenza vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/resident} not in facility during this year's influenza vaccination season"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Received outside of this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "4",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "5",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "6",
            "display": "Inability to obtain influenza vaccine due to a declared shortage"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0300",
      "prefix": "O0300",
      "text": "Pneumococcal Vaccine",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0300A",
        "prefix": "O0300A",
        "text": "Is the {patient's/resident's} Pneumococcal vaccination up to date?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0300B",
        "prefix": "O0300B",
        "text": "If Pneumococcal vaccine not received, state reason",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Not eligible - medical contraindication"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Offered and declined"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Not offered"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0400",
      "prefix": "O0400",
      "text": "Therapies",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0400A",
        "prefix": "O0400A",
        "text": "Speech-Language Pathology and Audiology Services",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400B",
        "prefix": "O0400B",
        "text": "Occupational Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400C",
        "prefix": "O0400C",
        "text": "Physical Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400D",
        "prefix": "O0400D",
        "text": "Respiratory Therapy",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400E",
        "prefix": "O0400E",
        "text": "Psychological Therapy (by any licensed mental health professional)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-15/O0400F",
        "prefix": "O0400F",
        "text": "Recreational Therapy (includes recreational and music therapy)",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    }, {
      "linkId": "Section-15/O0450",
      "prefix": "O0450",
      "text": "Resumption of Therapy",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0450A",
        "prefix": "O0450A",
        "text": "Has a previous rehabilitation therapy regimen (speech, occupational, and/or physical therapy) ended, as reported on this {End of Therapy}, and has this regimen now resumed at exactly the same level for each discipline?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0500",
      "prefix": "O0500",
      "text": "Restorative Nursing Programs. Record the number of days each of the following restorative programs was performed (for at least 15 minutes a day) in the last 7 calendar days (enter 0 if none or less than 15 minutes daily)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-15/O0500A",
        "prefix": "O0500A",
        "text": "Technique. Range of motion (passive)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500B",
        "prefix": "O0500B",
        "text": "Technique. Range of motion (active)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500C",
        "prefix": "O0500C",
        "text": "Technique. Splint or brace assistance",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500D",
        "prefix": "O0500D",
        "text": "Training and Skill Practice in. Bed mobility",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500E",
        "prefix": "O0500E",
        "text": "Training and Skill Practice in. Transfer",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500F",
        "prefix": "O0500F",
        "text": "Training and Skill Practice in. Walking",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500G",
        "prefix": "O0500G",
        "text": "Training and Skill Practice in. Dressing and/or grooming",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500H",
        "prefix": "O0500H",
        "text": "Training and Skill Practice in. Eating and/or swallowing",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500I",
        "prefix": "O0500I",
        "text": "Training and Skill Practice in. Amputation/prostheses care",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-15/O0500J",
        "prefix": "O0500J",
        "text": "Training and Skill Practice in. Communication",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "7",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-15/O0100",
      "prefix": "O0100",
      "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed",
      "type": "text",
      "repeats": true,
      "readOnly": false,
      "maxLength": 1,
      "item": [ {
        "linkId": "Section-15/O0100_1",
        "prefix": "O0100_1",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while not a {patient/resident} of this {facility} and within the last 14 days.  If {patient/resident} last entered 14 or more days ago, leave column 1 blank.",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      }, {
        "linkId": "Section-15/O0100_2",
        "prefix": "O0100_2",
        "text": "Special Treatments, Procedures, and Programs. Check all of the following treatments, procedures, and programs that were performed while a {patient/resident} of this {facility} and within the last 14 days",
        "type": "choice",
        "repeats": true,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "A",
            "display": "Chemotherapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "B",
            "display": "Radiation"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "C",
            "display": "Oxygen Therapy"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "D",
            "display": "Suctioning"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "E",
            "display": "Tracheostomy care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "F",
            "display": "Invasive Mechanical Ventilator (Ventilator or respirator)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "G",
            "display": "Non-Invasive Mechanical Ventilator (BiPAP/CPAP)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "H",
            "display": "IV Medications"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "I",
            "display": "Transfusions"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "J",
            "display": "Dialysis"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "K",
            "display": "Hospice care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "L",
            "display": "Respite care"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "M",
            "display": "Isolation or quarantine for active infectious disease (does not include standard body/fluid precautions)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "Z",
            "display": "None of the above"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-16",
    "text": "Section P: Restraints",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-16/P0100",
      "prefix": "P0100",
      "text": "Physical Restraints. Physical restraints are any manual method or physical or mechanical device, material or equipment attached or adjacent to the {patient's/resident's} body that the individual cannot remove easily which restricts freedom of movement or normal access to one's body",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-16/P0100A",
        "prefix": "P0100A",
        "text": "Used in Bed.  Bed rail",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100B",
        "prefix": "P0100B",
        "text": "Used in Bed. Trunk restraint",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100C",
        "prefix": "P0100C",
        "text": "Used in Bed. Limb restraint",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100D",
        "prefix": "P0100D",
        "text": "Used in Bed. Other",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100E",
        "prefix": "P0100E",
        "text": "Used in Chair or Out of Bed. Trunk restraint",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100F",
        "prefix": "P0100F",
        "text": "Used in Chair or Out of Bed. Limb restraint",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100G",
        "prefix": "P0100G",
        "text": "Used in Chair or Out of Bed. Chair prevents rising",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-16/P0100H",
        "prefix": "P0100H",
        "text": "Used in Chair or Out of Bed. Other",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "Not used"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Used less than daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Used daily"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-17",
    "text": "Section Q: Participation in Assessment and Goal Setting",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-17/Q0600",
      "prefix": "Q0600",
      "text": "Referral. Has a referral been made to the Local Contact Agency? Document reasons in {patient's/resident's} clinical record",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No - referral not needed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "No - referral is or may be needed (For more information see {resources/documentation})"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes - referral made"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-17/Q0490",
      "prefix": "Q0490",
      "text": "{Patient's/Resident's} Preference to Avoid Being Asked {Return to Community question}. Does the {patient's/resident's} clinical record document a request that this question be asked only on comprehensive assessments?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "8",
          "display": "Information not available"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-17/Q0100",
      "prefix": "Q0100",
      "text": "Participation in Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0100A",
        "prefix": "Q0100A",
        "text": "{Patient/Resident} participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0100B",
        "prefix": "Q0100B",
        "text": "Family or significant other participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "{Patient/Resident} has no family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0100C",
        "prefix": "Q0100C",
        "text": "Guardian or legally authorized representative participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "{Patient/Resident} has no guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0300",
      "prefix": "Q0300",
      "text": "{Patient's/Resident's} Overall Expectation. Complete only if {first assessment}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0300A",
        "prefix": "Q0300A",
        "text": "Select one for {patient's/resident's} overall goal established during assessment process",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Expects to be discharged to the community"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Expects to remain in this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Expects to be discharged to another facility/institution"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0300B",
        "prefix": "Q0300B",
        "text": "Indicate information source for {patient/resident overall goal}",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/Resident}"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "If not {patient/resident}, then family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "If not {patient/resident}, family, or significant other, then guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0400",
      "prefix": "Q0400",
      "text": "Discharge Plan",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0400A",
        "prefix": "Q0400A",
        "text": "Is active discharge planning already occurring for the {patient/resident} to return to the community?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0500",
      "prefix": "Q0500",
      "text": "Return to Community",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0500B",
        "prefix": "Q0500B",
        "text": "Ask the {patient/resident} (or family or significant other or guardian or legally authorized representative if {patient/resident} is unable to understand or respond): \"Do you want to talk to someone about the possibility of leaving this {facility/setting} and returning to live and receive services in the community?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0550",
      "prefix": "Q0550",
      "text": "{Patient's/Resident's} Preference to Avoid Being Asked {Return to Community question} Again",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0550A",
        "prefix": "Q0550A",
        "text": "Does the {patient/resident} (or family or significant other or guardian or legally authorized representative if {patient/resident} is unable to understand or respond) want to be asked about returning to the community on all assessments? (Rather than only on comprehensive assessments.)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Information not available"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0550B",
        "prefix": "Q0550B",
        "text": "Indicate information source for {preference on asking return to community question}",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/Resident}"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "If not {patient/resident}, then family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "If not {patient/resident}, family, or significant other, then guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "No information source available"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-17",
    "text": "Section Q: Participation in Assessment and Goal Setting",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-17/Q0600",
      "prefix": "Q0600",
      "text": "Referral. Has a referral been made to the Local Contact Agency? Document reasons in {patient's/resident's} clinical record",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No - referral not needed"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "No - referral is or may be needed (For more information see {resources/documentation})"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "2",
          "display": "Yes - referral made"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      } ]
    }, {
      "linkId": "Section-17/Q0490",
      "prefix": "Q0490",
      "text": "{Patient's/Resident's} Preference to Avoid Being Asked {Return to Community question}. Does the {patient's/resident's} clinical record document a request that this question be asked only on comprehensive assessments?",
      "type": "choice",
      "repeats": false,
      "readOnly": false,
      "answerOption": [ {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "0",
          "display": "No"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "1",
          "display": "Yes"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "8",
          "display": "Information not available"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "-",
          "display": "Not assessed/no information"
        }
      }, {
        "valueCoding": {
          "system": "http://del.cms.gov",
          "code": "^",
          "display": "Blank (skip pattern)"
        }
      } ]
    }, {
      "linkId": "Section-17/Q0100",
      "prefix": "Q0100",
      "text": "Participation in Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0100A",
        "prefix": "Q0100A",
        "text": "{Patient/Resident} participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0100B",
        "prefix": "Q0100B",
        "text": "Family or significant other participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "{Patient/Resident} has no family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0100C",
        "prefix": "Q0100C",
        "text": "Guardian or legally authorized representative participated in assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "{Patient/Resident} has no guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0300",
      "prefix": "Q0300",
      "text": "{Patient's/Resident's} Overall Expectation. Complete only if {first assessment}",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0300A",
        "prefix": "Q0300A",
        "text": "Select one for {patient's/resident's} overall goal established during assessment process",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Expects to be discharged to the community"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "Expects to remain in this facility"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "Expects to be discharged to another facility/institution"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0300B",
        "prefix": "Q0300B",
        "text": "Indicate information source for {patient/resident overall goal}",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/Resident}"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "If not {patient/resident}, then family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "If not {patient/resident}, family, or significant other, then guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0400",
      "prefix": "Q0400",
      "text": "Discharge Plan",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0400A",
        "prefix": "Q0400A",
        "text": "Is active discharge planning already occurring for the {patient/resident} to return to the community?",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0500",
      "prefix": "Q0500",
      "text": "Return to Community",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0500B",
        "prefix": "Q0500B",
        "text": "Ask the {patient/resident} (or family or significant other or guardian or legally authorized representative if {patient/resident} is unable to understand or respond): \"Do you want to talk to someone about the possibility of leaving this {facility/setting} and returning to live and receive services in the community?\"",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "9",
            "display": "Unknown or uncertain"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-17/Q0550",
      "prefix": "Q0550",
      "text": "{Patient's/Resident's} Preference to Avoid Being Asked {Return to Community question} Again",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-17/Q0550A",
        "prefix": "Q0550A",
        "text": "Does the {patient/resident} (or family or significant other or guardian or legally authorized representative if {patient/resident} is unable to understand or respond) want to be asked about returning to the community on all assessments? (Rather than only on comprehensive assessments.)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "0",
            "display": "No"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "Yes"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "Information not available"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-17/Q0550B",
        "prefix": "Q0550B",
        "text": "Indicate information source for {preference on asking return to community question}",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "1",
            "display": "{Patient/Resident}"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "2",
            "display": "If not {patient/resident}, then family or significant other"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "3",
            "display": "If not {patient/resident}, family, or significant other, then guardian or legally authorized representative"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "8",
            "display": "No information source available"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-18",
    "text": "Section V: Care Area Assessment (CAA) Summary",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-18/V0100",
      "prefix": "V0100",
      "text": "Items From the Most Recent Prior OBRA or Scheduled PPS Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-18/V0100A",
        "prefix": "V0100A",
        "text": "Prior Assessment Federal OBRA Reason for Assessment (A0310A value from prior assessment)",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "01",
            "display": "Admission assessment (required by day 14)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "02",
            "display": "Quarterly review assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "03",
            "display": "Annual assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "04",
            "display": "Significant change in status assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "05",
            "display": "Significant correction to prior comprehensive assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "06",
            "display": "Significant correction to prior quarterly assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-18/V0100B",
        "prefix": "V0100B",
        "text": "Prior Assessment PPS Reason for Assessment (A0310B value from prior assessment",
        "type": "choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "01",
            "display": "5-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "02",
            "display": "14-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "03",
            "display": "30-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "04",
            "display": "60-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "05",
            "display": "90-day scheduled assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "06",
            "display": "Readmission/return assessment"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "07",
            "display": "Unscheduled assessment used for PPS (OMRA, significant or clinical change, or significant correction assessment)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "None of the above"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-18/V0100C",
        "prefix": "V0100C",
        "text": "Prior Assessment Reference Date (A2300 value from prior assessment)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Prior assessment reference date (Assessment reference date value from prior assessment)"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-18/V0100D",
        "prefix": "V0100D",
        "text": "Prior Assessment Brief Interview for Mental Status (BIMS) Summary Score (C0500 value from prior assessment)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "15",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to complete interview"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-18/V0100E",
        "prefix": "V0100E",
        "text": "Prior Assessment Resident Mood Interview (PHQ-9) Total Severity Score (D0300 value from prior assessment)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "27",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "99",
            "display": "Unable to complete interview"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      }, {
        "linkId": "Section-18/V0100F",
        "prefix": "V0100F",
        "text": "Prior Assessment Staff Assessment of Resident Mood (PHQ-9-OV) Total Severity Score (D0600 value from prior assessment)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "00",
            "display": "Minimum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "30",
            "display": "Maximum value"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "-",
            "display": "Not assessed/no information"
          }
        }, {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (skip pattern)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-18/V0200",
      "prefix": "V0200",
      "text": "CAAs and Care Planning. 1. Check column A if Care Area is triggered. 2. For each triggered Care Area, indicate whether a new care plan, care plan revision, or continuation of current care plan is necessary to address the problem(s) identified in your assessment of the care area. The Care Planning Decision column must be completed within 7 days of completing the RAI (MDS and CAA(s)). Check column B is the triggered care area is addressed in the care plan. 3. Indicate in the Location and Date of CAA Documentation column where information related to the CAA can be found. CAA documentation should include information on the complicating factors, risks, and any referrals for this resident for this care area.",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-18/V0200A",
        "prefix": "V0200A",
        "text": "CAA Results",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-18/V0200B",
        "prefix": "V0200B",
        "text": "Signature of RN coordinator for CAA Process and Date Signed",
        "type": "group",
        "repeats": false,
        "readOnly": true
      }, {
        "linkId": "Section-18/V0200C",
        "prefix": "V0200C",
        "text": "Signature of Person Completing Care Plan Decision and Date Signed",
        "type": "group",
        "repeats": false,
        "readOnly": true
      } ]
    } ]
  }, {
    "linkId": "Section-19",
    "text": "Section Z: Assessment Administration",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-19/Z0100",
      "prefix": "Z0100",
      "text": "Medicare Part A Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0100A",
        "prefix": "Z0100A",
        "text": "Medicare Part A HIPPS code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0100B",
        "prefix": "Z0100B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0150",
      "prefix": "Z0150",
      "text": "Medicare Part A Non-Therapy Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0150A",
        "prefix": "Z0150A",
        "text": "Medicare Part A non-therapy HIPPS code (RUG group followed by assessment type indicator)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0150B",
        "prefix": "Z0150B",
        "text": "RUG version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0200",
      "prefix": "Z0200",
      "text": "State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0200A",
        "prefix": "Z0200A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0200B",
        "prefix": "Z0200B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0250",
      "prefix": "Z0250",
      "text": "Alternate State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0250A",
        "prefix": "Z0250A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0250B",
        "prefix": "Z0250B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0300",
      "prefix": "Z0300",
      "text": "Insurance Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0300A",
        "prefix": "Z0300A",
        "text": "Billing code",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      }, {
        "linkId": "Section-19/Z0300B",
        "prefix": "Z0300B",
        "text": "Billing version",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      } ]
    }, {
      "linkId": "Section-19/Z0400",
      "prefix": "Z0400",
      "text": "Signature of Persons Completing the Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0400A",
        "prefix": "Z0400A",
        "text": "Signature, Title, Sections, Date Section Completed A",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400B",
        "prefix": "Z0400B",
        "text": "Signature, Title, Sections, Date Section Completed B",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400C",
        "prefix": "Z0400C",
        "text": "Signature, Title, Sections, Date Section Completed C",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400D",
        "prefix": "Z0400D",
        "text": "Signature, Title, Sections, Date Section Completed D",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400E",
        "prefix": "Z0400E",
        "text": "Signature, Title, Sections, Date Section Completed E",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400F",
        "prefix": "Z0400F",
        "text": "Signature, Title, Sections, Date Section Completed F",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400G",
        "prefix": "Z0400G",
        "text": "Signature, Title, Sections, Date Section Completed G",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400H",
        "prefix": "Z0400H",
        "text": "Signature, Title, Sections, Date Section Completed H",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400I",
        "prefix": "Z0400I",
        "text": "Signature, Title, Sections, Date Section Completed I",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400J",
        "prefix": "Z0400J",
        "text": "Signature, Title, Sections, Date Section Completed J",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400K",
        "prefix": "Z0400K",
        "text": "Signature, Title, Sections, Date Section Completed K",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400L",
        "prefix": "Z0400L",
        "text": "Signature, Title, Sections, Date Section Completed L",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      } ]
    }, {
      "linkId": "Section-19/Z0500",
      "prefix": "Z0500",
      "text": "Signature of RN Coordinator Verifying Assessment Completion",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0500A",
        "prefix": "Z0500A",
        "text": "Signature",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0500B",
        "prefix": "Z0500B",
        "text": "Date RN Assessment Coordinator signed assessment as complete",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Signature date"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-19",
    "text": "Section Z: Assessment Administration",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-19/Z0100",
      "prefix": "Z0100",
      "text": "Medicare Part A Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0100A",
        "prefix": "Z0100A",
        "text": "Medicare Part A HIPPS code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0100B",
        "prefix": "Z0100B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0150",
      "prefix": "Z0150",
      "text": "Medicare Part A Non-Therapy Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0150A",
        "prefix": "Z0150A",
        "text": "Medicare Part A non-therapy HIPPS code (RUG group followed by assessment type indicator)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0150B",
        "prefix": "Z0150B",
        "text": "RUG version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0200",
      "prefix": "Z0200",
      "text": "State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0200A",
        "prefix": "Z0200A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0200B",
        "prefix": "Z0200B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0250",
      "prefix": "Z0250",
      "text": "Alternate State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0250A",
        "prefix": "Z0250A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0250B",
        "prefix": "Z0250B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0300",
      "prefix": "Z0300",
      "text": "Insurance Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0300A",
        "prefix": "Z0300A",
        "text": "Billing code",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      }, {
        "linkId": "Section-19/Z0300B",
        "prefix": "Z0300B",
        "text": "Billing version",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      } ]
    }, {
      "linkId": "Section-19/Z0400",
      "prefix": "Z0400",
      "text": "Signature of Persons Completing the Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0400A",
        "prefix": "Z0400A",
        "text": "Signature, Title, Sections, Date Section Completed A",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400B",
        "prefix": "Z0400B",
        "text": "Signature, Title, Sections, Date Section Completed B",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400C",
        "prefix": "Z0400C",
        "text": "Signature, Title, Sections, Date Section Completed C",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400D",
        "prefix": "Z0400D",
        "text": "Signature, Title, Sections, Date Section Completed D",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400E",
        "prefix": "Z0400E",
        "text": "Signature, Title, Sections, Date Section Completed E",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400F",
        "prefix": "Z0400F",
        "text": "Signature, Title, Sections, Date Section Completed F",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400G",
        "prefix": "Z0400G",
        "text": "Signature, Title, Sections, Date Section Completed G",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400H",
        "prefix": "Z0400H",
        "text": "Signature, Title, Sections, Date Section Completed H",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400I",
        "prefix": "Z0400I",
        "text": "Signature, Title, Sections, Date Section Completed I",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400J",
        "prefix": "Z0400J",
        "text": "Signature, Title, Sections, Date Section Completed J",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400K",
        "prefix": "Z0400K",
        "text": "Signature, Title, Sections, Date Section Completed K",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400L",
        "prefix": "Z0400L",
        "text": "Signature, Title, Sections, Date Section Completed L",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      } ]
    }, {
      "linkId": "Section-19/Z0500",
      "prefix": "Z0500",
      "text": "Signature of RN Coordinator Verifying Assessment Completion",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0500A",
        "prefix": "Z0500A",
        "text": "Signature",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0500B",
        "prefix": "Z0500B",
        "text": "Date RN Assessment Coordinator signed assessment as complete",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Signature date"
          }
        } ]
      } ]
    } ]
  }, {
    "linkId": "Section-19",
    "text": "Section Z: Assessment Administration",
    "type": "group",
    "readOnly": true,
    "item": [ {
      "linkId": "Section-19/Z0100",
      "prefix": "Z0100",
      "text": "Medicare Part A Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0100A",
        "prefix": "Z0100A",
        "text": "Medicare Part A HIPPS code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0100B",
        "prefix": "Z0100B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0150",
      "prefix": "Z0150",
      "text": "Medicare Part A Non-Therapy Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0150A",
        "prefix": "Z0150A",
        "text": "Medicare Part A non-therapy HIPPS code (RUG group followed by assessment type indicator)",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0150B",
        "prefix": "Z0150B",
        "text": "RUG version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0200",
      "prefix": "Z0200",
      "text": "State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0200A",
        "prefix": "Z0200A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0200B",
        "prefix": "Z0200B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0250",
      "prefix": "Z0250",
      "text": "Alternate State Medicaid Billing (if required by the state)",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0250A",
        "prefix": "Z0250A",
        "text": "Case Mix group",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      }, {
        "linkId": "Section-19/Z0250B",
        "prefix": "Z0250B",
        "text": "Version code",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "^",
            "display": "Blank (not available or unknown)"
          }
        } ]
      } ]
    }, {
      "linkId": "Section-19/Z0300",
      "prefix": "Z0300",
      "text": "Insurance Billing",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0300A",
        "prefix": "Z0300A",
        "text": "Billing code",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      }, {
        "linkId": "Section-19/Z0300B",
        "prefix": "Z0300B",
        "text": "Billing version",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 10
      } ]
    }, {
      "linkId": "Section-19/Z0400",
      "prefix": "Z0400",
      "text": "Signature of Persons Completing the Assessment",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0400A",
        "prefix": "Z0400A",
        "text": "Signature, Title, Sections, Date Section Completed A",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400B",
        "prefix": "Z0400B",
        "text": "Signature, Title, Sections, Date Section Completed B",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400C",
        "prefix": "Z0400C",
        "text": "Signature, Title, Sections, Date Section Completed C",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400D",
        "prefix": "Z0400D",
        "text": "Signature, Title, Sections, Date Section Completed D",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400E",
        "prefix": "Z0400E",
        "text": "Signature, Title, Sections, Date Section Completed E",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400F",
        "prefix": "Z0400F",
        "text": "Signature, Title, Sections, Date Section Completed F",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400G",
        "prefix": "Z0400G",
        "text": "Signature, Title, Sections, Date Section Completed G",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400H",
        "prefix": "Z0400H",
        "text": "Signature, Title, Sections, Date Section Completed H",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400I",
        "prefix": "Z0400I",
        "text": "Signature, Title, Sections, Date Section Completed I",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400J",
        "prefix": "Z0400J",
        "text": "Signature, Title, Sections, Date Section Completed J",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400K",
        "prefix": "Z0400K",
        "text": "Signature, Title, Sections, Date Section Completed K",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0400L",
        "prefix": "Z0400L",
        "text": "Signature, Title, Sections, Date Section Completed L",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      } ]
    }, {
      "linkId": "Section-19/Z0500",
      "prefix": "Z0500",
      "text": "Signature of RN Coordinator Verifying Assessment Completion",
      "type": "group",
      "repeats": false,
      "readOnly": true,
      "item": [ {
        "linkId": "Section-19/Z0500A",
        "prefix": "Z0500A",
        "text": "Signature",
        "type": "text",
        "repeats": false,
        "readOnly": false,
        "maxLength": 100
      }, {
        "linkId": "Section-19/Z0500B",
        "prefix": "Z0500B",
        "text": "Date RN Assessment Coordinator signed assessment as complete",
        "type": "open-choice",
        "repeats": false,
        "readOnly": false,
        "answerOption": [ {
          "valueCoding": {
            "system": "http://del.cms.gov",
            "code": "MMDDYYYY",
            "display": "Signature date"
          }
        } ]
      } ]
    } ]
  } ]
}  
  ''';
}
