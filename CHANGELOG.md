## 0.3.0-beta.1
* Documented that the architectural model is a variant of the "Presentation Model".
  This is explained in [the developer overview](doc/overview.md#presentation-model)
* Cleanup of class naming. Most notable QuestionnaireTopLocation and QuestionnaireLocation are now
QuestionnaireModel and QuestionnaireItemModel. 
* Further cleanup of model-view relationship.


## 0.2.5
* Cleanup of model-view relationship: Moved lots of functionality from view to model.

## 0.2.2
* Support for http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-itemImage
* Bugfixes

## 0.2.1
* Better support for units

## 0.2.0
* Numerous enhancements to make QuestionnaireResponse standards compliant.
* Streamlined API to provide Resources to the QuestionnaireFiller.

## 0.1.8
* Support for supportLink

## 0.1.7
* Support for open-choice
* Support for regex
* Support for entryFormat
* Support for minLength
* Support for URL  
* Support for dark mode
* Internationalized Date Picker (for FhirDateTime, Date, Time)

## 0.1.6
* Bugfixes for enableWhen, autocomplete, choice
* experimental support for data-absent-reason on responses
  - Skip question UI element
  - Visualization in narrative
* Support autocomplete item control
* Better rendering for renderingStyle
* Better documentation
* Slack invite for community building

## 0.1.5
* Support for optionExclusive
* Support for Help items
* Enable Copy&Paste of narrative
* Better documentation

## 0.1.4
* Pre-populate a questionnaire from an existing response
* Better support for enableWhen
* Much improved documentation

## 0.1.3
* Better error handling, especially for choice items
* Mention permission to use the FHIR® trademark (Thank you, Graham!)

## 0.1.2
* Much better support for ValueSets and Units
* Support for lookup from ValueSets through search-as-you-type
* Better error handling

## 0.1.0
First published release
