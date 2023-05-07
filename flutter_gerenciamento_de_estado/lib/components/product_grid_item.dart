import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart.dart';

import 'package:flutter_gerenciamento_de_estado/models/product.dart';
import 'package:flutter_gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(
      context,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          //
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  product.toggleFavorite();
                },
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            //
            title: Text(product.name),
            //

            trailing: IconButton(
              onPressed: () {
                cart.addItem(product);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: const Text('Produto adicionado com sucesso!'),
                    action: SnackBarAction(
                      label: 'DESFAZER',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          //
          child: GestureDetector(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.productDetail, arguments: product);
              // Navigator.of(context)
              //     .pushNamed(AppRoutes.counterPage, arguments: product);
            },
          )),
    );
  }
}
