import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj się',
                style: GoogleFonts.kodchasan(
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    hintText: 'E-mail'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    hintText: 'Hasło'),
              ),
              const SizedBox(height: 10),
              Text(errorMessage),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: widget.emailController.text,
                            password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    }
                  },
                  child: Text(
                    isCreatingAccount == true
                        ? 'Zarejestruj się'
                        : 'Zaloguj się',
                  ),
                ),
              ),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: Text(
                    'Utwórz konto',
                    style: GoogleFonts.kodchasan(),
                  ),
                ),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: Text(
                    'Masz już konto?',
                    style: GoogleFonts.kodchasan(),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
