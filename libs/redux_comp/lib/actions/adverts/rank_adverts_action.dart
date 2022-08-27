import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class RankAdvertsAction extends ReduxAction<AppState> {
  //Default constructor for now
  RankAdvertsAction();

  @override
  Future<AppState?> reduce() async {
    //mew list with updated advertRank
    List<AdvertModel> adverts = [];
    double ranking = 0.0;

    //First rank the adverts
    for (AdvertModel advert in state.adverts) {
      ranking = _rankTitle(advert) as double;
      _photoRank(advert);
      _rankDescription(advert);
      _rankDateCreated(advert);

      //create a new advert with updated rank
      AdvertModel ad = advert.copy(advertRank: ranking);
      adverts.add(ad);
      //reset the counter
      ranking = 0.0;
    }
    //Now have to sort the adverts based on the rank.
  }

  int _rankTitle(AdvertModel advert) {
    List<String>? tradeTypes = state.userDetails?.tradeTypes;
    int ranking = 0;

    //First check if the title contains the tradetype of a tradesman
    for (String trade in tradeTypes!) {
      if ((advert.title.toLowerCase()).contains(trade.toLowerCase())) {
        ranking += 2;
        break; //exit on first match
      }
    }

    //Next check if there is more than one word in the title
    String title = advert.title.trim(); //remove leading and trailing whitespace
    final splitted = title.split(' '); //get words delimited by space

    if (splitted.length > 1) {
      ranking += 1;
    }

    //Next check the length of the title
    if (title.length > 12 && title.length < 25) {
      ranking += 1;
    }

    return ranking;
  }

  void _photoRank(AdvertModel advert) {}

  void _rankDescription(AdvertModel advert) {}

  void _rankDateCreated(AdvertModel advert) {}
}

/**
 * A maximum rating of 10 can be achieved.
 * 
 * Ratings are based on Title, Description, Photo and Date created
 * Title = 4 points max, Description = 2 points max
 * Photo = 2 points max, Date Created = 2 points max
 * 
 * Title: Check the following:
 * (a). Length of title: 12 < chars < 25 gets 1 else 0 point
 * (b). More than one word in the Title i.e descriptive Title. 1 point
 * (c). Title contains tradetype of tradesman 2 points
 * 
 * Description: Check the following:
 * (a). Length of the Description. 1 points based on some measurement
 * (b). Presence of any numbers that could potentially be dimensions or quantity
 *      1 point for this.
 * 
 * Photo: 
 * (a). Presence of Photo equals 2 points straight
 * 
 * Date Created: 
 * (a). Adverts where  7 days < date_created < 40 days get 2 points else 1 point
 */
