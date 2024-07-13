import 'package:tugas_pmobile2/view/tabBar_login.dart';
import 'package:tugas_pmobile2/view/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Color.fromARGB(255, 255, 194, 214),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('GAGAL MENDAPATKAN DATA USER'));
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: w - 60,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 168, 214),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Selamat Anda Berhasil Login',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: w - 100,
                  // height: h / 2,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.pink,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          'Nama: ${userData['nama']}',
                          style: TextStyle(
                              fontSize: 25, color: Colors.grey.shade700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'NIM: ${userData['nim']}',
                          style: TextStyle(
                              fontSize: 25, color: Colors.grey.shade700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'No WhatsApp: ${userData['nowa']}',
                          style: TextStyle(
                              fontSize: 25, color: Colors.grey.shade700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email: ${userData['email']}',
                          style: TextStyle(
                              fontSize: 25, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 150,
                child: CustomButton(
                  text: 'Logout',
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TabBarLogin()),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}