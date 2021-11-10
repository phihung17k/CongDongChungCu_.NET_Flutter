
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/service/interface/i_profile_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class ProfileService implements IProfileService{

  final ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<StoreDTO> getStoreByCondition(GetStoreCondition request) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store + "/" + "condition");

    if (request.residentId != null) {
      url += "?resident-id=" + request.residentId.toString();
    }

    if (request.storeId != null) {
      url += "?store-id=" + request.storeId.toString();
    }

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print('respone: ' + adapter.parseToString(response));
        Map<String, dynamic> result = adapter.parseToMap(response);
        var storeDTO = StoreDTO.fromJsonModel(result);

        print(
            "StoreId Service getBy condition: " + storeDTO.storeId.toString());

        return storeDTO;
      } else {
        print(url);
      }
    } finally {
      client.close();
    }
    return null;
  }
}