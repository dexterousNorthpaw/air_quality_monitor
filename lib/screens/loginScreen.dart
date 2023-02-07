import 'package:air_quality_monitor/shared/custom_button.dart';
import 'package:air_quality_monitor/shared/login_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey();
  final _passwordKey = GlobalKey();

  togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          'Air Quality Monitor',
          style: TextStyle(
            color: Color(0xff834eed),
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 25, 20, 40),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            height: constraint.maxHeight - 65,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      LoginFields(
                        fieldName: 'Email',
                        textEditingController: _emailController,
                        hintText: 'Enter your email',
                        key: _emailKey,
                        onTapTextField: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          Scrollable.ensureVisible(_emailKey.currentContext!);
                        },
                      ),
                      const SizedBox(height: 20),
                      LoginFields(
                        fieldName: 'Password',
                        hintText: 'Enter your password',
                        textEditingController: _passwordController,
                        obscureText: !showPassword,
                        onPressed: togglePasswordVisibility,
                        key: _passwordKey,
                        onTapTextField: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          Scrollable.ensureVisible(
                              _passwordKey.currentContext!);
                        },
                      ),
                      const SizedBox(height: 60),
                      CustomButton(buttonText: 'Login', onTap: () {}),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
