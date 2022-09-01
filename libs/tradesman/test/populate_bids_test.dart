import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/methods/populate_bids.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.mock());

  const bidOne = BidModel(
      id: "b#001",
      userId: "u12345",
      priceLower: 10,
      priceUpper: 20,
      dateCreated: 123456);
  const bidTwo = BidModel(
      id: "b#002",
      userId: "u12346",
      priceLower: 12,
      priceUpper: 100,
      dateCreated: 989999989);

  List<BidModel> bids = [];

  bids.add(bidOne);
  bids.add(bidTwo);

  List<Widget> result = populateBids("u12345", bids, store);

  test("populate bids unit test", () {
    expect(2, result.length);
  });
}
