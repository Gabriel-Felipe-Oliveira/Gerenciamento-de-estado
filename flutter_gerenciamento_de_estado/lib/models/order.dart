import 'package:flutter_gerenciamento_de_estado/models/cart_item.dart';

class Order {
  final String id;
  final num total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
