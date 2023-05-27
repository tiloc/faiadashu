import 'dart:async';

import 'package:faiadashu/logging/logging.dart' as fdashlog;
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class SmartFhirClient {
  Future<void> logout() async {}

  int isLoggedIn() => 0;
}

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
  }) : smartClient = SmartFhirClient();

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
    return null;
  }

  void dispose() {
    try {
      unawaited(smartClient.logout());
    } catch (e) {
      _logger.warn('Could not log out', error: e);
    }
  }
}
