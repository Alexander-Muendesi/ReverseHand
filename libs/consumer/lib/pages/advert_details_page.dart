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

                  //******************EDIT ICON****************//
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      onPressed: vm.pushCreateNewAdvert,
                      icon: const Icon(Icons.edit),
                      color: Colors.white70,
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 50)),
                  //**********************************************/

                  //*************BOTTOM BUTTONS**************//
                  Stack(alignment: Alignment.center, children: <Widget>[
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 2,
                    ),

                    //view bids
                    Positioned(
                        top: 15,
                        child: ButtonWidget(
                            text: "View Bids", function: vm.pushViewBidsPage)),

                    //Delete - currently just takes you back to Consumer Listings page
                    Positioned(
                        top: 75,
                        child: ButtonWidget(
                            text: "Delete",
                            color: "light",
                            transparent: true,
                            function: vm.pushConsumerListings)),

                    //Back
                    Positioned(
                        top: 135,
                        child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            whiteBorder: true,
                            function: vm.popPage))
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
        pushCreateNewAdvert: () => dispatch(
          NavigateAction.pushNamed('/consumer/create_advert'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/consumer'),
        ),
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.user!.activeAd!,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushCreateNewAdvert;
  final VoidCallback pushConsumerListings;
  final VoidCallback popPage;

  _ViewModel(
      {required this.advert,
      required this.pushCreateNewAdvert,
      required this.pushViewBidsPage,
      required this.pushConsumerListings,
      required this.popPage}); // implementinf hashcode
}
