import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/components/app_drawer.dart';
import 'package:flutter_gerenciamento_de_estado/components/order.dart';
import 'package:flutter_gerenciamento_de_estado/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Pedidos'),
        ),
        drawer: const AppDrawer(),
        body: orders.itemsCount != 0
            ? ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, index) => OrderWidget(
                      order: orders.items[index],
                    ))
            : const Center(
                child: SizedBox(
                  child: Text('Nenhum pedido encontrado '),
                ),
              ));
  }
}
