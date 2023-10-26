import 'package:flutter/cupertino.dart';

import '../../../network/api/api_service.dart';

class BroadcastProvider with ChangeNotifier {
  List<dynamic>? broadcastPost;
  String error = '';
  String message = '';

  fetchOrbitData(bool isFetch) async {
    try {
      if (isFetch == true) {
        error = '';
        message = '';
        broadcastPost = null;
      }
      final response = await ApiService.apiRequest('post/allPost',
          method: RequestMethod.GET);
      broadcastPost = response['allPost'];
      print("response print");
      print(response);
      /* orbitPost = [
        ...(orbitPost == null ? [] : orbitPost as List),
        ...response
      ];*/

      notifyListeners();
    } catch (e) {
      print(e);
      error = e.toString();
      broadcastPost = null;
      notifyListeners();
    }
  }
}
