## SDC Capabilities

**Click this video to watch the capabilities in action**

[![Walkthrough of the capabilities](https://img.youtube.com/vi/k9vEy9Z_L18/hqdefault.jpg)](https://www.youtube.com/watch?v=k9vEy9Z_L18 "Walkthrough of the Capabilities")

### Advanced Rendering
#### rendering-style
Support for colors. Usable in many places (title, text, option) as permitted by the specification.

![rendering_style](images/rendering_style.png)

#### rendering-xhtml
Comprehensive support for fonts, style, and colors. No support for tables or lists.
Usable in many places (title, text, option) as permitted by the specification.

![rendering_xhtml](images/rendering_xhtml.png)

#### help
Display items with itemControl `help` are associated with the proper question and display a help dialog.

#### supportLink
Support links are recognized and visualized. The particular action behind them is determined through an
integration point of the SDK.

![item_help](images/item_help.png)
#### displayCategory
`security` and `instructions` are supported.
![displaycategory](images/displaycategory.png)

#### optionalDisplay
The filler never chooses to omit a field from display.

#### hidden
Supported


### Item types: Grouping
#### group
Supported, but no support for item-control.

### Item types: Static display
### display
Supported for styled static output.

### Item types: Questions
#### All types
##### required
Supported. Renders a '*' after the label

##### repeats
Only supported for `choice`

##### readOnly
Supported.

#### enableWhen
Support for all behaviors: `any`, `all`

Limited support for operators:
* `=` only on coding 
* `exists` on all types
* All other operators: always return true, as to not prevent filling of the questionnaire.

#### boolean
Comprehensive support, incl. tri-state for "not answered"

#### quantity
Comprehensive support.

Special support for read-only display of total score.

Quantity requires the declaration of units. It does not support free-text entry for units.

##### Extensions
- entryFormat
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider
- sliderStepValue
- unitValueSet
- unit

#### decimal
Comprehensive support.

Special support for read-only display of total score.
##### Extensions
- entryFormat
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider
- sliderStepValue
- unit

#### integer
Comprehensive support

Special support for read-only display of total score.

Special support for 🇩🇰 Danish specification on patient feedback.

##### Extensions
- entryFormat
- minValue
- maxValue
- questionnaire-itemControl: slider
- sliderStepValue
- unit
- http://ehealth.sundhed.dk/fhir/StructureDefinition/ehealth-questionnaire-feedback

#### date
Comprehensive support. Date picker with localized format.
##### Extensions
- sdc-questionnaire-initialExpression: only recognizes literally `today()`

#### dateTime
Comprehensive support. Date/Time picker with localized format.
##### Extensions
- sdc-questionnaire-initialExpression: only recognizes literally `today()`

#### time
Comprehensive support. Time picker with localized format.

#### string, text 
Comprehensive support
##### Extensions
- entryFormat (use regular expressions, *not the "ANA NAN" format as seen in some examples.*)
- minLength  
- maxLength
- questionnaire-itemControl: text-box 

#### choice
Comprehensive support, incl. optionChoice and choices from ValueSets.
Support for multiple choice (item.repeats = true) and lookup from ValueSets (triggered automatically by large # of choices).

Support for leaving a question unanswered.

##### Extensions
- optionExclusive
- ordinalValue
- iso21090-CO-value
- choiceOrientation: supported, but `horizontal` may be ignored due to display constraints (mobile phone).
- questionnaire-optionPrefix: supported
- valueset-label: supported
- rendering-xhtml: in addition to regular capabilities may also contain a base64 encoded image of type PNG or JPEG. 
- questionnaire-itemControl: check-box, radio-button, autocomplete
- translation: option choices can be translated using the FHIR translation mechanism
- minOccurs
- maxOccurs

#### open-choice 
Same as `choice` with the following differences:
- repeats is not supported
- a single text input field labeled 'Other' is added to the selections

#### url
Supported (accepts http, https, ftp, and sftp)

#### attachment, reference
Not supported


### Scoring
Ability to add up the ordinalValue of all choice questions into a total score.

![total_score](images/total_score.png)

Total score will be entered into any field which meets one of the following:
- has extension `sdc-questionnaire-calculatedExpression` (**regardless of content of the expression!**)
- has extension `cqf-expression` (**regardless of content of the expression!**)
- is readOnly and has unit `{score}`

**No true support for FHIRPath or CQL expressions is provided!** Any field which has one of the trigger extensions will
have a total score calculcated, regardless of content of the expression!

### Response creation

#### Reference to Questionnaire
A canonical reference to the questionnaire will be generated, including a version number.

The `http://hl7.org/fhir/StructureDefinition/display` extension will not be set.

#### Status
Status can be set to any of the supported values. Setting the status to complete does currently not have impact on items affected by enableWhen (they should be discarded).

#### Authored
Will be set to the current time.

#### Narrative
A narrative will be auto-generated. Its status will be `generated`, unless it is `empty`.

#### Answers
All detail from the questions in the questionnaire carries over into the Response.

Choice answers will be marked as "user selected".

#### Example QuestionnaireResponse
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
