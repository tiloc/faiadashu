## SDC Capabilities

**Click this video to watch the capabilities in action**

[![Walkthrough of the capabilities](https://img.youtube.com/vi/k9vEy9Z_L18/hqdefault.jpg)](https://www.youtube.com/watch?v=k9vEy9Z_L18 "Walkthrough of the Capabilities")

### Advanced Rendering
#### rendering-style
Support for colors. Usable in many places (title, text, option) as permitted by the specification.
#### rendering-xhtml
Comprehensive support for fonts, style, and colors. No support for tables or lists.
Usable in many places (title, text, option) as permitted by the specification.

#### hidden
Supported

#### displayCategory
`security` and `instructions` are supported.

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
##### Extensions
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider
- sliderStepValue
#### decimal
Comprehensive support.

Special support for read-only display of total score.
##### Extensions
- minValue
- maxValue
- maxDecimalPlaces
- questionnaire-itemControl: slider
- sliderStepValue

#### integer
Comprehensive support

Special support for read-only display of total score.

Special support for Danish specification on patient feedback.

##### Extensions
- minValue
- maxValue
- questionnaire-itemControl: slider
- sliderStepValue
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
- maxLength
- questionnaire-itemControl: text-box 

#### choice
Comprehensive support, incl. optionChoice and choices from ValueSets.
Support for multiple choice (item.repeats = true) and lookup from ValueSets (triggered automatically by large # of choices).

Support for leaving a question unanswered.

##### Extensions
- ordinalValue
- iso21090-CO-value
- choiceOrientation: supported, but `horizontal` may be ignored due to display constraints (mobile phone).
- questionnaire-optionPrefix: supported
- valueset-label: supported
- rendering-xhtml: in addition to regular capabilities may also contain a base64 encoded image of type PNG or JPEG. 
- questionnaire-itemControl: check-box, radio-button
- translation: option choices can be translated
#### open-choice 
Same as `choice`, no support for open text input yet.

#### url, attachment, reference
Not supported


### Scoring
Ability to add up the ordinalValue of all choice questions into a total score.

Total score will be entered into any field which meets one of the following:
- has extension `sdc-questionnaire-calculatedExpression` (**regardless of content of the expression!**)
- has extension `cqf-expression` (**regardless of content of the expression!**)
- is readOnly and has unit `{score}`

**No true support for FHIRPath or CQL expressions is provided!** Any field which has one of the trigger extensions will
have a total score calculcated, regardless of content of the expression!

### Response creation
All detail from the questions in the questionnaire carries over into the Response.

A narrative will be auto-generated.

Choice answers will be marked as "user selected".
