import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthService {
  static Future<String?> handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication googleAuth = await account.authentication;
        log('Access Token: ${googleAuth.accessToken.toString()}');
        return googleAuth.accessToken.toString();
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<String?> handleFacebookSignIn() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      log(loginResult.toString());
      return loginResult.accessToken!.token;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<String?> handleAppleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: credential.authorizationCode,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      // log(credential.authorizationCode.toString());
      log(userCredential.additionalUserInfo!.profile!['email'].toString());
      // log(oauthCredential.toString());
      // return credential.authorizationCode;
      return userCredential.additionalUserInfo!.profile!['email'].toString();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
