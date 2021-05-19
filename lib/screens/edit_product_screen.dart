import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //bool switchVal = true;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0.0,
    imageUrl: '',
    description: '',
  );
  @override
  void initState() {
    // TODO: implement initState
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if ((!_imageEditingController.text.startsWith('http') &&
              !_imageEditingController.text.startsWith('https')) ||
          (!_imageEditingController.text.endsWith('.png') &&
              !_imageEditingController.text.endsWith('.jpg') &&
              !_imageEditingController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageEditingController.dispose();
    _imageURLFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(_editedProduct.title);
  }

  // Image giveImage(String url){
  //   try{
  //      return Image.network(
  //         url,
  //         fit: BoxFit.fitHeight,
  //       );
  //
  //   }catch(e){
  //     return Image.asset('assets/images/placeholder.jpg');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: value,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: null,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Amount should be grater than 0';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on_rounded),
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                maxLength: 10,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: double.parse(value),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a description';
                  }
                  if (value.length > 10) {
                    return 'At least 10 characters needed';
                  }
                  return null;
                },
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                //textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: _imageEditingController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageEditingController.text,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageEditingController,
                      focusNode: _imageURLFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value,
                          id: null,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Image does not exist';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // Switch(
              //     value: switchVal,
              //     activeThumbImage: AssetImage('assets/images/placeholder.png'),
              //     onChanged: (bool value) {
              //       setState(() {
              //         if (value) {
              //           switchVal = true;
              //         } else {
              //           switchVal = false;
              //         }
              //       });
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
