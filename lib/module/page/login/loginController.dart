import 'dart:convert';

import 'package:basic_fundamental/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../service/auth_service.dart';
import '../../../data/repo/user_repo.dart';
import '../../../service/TokenService.dart';

class auth_google_login extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User_Respository user_respository = User_Respository();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId:
    // "234888009676-8iovn6e2h9p2hdc3upskfu99ssjkjoho.apps.googleusercontent.com",
    // serverClientId:
    // "234888009676-8iovn6e2h9p2hdc3upskfu99ssjkjoho.apps.googleusercontent.com",
    clientId:dotenv.env['GOOGLE_CLIENT_AND_SERVER_ID'],
    serverClientId: dotenv.env['GOOGLE_CLIENT_AND_SERVER_ID'],
  );

  final _storage = const FlutterSecureStorage();

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  // Future<void> SignInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
  //
  //     if (googleuser == null) return;
  //
  //     final GoogleSignInAuthentication googleauth =
  //         await googleuser.authentication;
  //     final idtoken = googleauth.idToken;
  //
  //     final response = await http.post(
  //         Uri.parse("http://10.90.29.17:8000/user_accounts/auth/google/"),
  //         headers: {"Content-Type": "application/json"},
  //         body: jsonEncode({"id_token": idtoken}));
  //
  //     final data = jsonDecode(response.body);
  //
  //     await _storage.write(key: "access", value: data["access"]);
  //     await _storage.write(key: "refresh", value: data["refresh"]);
  //
  //     // final AuthCredential credential = GoogleAuthProvider.credential(
  //     //     accessToken: googleauth.accessToken, idToken: googleauth.idToken);
  //     //
  //     // await _auth.signInWithCredential(credential);
  //
  //     Get.offAllNamed(App_route.home_page);
  //   } catch (e) {
  //     print('${e.toString()}');
  //     Get.snackbar("login failed", e.toString());
  //   }
  // }
  // Future<void> SignInWithGoogle() async {
  //   try {
  //     final googleuser = await _googleSignIn.signIn();
  //     if (googleuser == null) return;
  //
  //     final googleauth = await googleuser.authentication;
  //     final idtoken = googleauth.idToken;
  //
  //     final response = await http.post(
  //       Uri.parse("${Auth_service.ip}/user_accounts/auth/google/"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"google_id_token": idtoken}),
  //     );
  //
  //     print('${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       await _storage.write(key: "access", value: data["access"]);
  //       await _storage.write(key: "refresh", value: data["refresh"]);
  //       Auth_service.isAuthenticate=true;
  //       Get.offAllNamed(App_route.home_page);
  //
  //     }
  //   } catch (e) {
  //     Get.snackbar("login failed", e.toString());
  //     Auth_service.isAuthenticate=false;
  //   }
  // }
  Future<void> SignInWithGoogle() async {
    try {
      // GoogleSignInAccount? googleuser = await _googleSignIn.signInSilently();
      final googleuser = await _googleSignIn.signIn();
      if (googleuser == null) return;

      final googleauth = await googleuser.authentication;
      final idtoken = googleauth.idToken;

      final data = await user_respository.get_new_login(idtoken!);

      final newAccess = data['access'];
      final newRefresh = data['refresh'];

      await Token_service.set_access_refresh_token(newAccess, newRefresh);
      Auth_service.isAuthenticate = true;
      Get.offAllNamed(appRoute.mainHome);
    } catch (e) {
      Get.snackbar("login failed", e.toString());
      Auth_service.isAuthenticate = false;
    }
  }

  Future<void> Switch_google_Account() async {
    _googleSignIn.signOut();
    final google_user = await _googleSignIn.signIn();
    if (google_user == null) return;
    final google_auth = await google_user.authentication;
    final idtokon = google_auth.idToken;

    final data = await user_respository.get_new_login(idtokon!);

    final new_access = data['access'];
    final new_refresh = data['refresh'];

    await Token_service.set_access_refresh_token(new_access, new_refresh);
    // final user_details_controller user = Get.find<user_details_controller>();
    // final Like_Controller like = Get.find<Like_Controller>();
    // final Playlist_Controller playlist_controller = Get.find<Playlist_Controller>();
    // await user.fetch_user();
    // await like.get_current_user_like_songs();
    // await playlist_controller.show_user_playlist();
    Get.offAllNamed(appRoute.mainHome);
  }

  Future<void> signOut() async {
    await _storage.deleteAll();
    await _googleSignIn.signOut();
    await _auth.signOut();
    Auth_service.isAuthenticate = false;
    Get.offAllNamed(appRoute.login);
  }

  Future<bool> hasTaken() async {
    final token = await _storage.read(key: "access");
    final refresh_token = await _storage.read(key: 'refresh');
    if (token == null) return false;
    bool hasexpired = JwtDecoder.isExpired(token);
    if (!hasexpired) {
      return true;
    }

    if (refresh_token == null) return false;
    try {
      final response = await http.post(
        Uri.parse('${Auth_service.ip}/user_accounts/auth/token/refresh/'),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode({"refresh": refresh_token}),
      );

      // print('new tokens always false ${response.body}');

      if (response.statusCode != 200) {
        return false;
      }
      final data = jsonDecode(response.body);
      await _storage.write(key: 'access', value: data['access']);
      await _storage.write(key: 'refresh', value: data['refresh']);
      return true;
    } catch (e) {
      return false;
    }
  }
}
