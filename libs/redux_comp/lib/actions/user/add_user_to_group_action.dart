import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/intiate_auth_action.dart';
import 'package:redux_comp/actions/user/check_user_exists_action.dart';
import 'package:redux_comp/actions/user/login_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/error_type_model.dart';

/* AddUserToGroupAction */
/* This action adds a user to a specified group if they have been verified on signup */

class AddUserToGroupAction extends ReduxAction<AppState> {
  final String username;
  final String group;

  AddUserToGroupAction(this.username, this.group);
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation  {
          addUserToGroup(email: "$username", group: "$group")
        }
        ''';
    final requestUserGroup = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      final result =
          await Amplify.API.mutate(request: requestUserGroup).response;
      debugPrint(result.data);
      return state.copy(userDetails: state.userDetails!.copy(userType: group));
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToAddUserToGroup);
    }
  }

  @override
  void after() async {
    await dispatch(CheckUserExistsAction());
  }
}
