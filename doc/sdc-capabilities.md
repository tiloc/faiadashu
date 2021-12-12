# Structured Data Capture (SDC) Capabilities
The Form Filler is based on a specification called [Structured Data Capture (SDC)](https://hl7.org/fhir/uv/sdc/2019May/index.html).

Information on Structured Data Capture can be found here:
* [SDC Home Page](https://hl7.org/fhir/uv/sdc/2019May/)
* [YT Video from FHIR DevDays](https://www.youtube.com/watch?v=WPudaF4S7Bk)
* There is a chat channel at https://chat.fhir.org stream `#questionnaire`.

**Click this video to watch the capabilities in action**

[![Walk-through of the capabilities](https://img.youtube.com/vi/k9vEy9Z_L18/hqdefault.jpg)](https://www.youtube.com/watch?v=k9vEy9Z_L18 "Walk-through of the Capabilities")



## Items by Category
FHIR categorizes item types into three categories:
1. Group
2. Display
3. Question

### All categories
Group, Display, and Questions share several commonalities.

#### Styled Rendering
See: https://www.hl7.org/fhir/rendering-extensions.html
##### rendering-style
Support for colors. Usable in many places (title, text, option) as permitted by the specification.

![rendering_style](images/rendering_style.png)

###### rendering-xhtml
Comprehensive support for fonts, style, and colors. No support for tables or lists.
Usable in many places (title, text, option) as permitted by the specification.

![rendering_xhtml](images/rendering_xhtml.png)

###### rendering-markdown
Support for GitHub Flavored Markdown ("GFM" CommonMark).
Usable in many places (title, text, option) as permitted by the specification.

###### rendering-styleSensitive
Silently ignored, as rendering will always preserve full styling.

#### User Assistance 
###### help
Display items with itemControl `help` are associated with the proper question and display a help dialog.

###### supportLink
Support links are recognized and visualized. The particular action behind them is determined through an
integration point of the SDK.

#### Decorations
###### shortText
Supported

![item_help](images/item_help.png)
###### displayCategory
Supports `security` and `instructions`.
![displayCategory](images/displaycategory.png)

#### Visibility

###### hidden
Supported

###### usageMode
Supported during filling of questionnaire ("capture"), and for generation of a narrative ("display").

##### optionalDisplay
The filler never chooses to omit a field from display.

#### Enablement
Items can be shown or hidden depending on dynamic conditions.

###### enableWhen
Support for all behaviors: `any`, `all`

Limited support for operators:
* `=` only on `Coding`
* `exists` on all types
* All other operators: **unsupported** (always return true, as to not prevent filling of the questionnaire.)

> `enableWhenExpression` can be used for more complex evaluations.

###### enableWhenExpression
Fully supported.

Reference:
[sdc-questionnaire-enableWhenExpression](http://build.fhir.org/ig/HL7/sdc/StructureDefinition-sdc-questionnaire-enableWhenExpression.html)

### Item category: Display
#### display
Supported.

### Item category: Group
#### group
Supported.

###### required
Supported.
* Renders an asterisk (*) after the label
* Evaluated as a constraint on check for completeness

###### repeats
Not supported.

###### item-control
Not supported.

### Item category: Question
#### All types
###### required
Supported. 
* Renders an asterisk (*) after the label
* Evaluated as a constraint on check for completeness

###### repeats
Supported. Renders a multi-selection for items of type `choice`. Not supported for `open-choice`. 
Renders UI elements to add/remove repeating answers for all other item types.

The label of the UI element uses the `shortText` as a description for a single item.

###### readOnly
Supported.

###### itemControl: prompt
Reference:
[questionnaire-item-control-prompt](http://hl7.org/fhir/R4/codesystem-questionnaire-item-control.html#questionnaire-item-control-prompt)
Text is displayed immediately below the containing question item (typically as a guide for what to enter)

###### itemMedia
An image to display as a visual accompaniment to the question being asked.
> Only inlined images are supported. 
> Only small image formats are supported.

Reference: 
[sdc-questionnaire-itemMedia](http://build.fhir.org/ig/HL7/sdc/StructureDefinition-sdc-questionnaire-itemMedia.html)

---
#### boolean
Comprehensive support, incl. tri-state for "not answered"

See: http://build.fhir.org/questionnaire.html#booleans for a discussion of tri-state.

---
#### quantity
Comprehensive support.

Special support for read-only display of total score.

> Quantity requires the declaration of units. It does not support free-text entry for units.

##### Extensions
- entryFormat
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider (see below for details)
- sliderStepValue
- unitValueSet
- unit

##### Slider control
When an item control of type "slider" is being used, then a maxValue should be provided. Otherwise a default value (typically: 100)
will be used, since an unlimited maxValue is not possible.

Nested display items with itemControl `upper` and `lower` are associated with the slider control and will display as upper and lower
label. They support [styled rendering](#styled-rendering).

---
#### decimal
Comprehensive support.

Special support for read-only display of total score - see [Scoring](#scoring)

##### Extensions
- entryFormat
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider (see above for details)
- sliderStepValue
- unit
- calculatedExpression

---
#### integer
Comprehensive support

Special support for read-only display of total score - see [Scoring](#scoring)

Special support for 🇩🇰 Danish specification on patient feedback.

##### Extensions
- entryFormat
- minValue
- maxValue
- questionnaire-itemControl: slider (see above for details)
- sliderStepValue
- unit
- http://ehealth.sundhed.dk/fhir/StructureDefinition/ehealth-questionnaire-feedback

---
#### date
Comprehensive support. Date picker with localized format.

##### Extensions
- (none)

---
#### dateTime
Comprehensive support. Date/Time picker with localized format.

##### Extensions
- sdc-questionnaire-initialExpression

#### time
Comprehensive support. Time picker with localized format.

#### string, text 
Comprehensive support. Keyboard type can be hinted.

##### Extensions
- entryFormat (use regular expressions, *not the "ANA NAN" format as seen in some examples.*)
- minLength  
- maxLength
- regex  
- questionnaire-itemControl: text-box 
- sdc-questionnaire-keyboard: email, phone, number

---
#### choice
Comprehensive support, incl. optionChoice and choices from ValueSets.
Support for multiple choice (item.repeats = true) and autocomplete from ValueSets (triggered automatically by large # of choices).

Support for leaving a question unanswered.

##### Value Sets
The value set `http://hl7.org/fhir/ValueSet/yesnodontknow` is hard-coded into the library and always available.

See: http://build.fhir.org/questionnaire.html#valuesets

##### Extensions
- optionExclusive
- ordinalValue
- iso21090-CO-value
- choiceOrientation: supported, but `horizontal` may be ignored due to display constraints (mobile phone).
- questionnaire-optionPrefix: supported
- valueset-label: supported
- rendering-xhtml: in addition to regular capabilities may also contain a base64 encoded image of type PNG or JPEG.
- itemAnswerMedia: supports images of type PNG or JPEG.
- questionnaire-itemControl: drop-down, check-box, radio-button, autocomplete
- translation: option choices can be translated using the FHIR translation mechanism
- minOccurs
- maxOccurs
- choiceColumn: Supports paths `code` and `display`. Support `forDisplay`. No support for column widths.

> `itemAnswerMedia` should be favoured over `rendering-xhtml` to add images to answer options. 

---
#### open-choice 
Same as `choice` with the following differences:
- repeats is not supported
- a single text input field is presented below the selections

##### Extensions
- openLabel

The label for the "open" choice. Default is "Other"

---
#### url
Supported (accepts http, https, ftp, and sftp)

---
#### attachment, reference
Not supported

---
## Expressions
Support for expressions of types:
* `text/fhirpath`

_No_ support for:
* CQL
* Server Queries

### FHIRPath
> FHIRPath support in Faiadashu is getting better every day, and should be very useful for many real-world scenarios.
>
> It uses [fhir_path](https://pub.dev/packages/fhir_path) as its
> underlying implementation. See the [fhir_path documentation](https://pub.dev/packages/fhir_path)
> for current capabilities and limitations.

#### Environment
* %resource
* %context
* %qitem

_No_ support for:
* %rootResource
* %ucum
* %sct
* %loinc

#### SDC functions
* answers()
* ordinal()
* sum()

### Variables
Full support for variables, on questionnaire level and item level. Proper support for visibility rules.
Specification: https://www.hl7.org/fhir/extension-variable.html

---
### Scoring
The ordinalValue of all choice questions can be summed up into a total score.

The total score will be entered into a field which meets one of the following characteristics:
- is readOnly and has extension `http://hl7.org/fhir/StructureDefinition/questionnaire-unit` with *display* value = `{score}`
- has a calculatedExpression with name 'score'

> The well-known [NLM Form Builder](https://lhcformbuilder.nlm.nih.gov) will set the `questionnaire-unit` extension
> to `{score}`, but will not set the item to `readOnly`. Setting this manually to `true` will result in a questionnaire
> with fully functioning scoring.

A total score field will be visualized with a "Total Score" heading and a large number.

![total_score](images/total_score.png)

It will also evaluate and visualize the Danish http://ehealth.sundhed.dk/fhir/StructureDefinition/ehealth-questionnaire-feedback extension
for patient feedback.

> Handling of `calculatedExpression` is mature enough for scoring, and is the recommended approach.

> The feedback extension can be replaced by `enableWhenExpression` on `display` items.

## Response creation

### Reference to Questionnaire
A canonical reference to the questionnaire will be generated, including a version number.

The optional `http://hl7.org/fhir/StructureDefinition/display` extension will be set when the questionnaire has a title.

### Status
Status can be set to any of the supported values. Setting the status to `complete` discards items which are not enabled.

### Authored
Will be set to the current time.

### Narrative
A narrative will be auto-generated. Its status will be `generated`. Empty narratives will be omitted entirely.

### Subject
A reference to the subject will be added if a subject with an `id` is present. The SDK can be requested to place the
entire `Patient` into the `contained` section of the QuestionnaireResponse.

### Answers
All detail from the questions in the questionnaire carries over into the Response.

Choice answers will be marked as "user selected".

### Example QuestionnaireResponse
```json
{
  "resourceType": "QuestionnaireResponse",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3>Over the past 2 weeks, how much has your heart failure limited your enjoyment of life?</h3><p>It has moderately limited my enjoyment of life</p><h3>Overall summary score</h3><p>3 {score}</p></div>"
  },
  "status": "unknown",
  "authored": "2021-04-03T17:49:47.261704",
  "item": [
    {
      "linkId": "/hfcode-923-0",
      "text": "Please indicate how much you are limited by <b>heart failure</b> (<i>shortness of breath or fatigue</i>) in your ability to do the following activities over the past 2 weeks.",
      "item": [
        {
          "linkId": "/hfcode-IV88-IV",
          "text": "Over the past 2 weeks, how much has your heart failure limited your enjoyment of life?",
          "answer": [
            {
              "valueCoding": {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/iso21090-CO-value",
                    "valueDecimal": 3
                  }
                ],
                "code": "CODE-II-7747-7",
                "display": "It has moderately limited my enjoyment of life",
                "userSelected": true
              }
            }
          ]
        },
        {
          "linkId": "/hfcode-924-8",
          "text": "Overall summary score",
          "answer": [
            {
              "valueQuantity": {
                "value": 3,
                "unit": "{score}"
              }
            }
          ]
        }
      ]
    }
  ]
}
```

## Support for other Implementation Guides
### Argonaut
[Argonaut](http://fhir.org/guides/argonaut/questionnaire/index.html) is a subset of SDC and based on FHIR R3. The Form Filler is based on FHIR R4, which inherently makes it non-conformant
to Argonaut. It does fill all the corresponding mandatory fields in the R4 QuestionnaireResponse.

