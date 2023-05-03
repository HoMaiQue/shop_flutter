import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const routerName = "/auth";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      final email = _emailController.text;
      final password = _passwordController.text;
      if (email.isNotEmpty && password.isNotEmpty) {
        Provider.of<AuthProvider>(context, listen: false).login(email, password);
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _BuildEmailField(),
              _BuildPasswordField(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.orange)),
                        onPressed: handleSubmit,
                        child: const Text("Submit"))),
              )
            ],
          ),
        ));
  }

  Widget _BuildEmailField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.phone,
              color: Colors.orange,
            ),
            hintText: "Email",
            labelText: "Email",
            labelStyle: TextStyle(color: Colors.orange)),
      ),
    );
  }

  Widget _BuildPasswordField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.orange,
            ),
            hintText: "Password",
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.orange)),
      ),
    );
  }
}
