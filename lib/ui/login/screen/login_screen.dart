import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/resources/AppConstants.dart';
import 'package:evently/core/resources/RoutesManager.dart';
import 'package:evently/core/reusable_components/CustomButton.dart';
import 'package:evently/ui/login/screen/Google_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GoogleAuthService _googleAuth = GoogleAuthService();
  String selectedLanguage = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AssetsManager.logo),
                SizedBox(height: 24),
                CustomField(
                  hint: "email".tr(),
                  prefix: AssetsManager.email,
                  controller: emailController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email shouldn't be empty";
                    }
                    var regex = RegExp(emailRegex);
                    if (!regex.hasMatch(value)) {
                      return "Email isn't valid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomField(
                  controller: passwordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password shouldn't be empty";
                    }
                    if (value.length < 8) {
                      return "Password shouldn't be less than 8";
                    }
                    return null;
                  },
                  hint: "pass".tr(),
                  prefix: AssetsManager.lock,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "forgotPass".tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomButton(
                  title: "login".tr(),
                  onPress: () {
                    if (formKey.currentState?.validate() ?? false) {
                      signin();
                    }
                  },
                ),

                /////////////////
                /*SizedBox(height: 24),

                CustomButton(
                  title: "Sign in with Google".tr(),
                  onPress: () async {
                    final userCredential = await _googleAuth.signInWithGoogle();
                    if (userCredential != null) {
                      print("Signed in: ${userCredential.user?.displayName}");
                    } else {
                      print("Sign in cancelled or failed");
                    }
                  },
                ),*/
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "dontHaveAccount".tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesManager.register);
                      },
                      child: Text(
                        "createAcc".tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ////////
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final userCredential =
                          await _googleAuth.signInWithGoogle();
                      if (userCredential != null) {
                        print("Signed in: ${userCredential.user?.displayName}");
                      } else {
                        print("Sign in cancelled or failed");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.infinity, 56),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset(
                          AssetsManager.google,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomSwitch(
                  selected: selectedLanguage,
                  icon2: AssetsManager.eg,
                  icon1: AssetsManager.us,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                    if (selectedLanguage == "ar") {
                      context.setLocale(Locale("ar"));
                    } else {
                      context.setLocale(Locale("en"));
                    }
                  },
                  values: ["en", "ar"],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
