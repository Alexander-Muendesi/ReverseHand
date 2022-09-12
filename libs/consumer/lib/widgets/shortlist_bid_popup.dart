import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';

class ShortlistPopUpWidget extends StatelessWidget {
  final Store<AppState> store;

  const ShortlistPopUpWidget({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: const Text(
              "Are you sure you want to accept this bid?\n\n All other bids will be discarded.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
          ),
          StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: "Accept",
                  function: () {
                    vm.dispatchAcceptBidAction();

                    Navigator.pop(context);
                  },
                ),
                const Padding(padding: EdgeInsets.all(5)),
                ButtonWidget(
                  text: "Cancel",
                  function: () => Navigator.pop(context),
                  color: "light",
                  border: "lightBlue",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ShortlistPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;

  _ViewModel({
    required this.dispatchShortListBidAction,
    required this.dispatchAcceptBidAction,
  }); // implementinf hashcode
}
