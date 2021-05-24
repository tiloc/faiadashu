import 'package:fhir_auth/r4/smart_client/smart_client.dart';
import 'package:flutter/material.dart';

// TODO: Smoother animations, progress indicators, etc.
// TODO: Should this entire widget be stateless and only use a ValueNotifier?

/// A login/logout button that is tied to the state of a [SmartClient].
class SmartLoginButton extends StatefulWidget {
  final SmartClient smartClient;
  final VoidCallback? onLoginChanged;

  const SmartLoginButton(this.smartClient, {this.onLoginChanged, Key? key})
      : super(key: key);

  @override
  _SmartLoginButtonState createState() => _SmartLoginButtonState();
}

enum LoginStatus { loggedOut, loggedIn, loggingOut, loggingIn, error, unknown }

class _SmartLoginButtonState extends State<SmartLoginButton> {
  final ValueNotifier<LoginStatus> _loginStatus =
      ValueNotifier(LoginStatus.unknown);

  @override
  void initState() {
    super.initState();
    _loginStatus.value = (widget.smartClient.isLoggedIn)
        ? LoginStatus.loggedIn
        : LoginStatus.loggedOut;

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

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus.value) {
      case LoginStatus.loggedIn:
        return IconButton(
            onPressed: () async {
              setState(() {
                _loginStatus.value = LoginStatus.loggingOut;
              });
              await widget.smartClient.logout();
              setState(() {
                _loginStatus.value = LoginStatus.loggedOut;
              });
            },
            icon: const Icon(Icons.logout));
      case LoginStatus.loggedOut:
      case LoginStatus.error:
        return IconButton(
            onPressed: () async {
              setState(() {
                _loginStatus.value = LoginStatus.loggingIn;
              });
              try {
                await widget.smartClient.login();
                setState(() {
                  _loginStatus.value = LoginStatus.loggedIn;
                });
              } catch (e) {
                setState(() {
                  _loginStatus.value = LoginStatus.error;
                });
              }
            },
            icon: (_loginStatus.value == LoginStatus.loggedOut)
                ? const Icon(Icons.login)
                : const Icon(Icons.error));
      case LoginStatus.loggingIn:
      case LoginStatus.loggingOut:
        return const Icon(Icons.sync);
      case LoginStatus.unknown:
        return const Icon(Icons.device_unknown);
    }
  }
}
