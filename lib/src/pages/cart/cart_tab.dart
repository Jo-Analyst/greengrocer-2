import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final cartController = Get.find<CartController>();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItems.remove(cartItem);
      UtilsServices.showToast(
          message: "${cartItem.item.itemName} removido(a) do carrinho");
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in app_data.cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text("Confirmação"),
          content: const Text("Deseja realmente concluir o pedido?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Não"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Sim"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                return controller.cartItems.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_shopping_cart,
                            size: 40,
                            color: CustomColors.customSwatchColor,
                          ),
                          const Text("Não fá items no carrinho"),
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (_, index) {
                          return CartTile(
                            cartItem: controller.cartItems[index],
                          );
                        },
                      );
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Total geral",
                  style: TextStyle(fontSize: 12),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      UtilsServices.priceToCurrency(
                        controller.cartTotalPrice(),
                      ),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(
                    height: 50,
                    child: GetBuilder<CartController>(
                      builder: (controller) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: CustomColors.customSwatchColor,
                          ),
                          onPressed: controller.isCheckoutLoading
                              ? null
                              : () async {
                                  final result = await showOrderConfirmation();

                                  if (result ?? false) {
                                    cartController.checkoutCart();
                                  } else {
                                    UtilsServices.showToast(
                                      message: "Pedido não confirmado",
                                    );
                                  }
                                },
                          child: controller.isCheckoutLoading
                              ? const SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator())
                              : const Text(
                                  "Concluir pedido",
                                  style: TextStyle(fontSize: 18),
                                ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
