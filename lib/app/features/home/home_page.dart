import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skincareapp/app/features/home/pages/care_page.dart';
import 'package:skincareapp/app/features/home/pages/my_account_page.dart';
import 'package:skincareapp/app/features/home/pages/spf/spf_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

var currentIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const CarePage();
        }
        if (currentIndex == 1) {
          return const SpfPage();
        }
        return MyAccountPage(email: widget.user.email);
      }),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 209, 167, 216),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.sunny, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
