import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatra_path/wrapper.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    sendVerifyLink();
    super.initState();
  }

  sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then(
      (value) => {
        Get.snackbar(
          "Link Sent",
          "A verification link has been sent to your email. Please check your inbox or spam folder.",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          borderRadius: 10,
          duration: Duration(seconds: 15),
          maxWidth: 600, // optional for web/tablet, helps avoid clipping
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          snackStyle: SnackStyle.FLOATING,
        ),
      },
    );
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!.reload().then(
      (value) => {Get.offAll(Wrapper())},
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Text(
            "Open your mail and click on the link provided to verify email & reload this page",
            style: GoogleFonts.poppins(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => reload()),
        child: Icon(Icons.restart_alt_rounded),
      ),
    );
  }
}
