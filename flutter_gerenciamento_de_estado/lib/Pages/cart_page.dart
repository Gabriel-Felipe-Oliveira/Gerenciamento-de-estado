import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/components/cart_item.dart';

import 'package:flutter_gerenciamento_de_estado/models/order_list.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Carrinho')),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'total:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      label: Text(
                        'R\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Provider.of<OrderList>(
                          context,
                          listen: false,
                        ).addOrder(cart);

                        cart.clear();
                      },
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      )),
                      child: const Text('COMPRAR'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, index) => CartItemWidget(
                  items[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
