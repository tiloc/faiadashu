## 0.8.0
Bumping version to 0.8.0 to be aligned with corresponding `fhir` packages.

### Faiadashu
* Fixes for XHTML compliance of img tag in narrative 
(would not upload to strictly validating servers before)

### Faiadashu Example / Gallery
* Fix Beverage IG example for XHTML compliance

## 0.6.0-dev.4
### Faiadashu
* Update to Flutter 3.0, resolve new linter findings
* Update to fhir 0.8.0 and fhir_path 0.8.0 releases
* Prevent input fields from "jumping" when displaying error text

* ### Faiadashu Online
* Migrate to url_launcher 6.1.0.
* Migrate to fhir_at_rest 0.8.3 and fhir_auth 0.8.0

### Faiadashu Example / Gallery
* Update to Flutter 3.0 with Material3
* Migrate to fhir_auth 0.8.0

### Faiabench
* Adapt to API changes in fhir_path 0.8.0
* Adapt to API changes in multi_split_view 2.0.0

## 0.6.0-dev.3
* ### Faiadashu
* Reworked visual style
  * More space after each question
  * Maximum width is clamped and can be controlled
  * InputDecorations are now entirely driven by ThemeData
  * Support link icons is determined by ThemeData (iconTheme)
  * Style of filler for choice/open-choice/coding is determined by ThemeData
  * Exclusive choices use checkbox instead of radio button. The old way was more "logical", but looked ugly
  * Font defaults to bodyText2 (oddly, bodyText1 is not the default for Material widgets)
  * Removed the ability to put the label to the left of the question (best practice by Norman Nielsen group)
  * Better alignment + spacing for title elements (leading, help)
  * Error text doesn't make the text fields jump
  * Better cross-fades when questions become visible or invisible. 
* Reverted to the original Flutter Autocomplete widget, and use its new fieldViewBuilder parameter
  * Better theming
  * Keyboard navigation
* NarrativeTile uses native WebView when available.
  * supported on Android, iOS, web
  * supports <img> tags, and thus itemMedia, and XHTML with <img>
* Support for bi-state for boolean (tri-state continues to be supported)
  * Less confusing for the average user
* Moved away from helper methods to small Widgets
* Converted QuestionnaireTheme to InheritedWidget for alignment with general theming in Flutter
* Support for `initial.value[x]`
* Reworked the choice/open-choice/coding model.
* Model visibility similar to R5 `disabledDisplay`
* Removed centralized `ChangeNotifier` in QuestionnaireResponseModel
  * Introduce more focussed notifiers 
  * Drastically reduced number of repaints
* Put a `RepaintBoundary` around the circular progress
  * Reduces size of repainted area from full-screen to small rectangle
* Trained a Skia shader to reduce yank.
* Parallelize initialization of FHIR resources. Noticeable speed up.
* Drastic performance optimizations for evaluation of FHIRPath expressions
* Don't take disabled answers into account for expressions
* Reverted the async madness
* Allow each answer to have its own validation outcome `errorText`.
* Updated dependencies
* Changed from relative imports to absolute package imports

* ### Faiadashu Online
* Brought back the login/logout functionality, based on latest `fhir_auth` package.

* ### Faiadashu Example / Gallery
* Added more functional testing questionnaires
* More comprehensive demo of theming, including InputDecoration, colors, and font.

## 0.6.0-dev.2
* ### Introducing "Faiabench"
  * Using the best of `fhir`, `fhir_path`, and `faiadashu` to offer an IDE-like workbench experience
    * live display of SDC Questionnaire Filler
    * color-coded, formatted input/output of FHIR Resources (Patient, Questionnaire, QuestionnaireResponse)
    * data exchange through clipboard copy/paste
    * live evaluation of FHIR Path expressions
> _Faiabench_ is pushing Dart and Flutter to the limit.
> * only works on desktops or landscape tablets, due to screen size requirements
> * requires Flutter 2.8 due to bugs in earlier versions of Flutter
> * keyboard input to FHIR Path field broken on Mac, due to bugs in macOS Flutter: https://github.com/flutter/flutter/issues/94633

