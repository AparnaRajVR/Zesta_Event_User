import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../view/screen/entry/login_screen.dart';
import '../view/screen/dash_board.dart';

class FirebaseControl extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create an instance
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final Rxn<User> _firebaseUser = Rxn<User>();
  var verificationId = "".obs;

  String? get userEmail => _firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<void> createUser(String fullname, String email, String password,
      String confirmpassword) async {
    if (password != confirmpassword) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    try {
      // Create user in Firebase Auth
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Add user data to Firestore
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Users');
      Map<String, String> userdata = {
        "Full Name": fullname,
        "Email": email,
        
      };

      await reference.add(userdata);

      Get.offAll(() => LoginScreen());
    } catch (e) {
      String errorMessage = getErrorMessage(e.toString());
      Get.snackbar("Error while creating account", errorMessage);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => Dashboard());
    } catch (e) {
      String errorMessage = getErrorMessage(e.toString());
      Get.snackbar("Error while signing in", errorMessage);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      String errorMessage = getErrorMessage(e.toString());
      Get.snackbar("Error while signing out", errorMessage);
    }
  }



  googleSignIN() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    await _auth.signInWithCredential(credential);
    Get.offAll(Dashboard());
  }

  Future<void> phoneAuthentication(String phone) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar('Error', 'spmrthing went wrong.Try again');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        });
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

void sendPasswordResetEmail(String email)async{
  await _auth.sendPasswordResetEmail(email: email).then((Value){
Get.offAll(LoginScreen());
Get.snackbar("Password Reset email link has een sent ",'Success');
  }).catchError((onError)=>Get.snackbar("Error in Email Reset ",onError.message));
}
  String getErrorMessage(String error) {
    final RegExp errorPattern = RegExp(r'] (.+)');
    final match = errorPattern.firstMatch(error);
    return match?.group(1) ?? "An unexpected error occurred.";
  }
}
