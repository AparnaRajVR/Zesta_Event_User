
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../view/screen/entry/login_screen.dart';
import '../view/screen/dash_board.dart';

class FirebaseControl extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final Rxn<User?> _firebaseUser = Rxn<User?>();
  var verificationId = "".obs;

  String? get userEmail => _firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<void> createUser(String fullname, String email, String password, String confirmpassword) async {
    if (password != confirmpassword) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
        "Full Name": fullname,
        "Email": email,
      });

      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar("Error", getErrorMessage(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => Dashboard());
    } catch (e) {
      Get.snackbar("Error while signing in", getErrorMessage(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar("Error while signing out", getErrorMessage(e.toString()));
    }
  }

  Future<void> googleSignIN() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await _auth.signInWithCredential(credential);
      Get.offAll(() => Dashboard());
    } catch (e) {
      Get.snackbar("Google Login Failed", getErrorMessage(e.toString()));
    }
  }

  Future<void> phoneAuthentication(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAll(() => Dashboard());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', e.code == 'invalid-phone-number' ? 'Invalid phone number' : 'Something went wrong. Try again.');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", getErrorMessage(e.toString()));
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp),
      );
      return credentials.user != null;
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP. Please try again.");
      return false;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await _auth.signInWithCredential(credential);
        Get.offAll(() => Dashboard());
      } else {
        Get.snackbar("Facebook Login Failed", result.message ?? "Unknown error");
      }
    } catch (e) {
      Get.snackbar("Error", "Facebook login failed: ${e.toString()}");
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.offAll(() => LoginScreen());
      Get.snackbar("Success", "Password reset email has been sent.");
    } catch (e) {
      Get.snackbar("Error", "Failed to send reset email: ${e.toString()}");
    }
  }

  String getErrorMessage(String error) {
    final RegExp errorPattern = RegExp(r'] (.+)');
    final match = errorPattern.firstMatch(error);
    return match?.group(1) ?? "An unexpected error occurred.";
  }
}
