// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_auth_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 388,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/clock.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: TextFormField(
                                controller: emailLoginController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter your email first"
                                      : null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email Address",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: passwordLoginController,
                                obscureText: true,
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter your password first"
                                      : null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          if (loginFormKey.currentState!.validate()) {
                            loginFormKey.currentState!.save();
                            User? user = await FireBaseAuthHelper
                                .fireBaseAuthHelper
                                .loginUser(email: email!, password: password!);
                            // ignore: duplicate_ignore
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Login Successful\nID: ${user.uid}"),
                                  backgroundColor: const Color(0xff777be7),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pushReplacementNamed(
                                  'homepage',
                                  arguments: user);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login Failed"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            email = "";
                            password = "";
                            emailLoginController.clear();
                            passwordLoginController.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff858bf3),
                                Colors.blueAccent.shade200,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () async {
                          User? user = await FireBaseAuthHelper
                              .fireBaseAuthHelper
                              .signWithGoogle();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Login Successful\nID: ${user.uid}"),
                                backgroundColor: const Color(0xff777be7),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                                'homepage',
                                arguments: user);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/g1.png",
                                scale: 30,
                              ),
                            ),
                            const Text(
                              "Signing with google",
                              style: TextStyle(
                                color: Color(0xff777be7),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have any account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: register,
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff777be7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          User? user = await FireBaseAuthHelper
                              .fireBaseAuthHelper
                              .singInAnonymous();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Login Successful\nID: ${user.uid}"),
                                backgroundColor: const Color(0xff777be7),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                                'homepage',
                                arguments: user);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Guest User",
                          style: TextStyle(
                            color: Color(0xff777be7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  register() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Register"),
          content: Form(
            key: registerFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    return (val!.isEmpty) ? "Enter your email first" : null;
                  },
                  onSaved: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (val) {
                    return (val!.isEmpty) ? "Enter your password first" : null;
                  },
                  onSaved: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (registerFormKey.currentState!.validate()) {
                  registerFormKey.currentState!.save();
                  User? user = await FireBaseAuthHelper.fireBaseAuthHelper
                      .registerUser(email: email!, password: password!);
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Register Successful\nID: ${user.uid}"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Register Failed"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  email = "";
                  password = "";
                  emailController.clear();
                  passwordController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Register"),
            ),
            OutlinedButton(
              onPressed: () {
                email = "";
                password = "";
                emailController.clear();
                passwordController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
