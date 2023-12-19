import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

 Future<HomeResult> getCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (result["result"] as List<Map<String, dynamic>>)
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult.success(data);
    } else {
      return HomeResult.error(
          "Ocorreu um erro inesperado ap recuperar as cegorias");
    }
  }
}
