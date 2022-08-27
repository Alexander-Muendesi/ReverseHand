import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/user/amplify_auth/logout_action.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/tradesman_navbar_widget.dart';
import 'package:general/widgets/notification_card_widget.dart';

class TradesmanActivityStream extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanActivityStream({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(title: "ACTIVITY STREAM", store: store),
                //********************************************************//

                //*******************MOCK NOTIFICATIONS CARDS*********************//
                const NotificationCardWidget(
                  titleText: "New Bid!",
                  date: "3 min ago",
                ),

                const NotificationCardWidget(
                  titleText: "Accepted!",
                  date: "3 min ago",
                ),

                const NotificationCardWidget(
                  titleText: "Job Closed.",
                  date: "3 min ago",
                ),

                //********************************************************//
              ],
            ),
          ),
        ),

        //************************NAVBAR***********************
        bottomNavigationBar: TNavBarWidget(
          store: store,
        ),
        //*****************************************************/
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanActivityStream> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchLogoutAction: () => dispatch(LogoutAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function() dispatchLogoutAction;
  _ViewModel({
    required this.dispatchLogoutAction,
  });
}
