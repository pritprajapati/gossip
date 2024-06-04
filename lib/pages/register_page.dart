import 'package:flutter/material.dart';
import 'package:gossip/services/auth/auth_service.dart';
import 'package:gossip/components/my_button.dart';
import 'package:gossip/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  void register(BuildContext context) {
    final auth = AuthService();

    if (_pwdController.text == _confirmPwdController.text) {
      try {
        auth.signUpWithEmailPassword(
            _emailController.text, _pwdController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords dont match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 65,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            Text(
              "Let's create an account for you!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwdController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPwdController,
            ),
            const SizedBox(height: 25),
            MyButton(
              btnText: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
