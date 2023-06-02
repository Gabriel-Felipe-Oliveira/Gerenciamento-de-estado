import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gerenciamento_de_estado/exceptions/auth_exception.dart';
import 'package:http/http.dart' as http;

import '../utils/app_routes.dart';

class Auth with ChangeNotifier{



Future<void> _authenticate(String email, String password, String urlFragment) async{
  final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyBvXgSjLQwBgWA1X2c1kAFIU_sYRKdGCVY';
   final response = await http.post(
    Uri.parse(url),
    body: jsonEncode({
    'email': email,
    'password': password,
    'returnSecureToken' :true,
    })
  );
  final body = jsonDecode(response.body);
  if(body['error'] != null ){
    throw AuthException(body['error']['menssage']);
  }
  
}

Future<void> signup(String email, String password) async{
   _authenticate(email,password,'signUp');
}

Future<void> login(String email, String password) async{
  try{
    final response = await _authenticate(email,password,'signInWithPassword');
    print('Autenticação bem-sucedida');
    
  }
  catch(error){
   debugPrint(error.toString());
  }
  
   
}

}