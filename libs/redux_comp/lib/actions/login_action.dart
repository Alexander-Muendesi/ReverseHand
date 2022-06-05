import 'dart:async';
// import 'package:amplify/models/Advert.dart';
// import 'package:amplify/models/Consumer.dart';
// // import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/app_state.dart';

// import '../models/user_models/consumer_model.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      AuthUser user = await Amplify.Auth.getCurrentUser();
      String id = user.userId;
      List<AuthUserAttribute> userAttr = await Amplify.Auth.fetchUserAttributes();
      // await Amplify.Auth.signOut();
      return state;
      // exception will be handled later
      // } on AuthException catch (e) {
    } catch (e) {
      // print(e.underlyingException);
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }
}
