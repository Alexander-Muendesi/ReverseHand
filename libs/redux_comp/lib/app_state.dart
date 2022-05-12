import 'package:amplify/amplify.dart';
// import 'package:amplify/amplifyconfiguration.dart'; // uncomment this after pull
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';

@immutable
class AppState {
  // put all app state requiered here
  final String id; // autogenerated user id from amplify
  final String username; // users email
  final List<Advert> adverts; //supposed to be final, ask mike...

  // constructor must only take named parameters
  const AppState(
      {required this.id, required this.username, required this.adverts});

  // this methods sets the starting state for the store
  factory AppState.initial() {
    if (!Amplify.isConfigured) {
      WidgetsFlutterBinding.ensureInitialized();
      initializeApp();
    }
    return const AppState(id: "", username: "", adverts: []);
  }

  factory AppState.mock() {
    return const AppState(id: "1234567890", username: "TestName", adverts: []);
  }

  // easy way to replace store wihtout specifying all paramters
  AppState replace({String? id, String? username, List<Advert>? adverts}) {
    return AppState(
        id: id ?? this.id,
        username: username ?? this.username,
        adverts: adverts ?? this.adverts);
  }

  // ===========================================================================
  // used for configuring amplify
  static Future<void> initializeApp() async {
    await _configureAmplify();
  }

  static Future<void> _configureAmplify() async {
    try {
      final AmplifyAPI _api = AmplifyAPI(modelProvider: ModelProvider.instance);
      final AmplifyDataStore _ds =
          AmplifyDataStore(modelProvider: ModelProvider.instance);

      // add Amplify plugins
      await Amplify.addPlugins([
        _api,
        _ds,
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
