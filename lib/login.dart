import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatra_path/forgotpassword.dart';
import 'package:yatra_path/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _loading = false;
  // String? _errorMessage;

  signin() async {
    setState(() {
      _loading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "error message",
        e.code,
        margin: EdgeInsets.all(20),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        duration: Duration(seconds: 5),
        maxWidth: 600, // optional for web/tablet, helps avoid clipping
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        snackStyle: SnackStyle.FLOATING,

        // Custom font
        titleText: Text(
          'error message',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.code.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error Message",
        e.toString(),
        margin: EdgeInsets.all(20),
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        borderRadius: 10,
        duration: Duration(seconds: 5),
        maxWidth: 600, // optional for web/tablet, helps avoid clipping
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        snackStyle: SnackStyle.FLOATING,

        titleText: Text(
          'error message',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString().toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 50),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Yatra",
                        style: GoogleFonts.arizonia(
                          fontSize: 80,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back, you have been missed',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 44,
                        width: double.infinity,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Enter Email",
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 44,
                        width: double.infinity,
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Enter Password",
                            hintStyle: GoogleFonts.poppins(fontSize: 14),

                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 08), // add spacing above if needed
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgotPassword());
                          },
                          child: Text(
                            "Forgot Password",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 93, 92, 92),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: signin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            backgroundColor:
                                Colors.black, // You can customize the color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                          child: Text("Sign In"),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                              endIndent: 10,
                            ),
                          ),
                          Text(
                            'Or continue with',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 87, 87, 87),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 70,
                        width: 60,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(
                                12,
                              ), // Optional: control logo spacing
                            ),
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Text.rich(
                        TextSpan(
                          text: "Not a member? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Register Now",
                              style: GoogleFonts.notoSansOldItalic(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 3, 76, 136),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(Signup());
                                },
                            ),
                          ],
                        ),
                      ),

                      // if (_errorMessage != null) ...[
                      //   const SizedBox(height: 16),
                      //   Text(
                      //     _errorMessage!,
                      //     style: const TextStyle(color: Colors.red),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ],
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
