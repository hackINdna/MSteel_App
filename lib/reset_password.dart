import 'package:flutter/material.dart';
import 'package:m_steel/login.dart';
import 'package:m_steel/widgets/gradient_container.dart';
import 'package:m_steel/widgets/password_textformfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const routeName = "/resetPassword";
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  bool _isValid = false;

  void _submit() {
    _isValid = _formKey.currentState?.validate() ?? false;
    //change password
    if (!_isValid) {
      return;
    }
    _passwordController.clear();
    _confirmPasswordController.clear();
    showDialog(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: AlertDialog(
          title: const Text("Password changed Successfully!"),
          content: const Text(
              "Your password has been changed successfully, please log in to access your account."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false),
              child: const Text("Log in"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBgContainer(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(22.2),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 42,
                      bottom: 12,
                    ),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "Set new password for your MSteel Account.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "New Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PasswordTextFormField(
                    hintText: "Enter New Password",
                    darkBg: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password length should be 6 or more.";
                      }
                      return null;
                    },
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    hintText: "Confirm New Password",
                    darkBg: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password length should be 6 or more.";
                      }
                      if (value != _passwordController.text) {
                        return "Password does not match.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _submit(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff005C77),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 47)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14),
                      ),
                    ),
                    child: const Text("Verify"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
