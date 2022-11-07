import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincareapp/app/pages/evening/evening_page.dart';
import 'package:skincareapp/app/pages/morning/morning_page.dart';

class CarePage extends StatelessWidget {
  const CarePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SkinCare'),
          backgroundColor: const Color.fromARGB(255, 209, 167, 216),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MorningPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 220,
                      width: 160,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage(
                              'images/morning.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                      child: Center(
                        child: Text(
                          'Rano',
                          style: GoogleFonts.manrope(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EveningPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 220,
                      width: 160,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage(
                              'images/evening.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                      child: Center(
                        child: Text(
                          'Wieczór',
                          style: GoogleFonts.manrope(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Color.fromARGB(255, 209, 167, 216),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Color.fromARGB(255, 209, 167, 216),
                ),
              ),
            ],
          ),
        ));
  }
}
