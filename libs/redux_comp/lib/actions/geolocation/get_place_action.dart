import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/geolocation/suggestion_model.dart';

class GetPlaceAction extends ReduxAction<AppState> {
  Suggestion input;
  bool confirm;
  PlaceApiService placeApi;

  GetPlaceAction(this.input, this.placeApi, this.confirm);

  @override
  Future<AppState?> reduce() async {
    try {
      Location result = await placeApi.getPlaceDetailFromId(input.placeId);

      return state.copy(locationResult: result);
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    (confirm) ? 
    dispatch(NavigateAction.pushReplacementNamed('/geolocation/location_confirm')) : dispatch(NavigateAction.pop());
  }
}
