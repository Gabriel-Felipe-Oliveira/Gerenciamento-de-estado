import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart_item.dart';
import 'package:flutter_gerenciamento_de_estado/models/order.dart';
import 'package:http/http.dart' as http;

import '../utils/contants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async{
    _items.clear();
   final response = await http.get(Uri.parse('${Constantes.orderBaseUrl}.json'));
   if(response.body == 'null') return;
   Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
     _items.add(
      Order(

       id: orderId,
       date: DateTime.parse(orderData['date']),
       total: orderData['total'],
       products:(orderData['products'] as List<dynamic>).map((item) {
        return CartItem(
          id: item['id'],
          productId:item['productId'],
          name: item['name'],
          quantidade:item['quantidade'] ,
          price:item['price'] ,
        );
        }).toList(),
        ),
      );
    });
    
   notifyListeners();
  }


  Future<void> addOrder(Cart cart) async{
    final date = DateTime.now();
    final response =
     await http.post(
    Uri.parse('${Constantes.orderBaseUrl}.json'),
    body: jsonEncode(
    {
      'total':cart.totalAmount,
      'date': date.toIso8601String(),
      'products': cart.items.values.map((cartItem) => {
      'productId':cartItem.productId,
      'id':cartItem.id,
      'name':cartItem.name,
      'quantidade':cartItem.quantidade,
      'price':cartItem.price,
       },).toList(),

    },
    ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
