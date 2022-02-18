// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, deprecated_member_use

import 'package:autenticacao/details.page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await _localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
      localizedReason: "Use a biometria para prosseguir",
      useErrorDialogs: true,
      stickyAuth: true,
    );

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autentique-se"),
      ),
      body: const Center(
        child: Text("Use a digital para prosseguir"),
      ),
    );
  }
}
