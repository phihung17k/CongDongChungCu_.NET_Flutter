import 'package:http/http.dart' as http;
import '../api.dart';
import '../models/building_model.dart';
import 'interface/i_building_service.dart';
import 'service_adapter.dart';

class BuildingService implements IBuildingService {
  ServiceAdapter adapter = ServiceAdapter();

  //compute(Func(value), value)

  @override
  Future<List<BuildingModel>> getBuildings() async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.buildings);
    try {
      List<BuildingModel> result = [];
      var response = await client.get(Uri.parse(url));
      List<dynamic> list = adapter.parseToList(response);
      if (response.statusCode == 200) {
        result = List.from(list.map(
            (json) => BuildingModel.fromJson(json as Map<String, dynamic>)));
      }
      return result;
    } finally {
      client.close();
    }
  }
}
