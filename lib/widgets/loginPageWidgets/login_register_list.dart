import 'package:flutter/material.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

class LoginRegisterList extends StatefulWidget {
  bool login = true;
  bool isLoading = false;

  @override
  State<LoginRegisterList> createState() => _LoginRegisterListState();
}

class _LoginRegisterListState extends State<LoginRegisterList> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void didUpdateWidget(covariant LoginRegisterList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void Proceed() {
    if (widget.login) {}
  }

  @override
  Widget build(BuildContext context) {
    var dataState = Provider.of<GeneralProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      width: 320,
      height: 500,
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.black45)),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                        labelText: "Email"),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if (!widget.login)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "User Name",
                    hintText: "Enter your user name",
                  ),
                )),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.black45)),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your password",
                    labelText: "Password"),
              )),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 10))),
              onPressed: () async {
                if (widget.login) {
                  String type = await dataState.login(
                      emailController.text.trim(), passwordController.text);

                  if (type == 'Admin') {
                    Navigator.of(context).pushReplacementNamed("/admin");
                  } else if (type == 'Guest') {
                    dataState.login(
                        emailController.text, passwordController.text);
                    Navigator.of(context).pushReplacementNamed('/guest');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                      child: Text(
                        "User does not exist!",
                        style: TextStyle(fontSize: 15),
                      ),
                    )));
                  }
                } else if (!widget.login) {
                  dataState
                      .register(passwordController.text, emailController.text,
                          userIdController.text)
                      .then((value) {
                    Navigator.of(context).pushReplacementNamed('/guest');
                  });
                }
              },
              child: widget.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      widget.login ? "Login" : "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
          TextButton(
              onPressed: () {
                widget.login = !widget.login;

                setState(() {});
              },
              child: Text(
                !widget.login ? "Already a User?" : "New User?",
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }
}
