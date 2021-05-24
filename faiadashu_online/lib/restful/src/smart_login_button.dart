import 'package:fhir_auth/r4/smart_client/smart_client.dart';
import 'package:flutter/material.dart';

// TODO: Smoother animations, progress indicators, etc.

/// A login/logout button that is tied to the state of a [SmartClient].
class SmartLoginButton extends StatefulWidget {
  final SmartClient smartClient;

  const SmartLoginButton(this.smartClient, {Key? key}) : super(key: key);

  @override
  _SmartLoginButtonState createState() => _SmartLoginButtonState();
}

enum LoginStatus { loggedOut, loggedIn, loggingOut, loggingIn, error, unknown }

class _SmartLoginButtonState extends State<SmartLoginButton> {
  LoginStatus _loginStatus = LoginStatus.unknown;

  @override
  void initState() {
    super.initState();
    _loginStatus = (widget.smartClient.isLoggedIn)
        ? LoginStatus.loggedIn
        : LoginStatus.loggedOut;
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.loggedIn:
        return IconButton(
            onPressed: () async {
              setState(() {
                _loginStatus = LoginStatus.loggingOut;
              });
              await widget.smartClient.logout();
              setState(() {
                _loginStatus = LoginStatus.loggedOut;
              });
            },
            icon: const Icon(Icons.logout));
      case LoginStatus.loggedOut:
      case LoginStatus.error:
        return IconButton(
            onPressed: () async {
              setState(() {
                _loginStatus = LoginStatus.loggingIn;
              });
              try {
                await widget.smartClient.login();
                setState(() {
                  _loginStatus = LoginStatus.loggedIn;
                });
              } catch (e) {
                setState(() {
                  _loginStatus = LoginStatus.error;
                });
              }
            },
            icon: (_loginStatus == LoginStatus.loggedOut)
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
