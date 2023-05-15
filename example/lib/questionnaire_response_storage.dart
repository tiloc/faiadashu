import 'dart:async';

import 'package:faiadashu/logging/logging.dart' as fdashlog;
import 'package:faiadashu_online/restful/restful.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_auth/fhir_client/smart_fhir_client.dart';
import 'package:fhir_auth/scopes/r4/clinical_scope.dart';
import 'package:fhir_auth/scopes/r4/scopes.dart';
import 'package:flutter/material.dart';

/// A very simplistic implementation of persistence in-memory and on a server.
/// In-Memory contents will disappear when the app is stopped.
///
/// Not production-ready!
class QuestionnaireResponseStorage {
  static final _logger = fdashlog.Logger(QuestionnaireResponseStorage);

  final FhirUri fhirUri;
  final String clientId;
  final FhirUri redirectUri;

  final SmartFhirClient smartClient;

  QuestionnaireResponseStorage({
    required this.fhirUri,
    required this.clientId,
    required this.redirectUri,
  }) : smartClient = SmartFhirClient(
          fhirUri: fhirUri,
          clientId: clientId,
          redirectUri: redirectUri,
          scopes: Scopes(
            clinicalScopes: [
              ClinicalScope(
                role: Role.patient,
                interaction: Interaction.any,
                resourceType: R4ResourceType.Patient,
              ),
              ClinicalScope(
                role: Role.patient,
                resourceType: R4ResourceType.QuestionnaireResponse,
                interaction: Interaction.any,
              ),
            ],
            openid: true,
            offlineAccess: true,
          ).scopesList(),
        );

  final Map<String, QuestionnaireResponse?> _savedResponses = {};

  // Save QuestionnaireResponse to in-memory storage
  void saveToMemory(String questionnairePath, QuestionnaireResponse? response) {
    if (response == null) {
      return;
    }

    _savedResponses[questionnairePath] = response;
  }

  // Restore QuestionnaireResponses from in-memory storage
  QuestionnaireResponse? restoreFromMemory(String questionnairePath) {
    if (_savedResponses.containsKey(questionnairePath)) {
      return _savedResponses[questionnairePath];
    } else {
      return null;
    }
  }

  // Upload of QuestionnaireResponse to server (plus saves in-memory).
  Future<QuestionnaireResponse?> uploadToServer(
    BuildContext context,
    String questionnairePath,
    QuestionnaireResponse? questionnaireResponse,
  ) async {
    if (questionnaireResponse == null) {
      return null;
    }
    try {
      // Upload will also save locally.
      final updatedQuestionnaireResponse =
          await createOrUpdateQuestionnaireResponse(
        smartClient,
        questionnaireResponse,
      );
      _savedResponses[questionnairePath] = updatedQuestionnaireResponse;

      return updatedQuestionnaireResponse;
    } catch (e) {
      // Upload failed, but we are saving the QR locally
      _savedResponses[questionnairePath] = questionnaireResponse;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Upload failed'),
          content: Text(e.toString()),
          scrollable: true,
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return questionnaireResponse;
    }
  }

  void dispose() {
    try {
      unawaited(smartClient.logout());
    } catch (e) {
      _logger.warn('Could not log out', error: e);
    }
  }
}
