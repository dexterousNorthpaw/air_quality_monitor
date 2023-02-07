import 'package:air_quality_monitor/screens/home_screen.dart';
import 'package:air_quality_monitor/services/firebase_auth.dart';
import 'package:air_quality_monitor/shared/custom_button.dart';
import 'package:air_quality_monitor/shared/login_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/popup_dialog.dart';

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
  late final SharedPreferences _preferences;

  togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  login({required String email, required String password}) async {
    final data =
        await FirebaseAuthServices.login(email: email, password: password);

    if (data['status']) {
      await _preferences.setString('email', email);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) {
            return false;
          },
        );
      }
    } else {
      showPopUpDialog(
        context: context,
        content: data['error'],
        cancelText: "Close",
      );
    }
  }

  initializeData() async {
    _preferences = await SharedPreferences.getInstance();
    String? email = _preferences.getString('email');
    if (email == null) return;
    _emailController.text = email;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          showPassword = false;
        });
        FocusScope.of(context).unfocus();
        await SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: Text(
            'Air Quality Monitor',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Color(0xff834eed),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                          ),
                          const SizedBox(height: 20),
                          LoginFields(
                            fieldName: 'Password',
                            hintText: 'Enter your password',
                            textEditingController: _passwordController,
                            obscureText: !showPassword,
                            onPressed: togglePasswordVisibility,
                          ),
                          const SizedBox(height: 60),
                          CustomButton(
                            buttonText: 'Login',
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              await SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              if (_formKey.currentState!.validate()) {
                                await login(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
