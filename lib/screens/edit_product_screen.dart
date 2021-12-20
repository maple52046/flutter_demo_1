import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/constant.dart' as constant;
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/providers/products.dart';

bool isValidatedUrl(String url) {
  RegExp exp = RegExp(r'^(https?|ftp):\/\/[\w/\-?=%.]+\.[\w/\-?=%.]+');
  var result = exp.firstMatch(url);
  var isValidated = result != null;
  if (isValidated) {
    print('validated url: ${result!.group(0)}');
  }
  return isValidated;
}

String? validateImageUrl(String? value) {
  if (value!.isEmpty) {
    return 'Please enter an image url';
  }
  /***
    The simply way to check url is using startsWith and endsWith.
    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      return 'Please enter a valid http url';
    }
  ***/
  if (!isValidatedUrl(value)) {
    return 'Please enter a valid http url';
  }
  return null;
}

String? validatePrice(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a price';
  }
  final val = double.tryParse(value);
  if (val == null) {
    return 'Please enter a valid number';
  }
  if (val <= 0) {
    return 'Price must greater than zero';
  }
  return null;
}

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/products/edit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product? _editedProduct;
  var _initValues = {
    'title': '',
    'description': '',
    'price': 0,
  };
  var _isInit = true;
  var _isLoading = false;
  var _isValidated = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedProduct = ModalRoute.of(context)!.settings.arguments as Product;
      if (_editedProduct != null) {
        _imageUrlController.text = _editedProduct!.imgUrl;
        _initValues = {
          'title': _editedProduct!.title,
          'description': _editedProduct!.description,
          'price': _editedProduct!.price,
        };
      }
      _isInit = true;
    }

    super.didChangeDependencies();
  }

  void _saveForm() {
    _isValidated = _form.currentState!.validate();
    if (_isValidated) {
      _form.currentState!.save();
    }
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      return;
    }
    if (!isValidatedUrl(_imageUrlController.text)) {
      return;
    }
    setState(() {});
  }

  void _updateProducts() async {
    if (!_isValidated) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct!.id == '') {
      await Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct as Product)
          .catchError((err) => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('Failed to add product!'),
                    content: Text(err.toString()),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  )))
          .then((_) => setState(() {
                _isLoading = false;
                Navigator.of(context).pop();
              }));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _updateProducts)
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'] as String,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct!.id,
                          title: value as String,
                          imgUrl: _editedProduct!.imgUrl,
                          price: _editedProduct!.price,
                          description: _editedProduct!.description,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'].toString(),
                      decoration: const InputDecoration(labelText: 'Price'),
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct!.id,
                          title: _editedProduct!.title,
                          imgUrl: _editedProduct!.imgUrl,
                          price: double.parse(value as String),
                          description: _editedProduct!.description,
                        );
                      },
                      validator: validatePrice,
                    ),
                    TextFormField(
                      initialValue: _initValues['description'] as String,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct!.id,
                          title: _editedProduct!.title,
                          imgUrl: _editedProduct!.imgUrl,
                          price: _editedProduct!.price,
                          description: value as String,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: constant.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Center(child: const Text('Enter URL'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            focusNode: _imageUrlFocusNode,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct!.id,
                                title: _editedProduct!.title,
                                imgUrl: value as String,
                                price: _editedProduct!.price,
                                description: _editedProduct!.description,
                              );
                            },
                            validator: validateImageUrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
