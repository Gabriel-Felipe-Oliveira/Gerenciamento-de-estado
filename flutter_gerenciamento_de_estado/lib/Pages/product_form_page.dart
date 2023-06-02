import 'package:flutter/material.dart';

import 'package:flutter_gerenciamento_de_estado/models/product_list.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isload = false;


  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }



  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    if(_formData.isEmpty){
      final argumento = ModalRoute.of(context)?.settings.arguments;
      if(argumento != null){
        final product = argumento as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;

      }
    }
  }

  void dispode() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    
    return isValidUrl ;
  }

  Future<void> _submitForm() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      
      return ;
    }

    _formKey.currentState?.save();
    setState(() => _isload = true);

    try{
        await Provider.of<ProductList>(
          context,
           listen: false,).saveProduct(_formData);

    }  catch(error){
        await  showDialog<void>(
        context: context,
         builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content:  const Text('Ocorreu um erro para salvar '),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
               child: const Text('Ok'),)
          ],
         ));

    }finally{
      setState(() => _isload = false);
      Navigator.of(context).pop();
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fomulario de produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body:_isload ? Center(child:CircularProgressIndicator(),)
      : Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _formData['name']?.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (nome) {
                    final name = nome ?? '';
                    if (name.trim().isEmpty) {
                      return 'Nome é Obrigatorio';
                    }
                    if (name.trim().length < 3) {
                      return 'Nome tem de ser maior que 3 letras ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['price'].toString(),
                  decoration: const InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                  validator: (preco) {
                    final priceString = preco ?? '';
                    final price = double.tryParse(priceString) ?? -1;

                    if (price <= 0) {
                      return 'Informe um preço valido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['description'].toString(),
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (descricao) =>
                      _formData['description'] = descricao ?? '',
                  validator: (detalhar) {
                    final descricao = detalhar ?? '';
                    if (descricao.trim().isEmpty) {
                      return 'Descricao é Obrigatorio';
                    }
                    if (descricao.trim().length < 10) {
                      return 'Descricao tem de ser maior que 10 letras ';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Url da Imagem'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        controller: _imageUrlController,
                        onSaved: (imageUrl) =>
                            _formData['imageUrl'] = imageUrl ?? '',
                        validator: (imagem) {
                          final imageUrl = imagem ?? '';
                          if (!isValidImageUrl(imageUrl)) {
                            return 'Informe uma Url valida';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Informe a Url')
                          : Image.network(_imageUrlController.text),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
