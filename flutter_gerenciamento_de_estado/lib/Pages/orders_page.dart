

import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/components/app_drawer.dart';
import 'package:flutter_gerenciamento_de_estado/components/order.dart';
import 'package:flutter_gerenciamento_de_estado/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState(){
   super.initState();
   Provider.of<OrderList>(
     context,
     listen: false,
   ).loadOrders().then((_){
     setState(() => _isLoading = false);
   });
  }

  Future<void> _refreshOrders(BuildContext context){
    return Provider.of<OrderList>(context,listen: false).loadOrders();
    }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Pedidos'),
        ),
        drawer: const AppDrawer(),
         body:RefreshIndicator(
          onRefresh: () => _refreshOrders(context),
           child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : 
              ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) => OrderWidget(
                        order: orders.items[index],
                      ))
                      ,
         )
            );
  }
}
