import 'package:admin/widgets/admin_appbar_user_actions_widget.dart';
import 'package:admin/widgets/admin_appbar_widget.dart';
import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/get_reported_users_action.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminUsersPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminUsersPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                            title: "User Management", store: store),
                        //*******************************************//

                        LoadingWidget(
                            padding: MediaQuery.of(context).size.height / 3)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                          title: "User Management",
                          store: store,
                          filterActions: AdminAppbarUserActionsWidget(
                            store: store,
                            functions: {
                              "List reported users": vm.pushUserReportsPage
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminUsersPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        pushUserReportsPage: () {
          dispatch(GetReportedUsersAction());
          dispatch(NavigateAction.pushNamed('/admin_reported_users'));
        },
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final VoidCallback pushUserReportsPage;

  _ViewModel({
    required this.loading,
    required this.pushUserReportsPage,
  }) : super(equals: [loading]); // implementinf hashcode;
}

// Map<String, VoidCallback> _usersPageOptions(_ViewModel vm) {
//   return {
//     "List reported users": vm.pushUserReportsPage
//   };
  
// }
