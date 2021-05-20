import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/product.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  EditProductScreen({this.productId});
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
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isLoading = false;
  @override
  void initState() {
    if (widget.productId != null) {
      _editedProduct = Provider.of<Products>(context, listen: false)
          .findById(widget.productId);

      _initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageUrl': '',
      };
      _imageEditingController.text = _editedProduct.imageUrl;
    }

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

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Something\'s wrong'),
                content: Text('Real Bad'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('OK'))
                ],
              );
            });
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  Widget giveImage(String url) {
    isValidImage = true;
    return FittedBox(
      child: Image.network(
        url,
        fit: BoxFit.fitHeight,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace stackTrace,
        ) {
          isValidImage = false;
          return Image.asset(
            'assets/images/error.jpg',
            fit: BoxFit.fitHeight,
          );
        },
      ),
    );
  }

  bool isValidImage = false;

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
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
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
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
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(value),
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a description';
                        }
                        if (value.length < 10) {
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
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
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
                              : giveImage(_imageEditingController.text),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initValues['imageUrl'],
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
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite);
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
                              // if (isValidImage == false) {
                              //   return 'Invalid URL';
                              // }
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
