// import 'package:auth_mobile2/view/tabBar_login.dart';
import 'package:tugas_pmobile2/view/widget/button_widget.dart';
import 'package:tugas_pmobile2/view/widget/container_form.dart';
import 'package:tugas_pmobile2/view/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nowhatsappController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                height: h * 2 - 500,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 255, 194, 214),
                  Color.fromARGB(255, 255, 194, 214),
                  Color.fromARGB(255, 255, 194, 214),
                ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 50,
                    // ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Daftar Akun User",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Silahkan Isi Form dibawah ini",
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                                // height: 10,
                                ),
                            Container(
                              // height: h - 100,
                              padding: const EdgeInsets.all(10),
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
                                    // fieldKey: _formKey,
                                    controller: _namaController,
                                    hintText: 'Nama',
                                    isPasswordField: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  FormWidgetContainer(
                                    // fieldKey: _formKey,
                                    controller: _nimController,
                                    hintText: 'NIM',
                                    isPasswordField: false,
                                    inputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'NIM Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  FormWidgetContainer(
                                    // fieldKey: _formKey,
                                    controller: _nowhatsappController,
                                    hintText: 'No WhatsApp',
                                    isPasswordField: false,
                                    inputType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'No WhatsApp Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  FormWidgetContainer(
                                    // fieldKey: _formKey,
                                    controller: _emailController,
                                    hintText: 'Email',
                                    isPasswordField: false,
                                    inputType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  FormWidgetContainer(
                                    // fieldKey: _formKey,
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    isPasswordField: true,
                                    inputType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password Tidak Boleh Kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  FormWidgetContainer(
                                    // fieldKey: _formKey,
                                    controller: _confirmPasswordController,
                                    hintText: 'Ulangi Password',
                                    isPasswordField: true,
                                    inputType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Silahkan Ulangi Password';
                                      } else if (value !=
                                          _passwordController.text) {
                                        return 'Passwords Tidak Sama';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                height: 50,
                                width: 150,
                                child: CustomButton(
                                    text: 'Daftar',
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        _register();
                                      }
                                    })),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _confirmPasswordController.text,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nama': _namaController.text,
        'nim': _nimController.text,
        'nowa': _nowhatsappController.text,
        'email': _emailController.text,
      });
      // showCustomDialog(
      //   context,
      //   color: Colors.green,
      //   icon: Icons.verified,
      //   title: 'Daftar Berhasil',
      //   content: 'Registrasi berhasil. Anda akan diarahkan ke halaman login.',
      // );
    } catch (e) {
      // Tampilkan dialog gagal jika pendaftaran gagal
      showCustomDialog(
        context,
        icon: Icons.error,
        color: Colors.red,
        title: 'Daftar Gagal',
        content: '$e',
      );
    }
  }
}