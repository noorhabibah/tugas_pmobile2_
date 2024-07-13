import 'package:tugas_pmobile2/view/home.dart';
import 'package:tugas_pmobile2/view/widget/button_widget.dart';
import 'package:tugas_pmobile2/view/widget/container_form.dart';
import 'package:tugas_pmobile2/view/widget/show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });
  @override
  State<Login> createState() => _LoginScreen();
}

class _LoginScreen extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color.fromARGB(255, 255, 194, 214),
                    Color.fromARGB(255, 255, 194, 214),
                    Color.fromARGB(255, 255, 194, 214),
                  ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Silahkan Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Colors.pink,
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    FormWidgetContainer(
                                      controller: emailController,
                                      hintText: 'Email',
                                      isPasswordField: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email Tidak Boleh Kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                    FormWidgetContainer(
                                      controller: passwordController,
                                      hintText: 'Password',
                                      isPasswordField: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password Tidak Boleh Kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Lupa Password ?',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.grey.shade700,
                                      fontSize: 18,
                                    ),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: CustomButton(
                                      text: 'Login',
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          _login();
                                        }
                                      })),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(user: userCredential.user!)),
      );
    } catch (e) {
      showCustomDialog(context,
          icon: Icons.error,
          color: Colors.red,
          title: 'Login Gagal',
          content: 'Pastikan Email dan Password Benar');
    }
  }
}