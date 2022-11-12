// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_auth_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? data = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xff858bf3),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FireBaseAuthHelper.fireBaseAuthHelper.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
          (data!.photoURL != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage("${data.photoURL}"),
                  radius: 20,
                )
              : const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 60),
            (data.photoURL != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage("${data.photoURL}"),
                    radius: 60,
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
            const SizedBox(height: 10),
            (data.displayName != null)
                ? Text("Name:${data.displayName}")
                : const Text("------"),
            const Divider(),
            (data.email != null)
                ? Text("Email:${data.email}")
                : const Text("------"),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            (data.photoURL != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage("${data.photoURL}"),
                    radius: 60,
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
            const SizedBox(height: 10),
            (data.displayName != null)
                ? Text("Name:${data.displayName}")
                : const Text("------"),
            const SizedBox(height: 10),
            (data.email != null)
                ? Text("Email:${data.email}")
                : const Text("------"),
          ],
        ),
      ),
    );
  }
}
