## 0.4.5
* Moved all implementations into `src/` sub-directories
* Clean up of numerical model and view
* Renamed QuestionnaireViewFactory -> QuestionnaireTheme  
* Bugfix: Changes to enableWhen did not lead to a repaint  
* Early WIP steps for completion handling
  * Complete button control
  * QuestionnaireResponseAggregator will not emit items which are not enabled, when status is `complete`.
* Documentation updates


## 0.4.2
* Numerous visual improvements.
  * Nicer looking input fields based on Material research
  * Icons on date/time fields
  * More options can be controlled through QuestionnaireViewFactory
* Introduction of [Faiadashu Online](faiadashu_online/README.md)
  * Example App can upload QuestionnaireResponse to real, protected FHIR(R) server.

## 0.4.0
* Refactorings to have a clean relationship between views and models.
  * Non-breaking for high-level use. Breaking for low-level use.
* QuestionnaireViewFactory allows injection of own view classes for overrides of visualizations.  
* new model method 'isInvalid'.
* QuestionnaireScrollerPage will scroll to first invalid or unfilled item
* QuestionnaireScrollerPage will scroll the item more towards the middle of the screen, rather than the very top.
* QuestionnaireScrollerPage supports specification of persistentFooterButtons
* Visual improvements to NarrativePage

## 0.3.2
* QuestionnaireScrollerPage will focus on first unfilled item
* Improvements in focus traversal
* Improvements to determination whether a field has response
* Performance: Prevent unnecessary recreation of QuestionnaireItemFillerData

## 0.3.1
* QuestionnaireScrollerPage will scroll to first unfilled item
* Numbers and strings will be validated when a pre-populated questionnaire is opened.  
* QuestionnaireItemModel has new property 'unanswered'
* Naming cleanups according to Effective Dart guidance
* Better error display
* Locale support for QuestionnaireStepperPage
* Better documentation

## 0.3.0
* Fixed a bug on desktop that made it impossible to enter spaces into text fields (workaround for [Flutter Issue 81233](https://github.com/flutter/flutter/issues/81233)).
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
