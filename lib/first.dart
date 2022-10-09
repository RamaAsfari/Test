import 'package:elkood1/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirsrtScreen extends StatefulWidget {
  const FirsrtScreen({Key? key}) : super(key: key);

  @override
  State<FirsrtScreen> createState() => _FirsrtScreenState();
}

class _FirsrtScreenState extends State<FirsrtScreen> {
  @override
  var index;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1593014213403-75c9840d6c55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8NHx8fGVufDB8fHx8&w=1000&q=80',
            fit: BoxFit.cover,
          ),
          SafeArea(
              child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 220, left: 20),
                child: Positioned(
                  top: MediaQuery.of(context).size.width,
                  child: Text(
                    'Photo Gallery',
                    style: GoogleFonts.getFont('Passions Conflict',
                        textStyle: TextStyle(
                            color: Color(0xFF363062),
                            fontSize: MediaQuery.of(context).size.height * 0.1,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  height: 55,
                  width: 175,
                  decoration: BoxDecoration(
                    color: Color(0xFF827397),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final Future<SharedPreferences> _prefs =
                          SharedPreferences.getInstance();
                      final SharedPreferences prefs = await _prefs;
                      prefs.setBool('first', false);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TaskOne()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Let\'s start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
