import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'product.dart';

class ProductList extends StatefulWidget {
  final String title;

  ProductList({Key key, this.title}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildProductList(context),
      bottomNavigationBar: _buildTypeDropdown(context),
    );
  }

  Widget _buildTypeDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: DropdownButton(
        value: _selectedType,
        items: <String>['All', 'Storage', 'Graphics Card', 'Mobile Phone']
            .map<DropdownMenuItem>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_val) {
          setState(() {
            _selectedType = _val;
          });
        },
      ),
    );
  }

  Future<QuerySnapshot> getProducts() async {
    if (_selectedType == 'All') {
      return await FirebaseFirestore.instance.collection('products').get();
    } else {
      return await FirebaseFirestore.instance
          .collection('products')
          .where('type', isEqualTo: _selectedType)
          .get();
    }
  }

  Widget _buildProductList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data.docs
                .map((DocumentSnapshot document) =>
                    _buildProduct(context, document))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildProduct(BuildContext context, DocumentSnapshot productData) {
    final product =
        Product.fromMap(productData.data(), reference: productData.reference);
    return GestureDetector(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.type),
        trailing: Text(product.cost.toString()),
      ),
      onLongPress: () {
        setState(() {
          product.reference.delete();
        });
      },
    );
  }
}
