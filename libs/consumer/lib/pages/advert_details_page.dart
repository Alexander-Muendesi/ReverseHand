import 'package:async_redux/async_redux.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:general/widgets/floating_button.dart';

class AdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) =>
                SingleChildScrollView(
              child: Column(
                children: [
                  //**********APPBAR***********//
                  const AppBarWidget(title: "JOB INFO"),

                  //*******************************************//

                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),

                  //*******************************************//

                  //**********TABS TO FILTER ACTIVE/SHORTLISTED BIDS***********//
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TabWidget(
                  //       text: "ACTIVE",
                  //       onPressed: (activate) =>
                  //           vm.dispatchToggleViewBidsAction(false, activate),
                  //     ),
                  //     const Padding(padding: EdgeInsets.all(5)),
                  //     TabWidget(
                  //       text: "SHORTLIST",
                  //       onPressed: (activate) =>
                  //           vm.dispatchToggleViewBidsAction(true, activate),
                  //     ),
                  //   ],
                  // ),
                  //***********************************************************//

                  // creating bid widgets
                  // ...populateBids(vm.bids, store)

                  const Padding(padding: EdgeInsets.only(top: 130)),

                  //*************BOTTOM BUTTONS**************//
                  Stack(alignment: Alignment.center, children: <Widget>[
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 3,
                    ),

                    //view bids - onpressed not correct yet
                    Positioned(
                        top: 30,
                        child: ButtonWidget(
                            text: "View Bids", function: vm.pushViewBidsPage)),

                    //Delete - onPressed not correct yet
                    Positioned(
                        top: 80,
                        child: ButtonWidget(
                            text: "Delete",
                            transparent: true,
                            function: vm.pushViewBidsPage))
                  ]),
                  //*************BOTTOM BUTTONS**************//
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*****************************************************/

          //*******************ADD BUTTON********************//
          resizeToAvoidBottomInset: false,
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          //*************************************************//
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdvertDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/view_bids'),
        ),
        advert: state.user!.activeAd!,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;

  _ViewModel({
    required this.advert,
    required this.pushViewBidsPage,
  }); // implementinf hashcode
}
