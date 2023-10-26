import 'package:cosmic_post_office_main/network/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class OrbitProvider with ChangeNotifier {
  List<dynamic>? orbitPost;
  String error = '';
  String message = '';

  fetchOrbitData(bool isFetch, String id) async {
    try {
      if (isFetch == true) {
        error = '';
        message = '';
        orbitPost = null;
      }
      final response = await ApiService.apiRequest('post/get/$id',
          method: RequestMethod.GET);
      orbitPost = response['singlePost'];
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
      orbitPost = null;
      notifyListeners();
    }
  }

  postUpdate({required String id, required String status}) async {
    try {
      print('post/update/$id');
      final response = await ApiService.apiRequest('post/update/$id',
          method: RequestMethod.PUT, body: {'status': status});
      //await fetchOrbitData(true, id);

      print(response);

      notifyListeners();
    } catch (e) {
      print(e);
      error = e.toString();
      orbitPost = null;
      notifyListeners();
    }
  }
}
