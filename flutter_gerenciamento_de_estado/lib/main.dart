import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/Pages/orders_page.dart';
import 'package:flutter_gerenciamento_de_estado/Pages/product_detail_page.dart';
import 'package:flutter_gerenciamento_de_estado/Pages/product_form_page.dart';
import 'package:flutter_gerenciamento_de_estado/Pages/products_overview_page.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart.dart';
import 'package:flutter_gerenciamento_de_estado/models/order_list.dart';
import 'package:flutter_gerenciamento_de_estado/models/product_list.dart';

import 'package:flutter_gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'Pages/cart_page.dart';
import 'Pages/products_page.dart';

// import 'Pages/couter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Anton',
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Colors.purple,
                onPrimary: Colors.white,
                secondary: Colors.deepOrange,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.redAccent,
                background: Colors.white,
                onBackground: Colors.white,
                surface: Colors.purple,
                onSurface: Colors.white)),
        routes: {
          AppRoutes.home: (ctx) => const ProductsOverviewPage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          // AppRoutes.counterPage: (ctx) => CouterPage()
          AppRoutes.cartPage: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
