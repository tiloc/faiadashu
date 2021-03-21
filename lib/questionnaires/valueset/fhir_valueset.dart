import 'dart:convert';

import 'package:fhir/r4.dart';

class FhirValueSet {
  // TODO: Caching
  static ValueSet? getValueSet(String uri) {
    switch (uri) {
      case 'http://hl7.org/fhir/ValueSet/administrative-gender':
        // TODO: Carve out into an extension
        return ValueSet(
            compose: ValueSetCompose(include: [
          ValueSetInclude(
              concept: CodeSystem.fromJson(
                      jsonDecode(administrativeGenderCodeSystemRaw)
                          as Map<String, dynamic>)
                  .concept!
                  .map<ValueSetConcept>((csConcept) {
            return ValueSetConcept(
                code: csConcept.code, display: csConcept.display);
          }).toList())
        ]));
      case 'http://hl7.org/fhir/ValueSet/yesnodontknow':
        return ValueSet.fromJson(
            jsonDecode(yesNoDontKnowValueSetRaw) as Map<String, dynamic>);
      default:
        return null;
    }
  }

  static String administrativeGenderCodeSystemRaw = r'''
{
  "resourceType" : "CodeSystem",
  "id" : "administrative-gender",
  "meta" : {
    "lastUpdated" : "2019-11-01T09:29:23.356+11:00"
  },
  "text" : {
    "status" : "extensions",
    "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h2>AdministrativeGender</h2><div><p>The gender of a person used for administrative purposes.</p>\n</div><p>This code system http://hl7.org/fhir/administrative-gender defines the following codes:</p><table class=\"codes\"><tr><td style=\"white-space:nowrap\"><b>Code</b></td><td><b>Display</b></td><td><b>Definition</b></td><td><b>Comments</b></td></tr><tr><td style=\"white-space:nowrap\">male<a name=\"administrative-gender-male\"> </a></td><td>Male</td><td>Male.</td><td>Male</td></tr><tr><td style=\"white-space:nowrap\">female<a name=\"administrative-gender-female\"> </a></td><td>Female</td><td>Female.</td><td>Female</td></tr><tr><td style=\"white-space:nowrap\">other<a name=\"administrative-gender-other\"> </a></td><td>Other</td><td>Other.</td><td>The administrative gender is a value other than male/female/unknown. Where this value is selected, systems may often choose to include an extension with the localized more specific value.</td></tr><tr><td style=\"white-space:nowrap\">unknown<a name=\"administrative-gender-unknown\"> </a></td><td>Unknown</td><td>Unknown.</td><td>A proper value is applicable, but not known.  Usage Notes: This means the actual value is not known. If the only thing that is unknown is how to properly express the value in the necessary constraints (value set, datatype, etc.), then the OTH or UNC flavor should be used. No properties should be included for a datatype with this property unless:  Those properties themselves directly translate to a semantic of &quot;unknown&quot;. (E.g. a local code sent as a translation that conveys 'unknown') Those properties further qualify the nature of what is unknown. (E.g. specifying a use code of &quot;H&quot; and a URL prefix of &quot;tel:&quot; to convey that it is the home phone number that is unknown.)</td></tr></table></div>"
  },
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg",
    "valueCode" : "pa"
  },
  {
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "normative"
  },
  {
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm",
    "valueInteger" : 5
  },
  {
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-normative-version",
    "valueCode" : "4.0.0"
  }],
  "url" : "http://hl7.org/fhir/administrative-gender",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:2.16.840.1.113883.4.642.4.2"
  }],
  "version" : "4.0.1",
  "name" : "AdministrativeGender",
  "title" : "AdministrativeGender",
  "status" : "active",
  "experimental" : false,
  "date" : "2019-11-01T09:29:23+11:00",
  "description" : "The gender of a person used for administrative purposes.",
  "caseSensitive" : true,
  "valueSet" : "http://hl7.org/fhir/ValueSet/administrative-gender",
  "content" : "complete",
  "concept" : [{
    "extension" : [{
      "url" : "http://hl7.org/fhir/StructureDefinition/codesystem-concept-comments",
      "valueString" : "Male"
    }],
    "code" : "male",
    "display" : "Male",
    "definition" : "Male."
  },
  {
    "extension" : [{
      "url" : "http://hl7.org/fhir/StructureDefinition/codesystem-concept-comments",
      "valueString" : "Female"
    }],
    "code" : "female",
    "display" : "Female",
    "definition" : "Female."
  },
  {
    "extension" : [{
      "url" : "http://hl7.org/fhir/StructureDefinition/codesystem-concept-comments",
      "valueString" : "The administrative gender is a value other than male/female/unknown. Where this value is selected, systems may often choose to include an extension with the localized more specific value."
    }],
    "code" : "other",
    "display" : "Other",
    "definition" : "Other."
  },
  {
    "extension" : [{
      "url" : "http://hl7.org/fhir/StructureDefinition/codesystem-concept-comments",
      "valueString" : "A proper value is applicable, but not known.  Usage Notes: This means the actual value is not known. If the only thing that is unknown is how to properly express the value in the necessary constraints (value set, datatype, etc.), then the OTH or UNC flavor should be used. No properties should be included for a datatype with this property unless:  Those properties themselves directly translate to a semantic of \"unknown\". (E.g. a local code sent as a translation that conveys 'unknown') Those properties further qualify the nature of what is unknown. (E.g. specifying a use code of \"H\" and a URL prefix of \"tel:\" to convey that it is the home phone number that is unknown.)"
    }],
    "code" : "unknown",
    "display" : "Unknown",
    "definition" : "Unknown."
  }]
}''';

