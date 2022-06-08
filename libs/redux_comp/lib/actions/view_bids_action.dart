import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/bid_model.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../models/advert_model.dart';

// pass in the advert id whos bids you want to see
class ViewBidsAction extends ReduxAction<AppState> {
  final String adId;

  ViewBidsAction(this.adId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewBids(ad_id: "$adId") {
        id
        user_id
        price_lower
        price_upper
        quote
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      final response = await Amplify.API.query(request: request).response;

      final data = jsonDecode(response.data);

      List<BidModel> bids = [];
      List<BidModel> shortlistedBids = [];

      for (dynamic d in data['viewBids']) {
        String id = d['id'];
        if (id.contains('s')) {
          shortlistedBids.add(BidModel.fromJson(d));
        } else {
          bids.add(BidModel.fromJson(d));
        }
      }

      final AdvertModel ad =
          state.user!.adverts.firstWhere((element) => element.id == adId);

      return state.replace(
        user: state.user!.replace(
          bids: bids,
          shortlistBids: shortlistedBids,
          activeAd: ad,
        ),
      );
    } catch (e) {
      return state;
    }
  }
}
