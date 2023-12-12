import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/common_widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;
  final void Function(CartItemModel) remove;

  const CartTile({
    super.key,
    required this.cartItem,
    required this.remove,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // imagem
        leading: Image.asset(
          widget.cartItem.item.imgUrl,
          width: 60,
          height: 60,
        ),
        // name
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        // preço
        subtitle: Text(
          UtilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // controle de quantidade
        trailing: QuantityWidget(
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          isRemovable: true,
          result: (quantity) {
            setState(() {
              widget.cartItem.quantity = quantity;

              if (quantity == 0) {
                // Remover Item do carrinho
              widget.remove(widget.cartItem);
              }
            });
          },
        ),
      ),
    );
  }
}
