import 'package:flutter/material.dart';
import 'package:shopon/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode =
      FocusNode(); // It is used to shift focus to next field when next button is pressed.
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageURLController =
      TextEditingController(); // To show a preview of the image before submitting the form.
  final _form = GlobalKey<
      FormState>(); // It is used to interact with widgets from inside the code and is mostly used by forms.
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageURL: "");
  var _isInit = true;
  var initValues = {"title": "", "price": "", "description": "", "imgeURL": ""};

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // This runs before build method.
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findItemById(productId);
        initValues = {
          "title": _editedProduct.title,
          "price": _editedProduct.price.toString(),
          "description": _editedProduct.description,
          "imageURL": "",
        };
        _imageURLController.text = _editedProduct.imageURL;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLController.dispose();
    _imageURLFocusNode.dispose();

    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    Provider.of<ProductsProvider>(context, listen: false)
        .addProducts(_editedProduct.id, _editedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Do you want to save this item?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text(
                          "NO",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _saveForm();

                          Navigator.of(ctx).pop(true);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar(); // It hides the current snackbar before showing new snackbar immediately.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Product saved!",
                            ),
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {},
                            ),
                          ));
                        },
                        child: Text(
                          "YES",
                          style: TextStyle(fontSize: 17),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form, // It connects the state of the form with the global key.
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: initValues["title"],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction
                    .next /* This will show a next option on the keyboard which on pressing will move the cursor to the next text field*/,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a title!";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: value as String,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageURL: _editedProduct.imageURL);
                },
              ),
              TextFormField(
                initialValue: initValues["price"],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a price!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid price!";
                  }
                  if (int.parse(value) <= 0) {
                    return "Please enter a price greater than 0!";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: int.parse(value!),
                      imageURL: _editedProduct.imageURL);
                },
              ),
              TextFormField(
                initialValue: initValues["description"],
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description!";
                  }
                  if (value.length < 10) {
                    return "Description should be at least 10 characters long!";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: value as String,
                      price: _editedProduct.price,
                      imageURL: _editedProduct.imageURL);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Image URL"),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageURLController,
                focusNode: _imageURLFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an image URL!";
                  }
                  if (!value.startsWith("http") && !value.startsWith("https")) {
                    return "Please enter a valid image URL!";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageURL: value as String);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 200,
                margin: EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: _imageURLController.text.isEmpty
                    ? Center(child: Text("Enter a URL"))
                    : FittedBox(
                        child: Image.network(_imageURLController.text),
                        fit: BoxFit.contain,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
