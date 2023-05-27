import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:fhir_auth/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A login/logout button for a [FhirClient].
class SmartLoginButton extends StatefulWidget {
  final SmartFhirClient client;
  final VoidCallback? onLoginChanged;

  const SmartLoginButton(this.client, {this.onLoginChanged, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SmartLoginButtonState createState() => _SmartLoginButtonState();
}

enum LoginStatus { loggedOut, loggedIn, loggingOut, loggingIn, error, unknown }

class _SmartLoginButtonState extends State<SmartLoginButton> {
  final ValueNotifier<LoginStatus> _loginStatus =
      ValueNotifier(LoginStatus.unknown);

  final _loggedInKey = UniqueKey();
  final _loggedOutKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _loginStatus.value = LoginStatus.unknown;

    if (widget.onLoginChanged != null) {
      // TODO: Make listener receive the value.
      _loginStatus.addListener(widget.onLoginChanged!);
    }

    // Discover the current login status after button is first drawn.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        _loginStatus.value = await widget.client.isLoggedIn()
            ? LoginStatus.loggedIn
            : LoginStatus.loggedOut;
      } catch (ex) {
        _loginStatus.value = LoginStatus.error;
      }
    });
  }

  @override
  void dispose() {
    if (widget.onLoginChanged != null) {
      _loginStatus.removeListener(widget.onLoginChanged!);
    }
    super.dispose();
  }

  void _showStatusSnackBar(BuildContext context) {
    String message = FDashLocalizations.of(context).loginStatusUnknown;
    switch (_loginStatus.value) {
      case LoginStatus.loggingIn:
        message = FDashLocalizations.of(context).loginStatusLoggingIn;
        break;
      case LoginStatus.loggedIn:
        message = FDashLocalizations.of(context).loginStatusLoggedIn;
        break;
      case LoginStatus.loggedOut:
        message = FDashLocalizations.of(context).loginStatusLoggedOut;
        break;
      case LoginStatus.loggingOut:
        message = FDashLocalizations.of(context).loginStatusLoggingOut;
        break;
      case LoginStatus.error:
        message = FDashLocalizations.of(context).loginStatusError;
        break;
      case LoginStatus.unknown:
        break;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(milliseconds: 1500),
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LoginStatus>(
      valueListenable: _loginStatus,
      builder: (context, loginStatus, independentChild) {
        _showStatusSnackBar(context);

        Widget? child;

        switch (loginStatus) {
          case LoginStatus.loggedIn:
            child = IconButton(
              key: _loggedInKey,
              onPressed: () async {
                _loginStatus.value = LoginStatus.loggingOut;
                await widget.client.logout();

                _loginStatus.value = LoginStatus.loggedOut;
              },
              icon: const Icon(Icons.logout),
            );
            break;
          case LoginStatus.loggedOut:
          case LoginStatus.error:
            child = IconButton(
              key: _loggedOutKey,
              onPressed: () async {
                _loginStatus.value = LoginStatus.loggingIn;
                try {
                  await widget.client.login();
                  _loginStatus.value = LoginStatus.loggedIn;
                } catch (e) {
                  _loginStatus.value = LoginStatus.error;
                }
              },
              icon: (_loginStatus.value == LoginStatus.loggedOut)
                  ? const Icon(Icons.login)
                  : const Icon(Icons.error),
            );
            break;
          case LoginStatus.loggingIn:
          case LoginStatus.loggingOut:
            child = const SyncIndicator();
            break;
          case LoginStatus.unknown:
            child = const Icon(Icons.device_unknown);
        }

        return SizedBox(
          width: 40,
          height: 32,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
