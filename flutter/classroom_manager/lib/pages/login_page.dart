import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../services/locator.dart';
import '../static/texts.dart';
import 'home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Auth _auth = locator<Auth>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: container(),
    );
  }

  Container container() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.cyan.shade900,
        Colors.cyan.shade500,
        Colors.cyan.shade400,
      ])),
      child: column(),
    );
  }

  Column column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loginText(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        form(),
      ],
    );
  }

  Expanded form() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                // #email, #password
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Color.fromRGBO(171, 171, 171, .7), blurRadius: 20, offset: Offset(0, 10)),
                    ],
                  ),
                  child: Column(
                    children: [
                      username(),
                      password(),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // #login
                loginButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell loginButton() {
    return InkWell(
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color.fromARGB(255, 84, 163, 187)),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: login);
  }

  Container password() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: _password,
        decoration: const InputDecoration(hintText: "Password", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
      ),
    );
  }

  Container username() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: _email,
        decoration: const InputDecoration(hintText: "Email", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
      ),
    );
  }

  Center loginText() {
    return const Center(
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }

  void login() async {
    var response = await _auth.login(_email.text, _password.text);
    if (response ) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    } else {
      const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        content: Text(Texts.login_error),
        backgroundColor: (Colors.black54),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
