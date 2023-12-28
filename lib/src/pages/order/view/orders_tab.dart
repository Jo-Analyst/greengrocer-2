import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/order/components/order_tile.dart';
import 'package:greengrocer/src/pages/order/controller/all_orders_controller.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return OrderTile(
                  order: controller.allOrders[index],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: controller.allOrders.length,
            ),
          );
        },
      ),
    );
  }
}
