import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/order/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      header: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result']) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possível recuperar  os pedidos');
    }
  }
}
