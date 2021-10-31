## 0.5.4-dev.7
* [Breaking] Fix hierarchy of models according to https://chat.fhir.org/#narrow/stream/179255-questionnaire/topic/Questionnaire.20Response.20example
  * This introduces a strict separation of a questionnaire and its response
    * QuestionnaireModel contains all static descriptions of the questionnaire
    * QuestionnaireResponseModel contains the result of filling a questionnaire and all dynamic behavior
  * This replaces the simplistic 1:1 relationships between items and responses with proper 1:n model

> You should not experience any breakage if you are merely using the questionnaire filler components.
> You will see numerous API changes which will require fixes if you have forked/modified.

## 0.5.4-dev.6
* Fix bug with unit extension
* WIP: repeating question items

## 0.5.4-dev.5
* [Breaking] Updated dependencies (Dart 2.14, Flutter 2.5, the latest FHIR and FHIRPath)
* [Breaking] New mandatory parameter `launchContext` to provide patient into questionnaire filler, rather
than mixing it in with the `fhirResourceProvider`.
* Support keyboard extension: https://jira.hl7.org/browse/FHIR-33675
* Use different keyboard types, based on item type and other item properties

> The following WIP items should not break anything if you are not using these features. They are experimental alphas if 
> you decide to use them. 
> 
> FHIRPath implementation provided by [Grey Faulkenberry's](https://github.com/Dokotela) through the `fhir_path` package. 
>  
> **Feedback welcome!** 
* WIP: use FHIRPath for `calculatedExpression`.
* WIP: use FHIRPath for `initialExpression`.
* WIP: use FHIRPath for `enableWhenExpression`.
* WIP: use FHIRPath for `constraint`.

* Changed handling of `questionnaireTheme` parameter
* Added `showProgress` to `QuestionnaireTheme` to enable/disable progress indicator
* Rework of total score calculations to bring more in line with `calculatedExpression` handling.

* Bugfix for questionnaires where the top level item is not a group item
* General cleanup based on new linter rules

## 0.5.3
* Another theming contribution! Again from [John Manning](https://github.com/FireJuun)
  * This one allows you to prefix the questions in a questionnaire with a running number (1, 2, 3, ...)

## 0.5.2
* More solid support for theming Faiadashu, incl. changes to its default behavior.
  * Another great contribution! This time from [John Manning](https://github.com/FireJuun)
  * Check out the illustrations at https://github.com/tiloc/faiadashu/pull/6 to learn more.
  * Both recent contributors - Grey and John - can be found for discussions on the [![FHIR-FLI Slack Channel](doc/images/Slack_RGB-98x40-335cb2d.png)](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)  
    [Join the FHIR-FLI Slack channel!](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)


* WIP progress bars, and a circular progress indicator to visualize which parts of the questionnaire have already been filled.

## 0.5.1
* Bugfix for unsupported item types

## 0.5.0
* Counting!!! How much of the questionnaire has been answered? Not yet answered? Total counts? We can count it all now!
  * Thanks [Grey Faulkenberry](https://github.com/Dokotela) for the PR and the discussions about counting requirements!
  * `count` function for questionnaire items with particular properties
  * `isAnswerable` and `isAnswered` functions
  * `QuestionnaireFillerProgress` control to visualize progress
* Bug fix for completeness checking


## 0.4.8
* Form completion: Faiadashu will perform numerous steps on completion of a form:
  * Check for presence of all required items
  * Check for validity of all answers
  * Reject completion if not all criteria are met
    * Scroll to place with faulty answer
    * Show validation error text
  * Turn form read-only when it is complete
  
* Localization:
  * All UI strings extracted into ARB files
  * Methodology developed to make translations accessible in models and views
  * Tied [github.com](https://www.github.com/tiloc) to [POEditor](https://www.poeditor.com) to enable online contributions

> **CAUTION:** The English and German translations should be decent quality.
> The other translations are rough, incomplete machine translations to illustrate
> that support of multiple languages, incl. RTL languages, is possible.
  
> **Contributions of translations are welcome!** You can either directly provide an ARB file or ask me
> for contributor access to a web-based translation environment through POEditor.
  
* Separation of `QuestionnaireScrollerPage` into 2 components
  * `QuestionnaireScroller` builds the scrolling list without a Scaffold
  * `QuestionnaireScaffoldBuilder` builds the scaffold
  
> Define your own `QuestionnaireScaffoldBuilder` to get any look & feel you want.

## 0.4.5
* Moved all implementations into `src/` sub-directories
  * This is breaking if you have previously imported implementation files directly
* Clean up of numerical model and view
* Renamed QuestionnaireViewFactory -> QuestionnaireTheme  
* Bugfix: Changes to enableWhen did not lead to a repaint
* Better focus handling: Remove keyboard while not entering text  
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
  * Thanks [Grey Faulkenberry](https://github.com/Dokotela) for the PR!
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
