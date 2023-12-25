import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  bool isCheckoutLoading = false;

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItem();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);
    final result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setCheckoutLoading(false);

    result.when(
      success: (order) {
        cartItems.clear();
        update();
        showDialog(
          context: Get.context!,
          builder: (_) => PaymentDialog(
            order: order,
          ),
        );
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
        );
      },
    );
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      cartItemId: item.id,
      quantity: quantity,
      token: authController.user.token!,
    );
    if (result == true) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      UtilsServices.showToast(
        message:
            'Ocorreu unm erro ao alterar a quantidade do produto no carrinho',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItem() async {
    final result = await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];

      await changeItemQuantity(
          item: product, quantity: (product.quantity + quantity));
    } else {
      final result = await cartRepository.addItemToCart(
        authController.user.id!,
        quantity,
        item.id,
        authController.user.token!,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              item: item,
              id: "",
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          UtilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }

    update();
  }
}
