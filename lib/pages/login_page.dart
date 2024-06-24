import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:project_ics321/widgets/loginPageWidgets/login_register_list.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context, listen: false);
    Future.delayed(Duration(seconds: 5)).then((value) {
      data.getNumberOfUsersForIdReg();
      data.getTournamentInit();
      data.getTeamsInit();
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 1000,
        width: 1000,
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60),
              height: 100,
              child: Text(
                "KFUPM Tournament App",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            LoginRegisterList()
          ],
        ),
      ),
    );
  }
}
