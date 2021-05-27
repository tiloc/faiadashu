# *Faiadashu Online*

This package is an optional add-on to [*Faiadashu*](../README.md) and contains UI elements and other add-ons to
facilitate communication with servers that implement the FHIR® standard.

> FHIR® is the registered trademark of HL7 and is used with the permission of HL7. Use of the FHIR trademark does not constitute endorsement of this product by HL7.

## Features
* Login / Logout button
* A `ResourceProvider` implementation that fetches resources from a FHIR server

### Platform support
This package is relying on native packages which are not available on all platforms where Flutter is available.

Full functionality is currently only supported on Android and iOS.

## Setup
The authentication functionality requires extensive configuration of both the secured FHIR server 
and the native portions of your Flutter app.

See: https://pub.dev/packages/flutter_appauth

## Contributions
Contributions and discussions are welcome! This is currently not well-defined yet. I am posting an invite link to the awesome FHIR-FLI
Slack channel which is run by some like-minded folks and where I can be frequently found:


[![FHIR-FLI Slack Channel](../doc/images/Slack_RGB-98x40-335cb2d.png)](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)  
[Join the FHIR-FLI Slack channel!](https://join.slack.com/t/fhir-fli/shared_invite/zt-ofv2cycm-9yjdMj8a~zXp7nDBeB_sNQ)

> The honor of being Contributor #1 goes to [Grey Faulkenberry](https://github.com/Dokotela), who co-founded the Slack channel.

### License
The library is licensed under the MIT license. The full license text is here [LICENSE](LICENSE).
