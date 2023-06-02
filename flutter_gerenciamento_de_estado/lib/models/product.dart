import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/contants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
  Future<void> toggleFavorite() async{
    try{
      _toggleFavorite();
    final response = await http.patch(
      Uri.parse('${Constantes.productBaseUrl}/$id.json'),
      body:  jsonEncode({"isFavorite":isFavorite}),
    );
    if(response.statusCode >= 400){
        _toggleFavorite();
       throw const HttpException(
        'Não foi possivel excluir o produto',
        
        );
    }
    }catch(_){
     _toggleFavorite();

    }
    
  }
}
