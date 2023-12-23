import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItems({
    required String token,
    required userId,
  }) async {
    print(token);
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItem,
      method: HttpMethods.post,
      header: {'X-Parse-Session-Token': token},
      body: {'user': userId},
    );

    if (result['result'] != null) {
      print("tem carrinho");
      print(result['result']);

    } else {
      print("Ocorreu um erro");
    }
  }
}
