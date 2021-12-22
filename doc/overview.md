## Overview
*Faiadashu FHIRDash* is a collection of Widgets that allow for the fast creation of healthcare apps based on the Flutter framework.

## Installation
Follow the instructions on pub.dev: https://pub.dev/packages/faiadashu/install

## Prerequisites / Assumptions
The library is trying to make as few assumptions as possible about its operating environment.

### Supported versions of Flutter™ SDK
This library depends on Flutter™ SDK 2.8.0, or later. It is null-safe. It cannot be used with earlier versions of the SDK.

### Support for the FHIR Standard
Faiadashu focuses on the user interface. The underlying data models and specifications are adopted from the FHIR standard and
the FHIR-FLI `fhir` library. It uses the R4 version of the library, and thus is aligned with the R4 editions
of FHIR, or any other Implementation Guide it supports.

[![Pub Version](https://img.shields.io/pub/v/fhir?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/fhir)
https://pub.dev/packages/fhir

Discussions and support around Faiadashu and the FHIR-FLI library can be found on the FHIR-FLI Slack channel:

[![FHIR-FLI Slack Channel](images/Slack_RGB-98x40-335cb2d.png)](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)  
[Join the FHIR-FLI Slack channel!](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)


Support for the FHIR Standard is focussed on the R4 release which is located here: [![FHIR R4](fhir-logo-www.png)](https://hl7.org/fhir/R4/)  https://hl7.org/fhir/R4/

### Theme
#### Styles
Styles - including text and colors - is obtained through the Material theme of the app. Both dark and light schemes work.

#### Questionnaire theming
Behaviors of the questionnaire filler that affect visualizations, but don't have an equivalent in the presentation model,
can be influenced by instantiating a `QuestionnaireTheme` and passing it  into the filler through any constructor which
has a `questionnaireTheme` parameter.

**Examples are:**
* should an option to skip questions be presented?
* should coding questions offer an option to answer with a `null` = no answer?

Behaviors that are driven by the presentation model can be influenced by instantiating a `QuestionnaireModelDefaults`
and passing it into the filler through the `questionnaireModelDefaults` parameter.

**Examples are:**
* auto-generated question prefixes (for instance to count questions)
* default maximum value for sliders

### Locale
Locale is explicitly passed to the library during the initialization of the `QuestionnaireFiller`.

Each filling of a questionnaire can use a different locale, but it cannot be changed while a questionnaire is being filled.

#### Translations
The translation methodology is based on standard Flutter mechanisms, using ARB files.

See [Internationalizing Flutter Apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

> Contributions of translations are welcome! You can either directly provide an ARB file or ask me
> for access to a web-based translation environment through POEditor.


### Logging
The library is logging through the 'logging' package: https://pub.dev/packages/logging
This will not result in any actual logging, unless you register a logger in your app.

### State-handling
The library does not make any assumptions about the presence of a state-handling framework,
such as Redux, GetX, Provider, Riverpod, Bloc/Cubit... It only uses basic mechanisms from the
Flutter SDK (StatefulWidget, ValueNotifier) and should be interoperable with any of these.  

### Persistence
The library does not persist anything. It is up to your app to obtain persisted information and to persist the output
of the library as you see fit. See the sections on the individual use-cases for integration points.

The FHIR-FLI `fhir_db` package is compatible with the `fhir` library which is underlying this library: https://pub.dev/packages/fhir_db  

### Communication
The `faiadashu` library does not contain functionality to communicate with servers. It is up to your app to obtain remoted information and to send the output
of the library as you see fit. See the sections on the individual use-cases for integration points.

#### Faiadashu Online
The `faiadashu_online` package is an add-on to `faiadashu` and is providing basic support for protected and unprotected FHIR communication. 

Faiadashu Online is using two underlying libraries: `fhir_at_rest` and `fhir_auth`.

FHIR-FLI `fhir_at_rest` package: https://pub.dev/packages/fhir_at_rest

Communication with protected servers requires authentication. 
FHIR-FLI `fhir_auth` package: https://pub.dev/packages/fhir_auth

Setting up `fhir_auth` is non-trivial. *TBD*

### Use-Case: Display an Observation
```
final bpObservation = Observation(...); // Construct your FHIR Observation here.

return ObservationWidget(
        bpObservation,
        valueStyle: Theme.of(context).textTheme.headline4,
        codeStyle: Theme.of(context).textTheme.subtitle2,
        dateTimeStyle: Theme.of(context).textTheme.caption,
      );
```

### Use-Case: Fill a Questionnaire
#### Capabilities
The Questionnaire Filler widget is based on a specification called Structured Data Capture (SDC).

[The capabilities of this widget are documented here](sdc-capabilities.md).

Information on Structured Data Capture can be found here: 
* [SDC Home Page](http://hl7.org/fhir/uv/sdc/2019May/)
* [YT Video from FHIR DevDays](https://www.youtube.com/watch?v=WPudaF4S7Bk)
* There is a chat channel at https://chat.fhir.org stream `#questionnaire`.


#### Code example
The display and filling of a Questionnaire is entirely self-contained. You create the widget to fill a Questionnaire,
return it as part of your `build()` method and lean back.

```dart
final widget = QuestionnaireScrollerPage(
                          AssetResourceProvider.singleton(Questionnaire,
                              'assets/instruments/sdc_demo.json'),
                          resourceProvider: resourceProvider,
                          floatingActionButton: fab);
```

#### Flavors
The filler widget comes in two flavors:
* `QuestionnaireScrollerPage`: A vertically scrolling filler
* `QuestionnaireStepperPage`: A side-ways, wizard-style filler

Both of these flavors will take over the entire screen and bring their own Scaffold. An embeddable filler is contained in
`QuestionnaireFiller`. This will return a list of Widgets — one for each question — that can be used for arbitrary UI designs.

#### Integration points
The main integration point is the `ResourceProvider` which is being used by the library to obtain
content, such as the actual questionnaire, or the referenced ValueSets.

A ResourceProvider is a very simple, asynchronous mapping-mechanism from URIs to Resources. The library is providing
a set of reference implementations, but it is very easy to implement your own provider, based on your required
sources of information (web-server, EMR, file system,...).

> Faiadashu Online is providing an implementation of `ResourceProvider` that can connect to FHIR servers.

##### Questionnaire
The library is looking for the Questionnaire through the URI in constant `questionnaireResourceUri`.

##### ValueSets and CodeSystems
The library is looking for the ValueSets and CodeSystems under the URI through which they are referenced.

##### QuestionnaireResponse
The current state of the questionnaire can be compiled into a QuestionnaireResponse at any time through the following code:
```dart
final response = QuestionnaireFiller.of(context)
  .aggregator<QuestionnaireResponseAggregator>()
    .aggregate(locale);
```

##### URL launching
It is up to the finished application if and how it wants to launch external URLs. The SDK offers an integration point
through the `onLinkTap` function which is called every time a user taps a link - a `supportLink` for instance.


--------------------

Faiadashu Online uses the popular [url_launcher](https://pub.dev/packages/url_launcher) package to implement a launcher
for supportLinks.

When using `url_launcher` it is important to follow the native setup instructions for iOS and Android 11.

--------------------

##### Error handling
###### During initialization
A `QuestionnaireFormatException` is thrown.

###### During filling
The filler will display informative error boxes.

![error_widget](images/error_widget.png)

#### Architecture
##### Presentation Model
The Questionnaire Filler is based on a bespoke variation of the [Presentation Model - PM](https://martinfowler.com/eaaDev/PresentationModel.html).
It is focussed on filling an information model with user-input and does not have any true business-logic, storage,
or communication.

> Presentation Model is known in the Microsoft ecosystem as **_MVVM_**.

###### Questionnaire Structure Definition
The structural definition of a questionnaire is not visible, and thus no view for it exists.
They offer a presentation model to support the views of the questionnaire response.

|          Presentation Model  |  Domain Model (FHIR) |
|----------------------|---------------------|
| QuestionnaireModel| Questionnaire |
| QuestionnaireItemModel| QuestionnaireItem | 

###### Questionnaire Response
The questionnaire response is modeled through the following models.

| View                |          Presentation Model  |  Domain Model (FHIR) |
|---------------------|----------------------|---------------------|
| QuestionnaireResponseFiller | QuestionnaireResponseModel _(with references to QuestionnaireModel)_ |  QuestionnaireResponse |
| QuestionnaireResponseItemFiller | QuestionnaireResponseItemModel _(with references to QuestionnaireItemModel)_ | QuestionnaireResponseItem | 
| QuestionnaireAnswerFiller | AnswerModel|  QuestionnaireAnswerItem |
