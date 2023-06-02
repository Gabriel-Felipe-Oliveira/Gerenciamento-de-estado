import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/components/app_drawer.dart';
import 'package:flutter_gerenciamento_de_estado/components/badgee.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

enum FilterOpitons {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  @override
  void initState() {
    
    super.initState();
    Provider.of<ProductList>(
      context,listen:false 
      ).loadProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOpitons.favorite,
                child: Text('Somente favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOpitons.all,
                child: Text('Somente favoritos'),
              ),
            ],
            onSelected: (FilterOpitons selectedValue) {
              setState(() {
                if (selectedValue == FilterOpitons.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.cartPage,
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: _isLoading  ? const Center (child: CircularProgressIndicator(),): ProductGrid(_showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