* ### Faiadashu Example / Gallery
* Added demos of all the new capabilities listed for Faiadashu.
* Renamed package to `com.legentix.faiagallery`, in order for it to be globally unique (required for some Apple signing stuff)
* Beginning to rename Example to Gallery. Planning to have a much simpler example at some point. And then Gallery shows off everything.

* ### Faiadashu
* **[Breaking]** Reworked support for FHIRPath expressions
  * Cleanly carved out into new `expression` module
  * Made async in preparation for query expressions
  * Made all model operations that depend on expressions async
  * Support for item-level expressions
  * Support for %questionnaire, %qitem, %context, %resource
    * see "Variable Scope Test" in the Gallery for an example
* **[Breaking]** Introduction of new RenderingString type to handle items which can have plain and styled text
  * Supports plain, XHTML, and Markdown
  * Implemented throughout numerous models and views
  * Side-effect: Narrative can now contain images
* **[Breaking]** Moved [John Manning's](https://github.com/FireJuun) question counting contribution from view to model.
  * More flexibility for different prefix/numeral algorithms
  * Prefix can be output into narrative
  * Flexible formatting in combination with RenderingString
* Support for `rendering-markdown` extension
* Support drop-down control for coding answers
* Support for 'prompt' item control
* Support itemAnswerMedia extension for a clean way to add images to coding answers
* Support specifying defaults for some model properties (e.g. maxDecimal)
* Support usageMode extension (hide elements during filling, or during narrative creation)
* Basic support for choiceColumn extension
* Fixed count methods to get accurate count of unanswered questions
* Improvements in the display of errors
* NarrativeTile can use an existing narrative, rather than always generating a new one
* Removing a repeating answer will notify listeners
* Use LayoutBuilder instead of MediaQuery to work better when embedded into surrounding UI (e.g. in Faiabench)

* Introduced a presentation model for individual answer options in coding questions.

* Updated dependencies, including [Grey Faulkenberry's](https://github.com/Dokotela) latest and greatest `fhir_path` package.

* ### Faiadashu Online
* **[Breaking]** Upgrade to latest fhir_auth. Login/Logout functionality is currently lost.


## 0.6.0-dev.1
* **[Breaking]** Fix hierarchy of models according to https://chat.fhir.org/#narrow/stream/179255-questionnaire/topic/Questionnaire.20Response.20example
  * This introduces a strict separation of a questionnaire's structure and a response to this questionnaire
    * QuestionnaireModel contains all static, structural descriptions of the questionnaire
    * QuestionnaireResponseModel contains the result of filling a questionnaire and all dynamic behavior
  * This replaces the previous, simplistic 1:1 relationships between items and responses with proper nested 1:n model
    * Answers can have **nested responses** now. This is a major improvement that could only be enabled through the cleaned up data model.
      * Nested items are created as needed during the initial population of the model - See Bluebook Vitamin K for example.
      * Nested items are created as needed during human interaction (question with nested items is being answered for 
      the first time) - See LOINC AHRQ for example.
      * Nested items are enabled/disabled based on their parent answer
      * >Some dynamic behaviors (initialValue, calculatedExpression...) are not activated for subsequently added nested questions yet
  * Clarified the relationship between FHIR and Presentation Model. The FHIR `QuestionnaireResponse` is used during
model creation to populate the presentation model, and it is created by the aggregator from the presentation model.
But it is not used in between anymore. This is resolving a lot of inconsistencies and complexities.

* QuestionnaireModel is no longer inheriting from QuestionnaireItemModel. This weird relationship had to end.
    
> You should not experience any breakage if you are merely using the questionnaire filler components.
> You will see numerous API changes which will require fixes if you have forked/modified.

> The documentation has been updated to reflect the changes.

* **Repeating question items:** Answers to repeating question items can be added and removed now.
This is a major improvement that could only be enabled through the cleaned up data model.


* More possibilities for theming
* Better narrative generator
* JSON tree copies individual items to clipboard by tapping on them

* Updated dependencies
* Introduced stricter code analysis and fixed some findings

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