  static String yesNoDontKnowValueSetRaw = r'''
{
  "resourceType": "ValueSet",
  "id": "yesnodontknow",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n      <h3>Value Set Contents</h3>\n      <p>This value set contains 3 concepts</p>\n      <table class=\"codes\">\n        <tr>\n          <td style=\"white-space:nowrap\">\n            <b>Code</b>\n          </td>\n          <td>\n            <b>System</b>\n          </td>\n          <td>\n            <b>Display</b>\n          </td>\n          <td>\n            <b>Definition</b>\n          </td>\n        </tr>\n        <tr>\n          <td style=\"white-space:nowrap\">\n            <a name=\"http---terminology.hl7.org-CodeSystem-v2-0136-Y\"> </a>\n            <a href=\"v2/0136/index.html#v2-0136-Y\">Y</a>\n          </td>\n          <td>http://terminology.hl7.org/CodeSystem/v2-0136</td>\n          <td>Yes</td>\n          <td/>\n        </tr>\n        <tr>\n          <td style=\"white-space:nowrap\">\n            <a name=\"http---terminology.hl7.org-CodeSystem-v2-0136-N\"> </a>\n            <a href=\"v2/0136/index.html#v2-0136-N\">N</a>\n          </td>\n          <td>http://terminology.hl7.org/CodeSystem/v2-0136</td>\n          <td>No</td>\n          <td/>\n        </tr>\n        <tr>\n          <td style=\"white-space:nowrap\">\n            <a name=\"http---terminology.hl7.org-CodeSystem-data-absent-reason-asked-unknown\"> </a>\n            <a href=\"codesystem-data-absent-reason.html#data-absent-reason-asked-unknown\">asked-unknown</a>\n          </td>\n          <td>http://terminology.hl7.org/CodeSystem/data-absent-reason</td>\n          <td>Don't know</td>\n          <td>The source was asked but does not know the value.</td>\n        </tr>\n      </table>\n    </div>"
  },
  "url": "http://hl7.org/fhir/ValueSet/yesnodontknow",
  "version": "4.0.1",
  "name": "Yes/No/Don't Know",
  "status": "draft",
  "description": "For Capturing simple yes-no-don't know answers",
  "compose": {
    "include": [
      {
        "valueSet": [
          "http://terminology.hl7.org/ValueSet/v2-0136"
        ]
      },
      {
        "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason",
        "concept": [
          {
            "code": "asked-unknown",
            "display": "Don't know"
          }
        ]
      }
    ]
  },
  "expansion": {
    "identifier": "urn:uuid:bf99fe50-2c2b-41ad-bd63-bee6919810b4",
    "timestamp": "2015-07-14T10:00:00Z",
    "contains": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/v2-0136",
        "code": "Y",
        "display": "Yes"
      },
      {
        "system": "http://terminology.hl7.org/CodeSystem/v2-0136",
        "code": "N",
        "display": "No"
      },
      {
        "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason",
        "code": "asked-unknown",
        "display": "Don't know"
      }
    ]
  }
}
''';
}
