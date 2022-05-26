import 'package:amplify/amplify.dart';
// import 'package:amplify/amplifyconfiguration.dart'; // uncomment this after pull
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/user_models/consumer_model.dart';

import 'models/user_model.dart';

@immutable
class AppState {
  // put all app state requiered here
  final UserModel? user; // autogenerated user id from amplify
  final bool signUpComplete;
  final List<Advert> adverts;

  // constructor must only take named parameters
  const AppState({
    required this.user,
    required this.adverts,
    required this.signUpComplete,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    if (!Amplify.isConfigured) {
      WidgetsFlutterBinding.ensureInitialized();
      initializeApp();
    }
    return const AppState(
      user: null,
      adverts: [],
      signUpComplete: false,
    );
  }

  factory AppState.mock() {
    return const AppState(
      user: ConsumerModel("0", "name", "some@email.com", []),
      adverts: [],
      signUpComplete: false,
    );
  }

  // easy way to replace store wihtout specifying all paramters
  AppState replace({
    UserModel? user,
    List<Advert>? adverts,
    bool? signUpComplete,
  }) {
    return AppState(
        user: user ?? this.user,
        adverts: adverts ?? this.adverts,
        signUpComplete: signUpComplete ?? this.signUpComplete);
  }

  // ===========================================================================
  // used for configuring amplify
  static Future<void> initializeApp() async {
    await _configureAmplify();
  }

  static Future<void> _configureAmplify() async {
    try {
      final AmplifyAPI api = AmplifyAPI(modelProvider: ModelProvider.instance);
      final AmplifyDataStore ds =
          AmplifyDataStore(modelProvider: ModelProvider.instance);
      final AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([
        api,
        ds,
        authPlugin,
      ]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      // await Amplify.configure(
      //     amplifyconfig); // uncomment this line and add your amplify config package
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      // print('An error occurred while configuring Amplify: $e');
    }
  }
}
