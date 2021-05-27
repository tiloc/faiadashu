import 'dart:math';

import 'package:fhir_auth/r4/smart_client/smart_client.dart';
import 'package:flutter/material.dart';

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

class _SmartLoginButtonState extends State<SmartLoginButton>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<LoginStatus> _loginStatus =
      ValueNotifier(LoginStatus.unknown);

  final _loggedInKey = UniqueKey();
  final _loggedOutKey = UniqueKey();
  final _ingKey = UniqueKey();

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _loginStatus.value = (widget.smartClient.isLoggedIn)
        ? LoginStatus.loggedIn
        : LoginStatus.loggedOut;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

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
    String message = "Not sure what's going on?";
    switch (_loginStatus.value) {
      case LoginStatus.loggingIn:
        message = 'Signing in…';
        break;
      case LoginStatus.loggedIn:
        message = 'Signed in…';
        break;
      case LoginStatus.loggedOut:
        message = 'Signed out…';
        break;
      case LoginStatus.loggingOut:
        message = 'Signing out…';
        break;
      case LoginStatus.error:
        message = 'Something went wrong.';
        break;
      case LoginStatus.unknown:
        break;
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
      ));
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
              await widget.smartClient.logout();
              setState(() {
                _loginStatus.value = LoginStatus.loggedOut;
              });
              _showStatusSnackBar(context);
            },
            icon: const Icon(Icons.logout));
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
                await widget.smartClient.login();
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
                : const Icon(Icons.error));
        break;
      case LoginStatus.loggingIn:
      case LoginStatus.loggingOut:
        child = AnimatedBuilder(
            key: _ingKey,
            animation: _animationController,
            builder: (BuildContext context, Widget? _widget) {
              return Transform.rotate(
                angle: _animationController.value * 2 * pi,
                child: _widget,
              );
            },
            child: const Icon(Icons.sync));
        break;
      case LoginStatus.unknown:
        child = const Icon(Icons.device_unknown);
    }

    return SizedBox(
      width: 40,
      height: 32,
      child: Center(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000), child: child),
      ),
    );
  }
}
