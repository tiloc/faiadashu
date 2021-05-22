import 'dart:convert';

import 'package:fhir/primitive_types/primitive_types.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';

Future uploadToServer(Resource resource) async {
  final client = SmartClient(
    fhirUrl: FhirUri('https://api.logicahealth.org/faiadashu/data'),
    clientId: '9f03822a-e4ca-4ea6-aaa3-107661bd86a4',
    redirectUri: FhirUri('com.example.example://callback'),
    scopes: Scopes(
      clinicalScopes: [
        ClinicalScope(
          Role.patient,
          R4ResourceType.QuestionnaireResponse,
          Interaction.any,
        ),
      ],
      openid: true,
      offlineAccess: true,
    ),
  );

  print(client.isLoggedIn);

  try {
    await client.login();
  } catch (e) {
    print(e);
  }

  print(client.isLoggedIn);

  print(
      '${resource.resourceTypeString()} to be uploaded:\n${resource.toJson()}');
  final request1 = FhirRequest.create(
    base: client.fhirUrl.value!,
    resource: resource,
  );

  Id? newId;
  try {
    final response1 = await request1.request(headers: await client.authHeaders);
    print('Response from upload:\n${response1?.toJson()}');
    newId = response1?.id;
  } catch (e) {
    print(e);
  }
  if (newId is! Id) {
    print(newId);
  } else {
    final request2 = FhirRequest.read(
      base: client.fhirUrl.value!,
      type: resource.resourceType!,
      id: newId,
    );
    try {
      final response2 =
          await request2.request(headers: await client.authHeaders);
      print('Response from read:\n${response2?.toJson()}');
    } catch (e) {
      print(e);
    }
  }

  print(client.isLoggedIn);
}
