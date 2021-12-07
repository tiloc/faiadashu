import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:fhir_auth/fhir_client/fhir_client.dart';
import 'package:flutter/material.dart';

/// A login/logout button that is tied to the state of a [FhirClient].
class SmartLoginButton extends StatefulWidget {
  final FhirClient client;
  final VoidCallback? onLoginChanged;

  const SmartLoginButton(this.client, {this.onLoginChanged, Key? key})
      : super(key: key);

  @override
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
// FIXME: property currently doesn't exist.
    _loginStatus.value = LoginStatus.loggedIn;
/*    _loginStatus.value = (widget.client.isLoggedIn)
        ? LoginStatus.loggedIn
        : LoginStatus.loggedOut; */

    if (widget.onLoginChanged != null) {
      _loginStatus.addListener(widget.onLoginChanged!);
    }
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

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1500),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;

    switch (_loginStatus.value) {
      case LoginStatus.loggedIn:
        child = IconButton(
          key: _loggedInKey,
          onPressed: () async {
            setState(() {
              _loginStatus.value = LoginStatus.loggingOut;
            });
            _showStatusSnackBar(context);
            await widget.client.logout();
            if (!mounted) {
              return;
            }
            setState(() {
              _loginStatus.value = LoginStatus.loggedOut;
            });
            _showStatusSnackBar(context);
          },
          icon: const Icon(Icons.logout),
        );
        break;
      case LoginStatus.loggedOut:
      case LoginStatus.error:
        child = IconButton(
          key: _loggedOutKey,
          onPressed: () async {
            setState(() {
              _loginStatus.value = LoginStatus.loggingIn;
            });
            _showStatusSnackBar(context);
            try {
              await widget.client.login();
              if (!mounted) {
                return;
              }
              setState(() {
                _loginStatus.value = LoginStatus.loggedIn;
              });
              _showStatusSnackBar(context);
            } catch (e) {
              setState(() {
                _loginStatus.value = LoginStatus.error;
                _showStatusSnackBar(context);
              });
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
  }
}
