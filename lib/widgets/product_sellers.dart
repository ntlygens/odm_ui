import 'dart:convert';
import 'dart:html';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odm_ui/api/product_bloc.dart';
import 'package:odm_ui/models/product_seller_model.dart';

class ProductSellers extends StatefulWidget {
  final String prodName;
  final String? prodID;

  const ProductSellers({Key? key, required this.prodName, this.prodID});

  @override
  _ProductSellersState createState() => _ProductSellersState();
}

class _ProductSellersState extends State<ProductSellers> {
  FirebaseServices _firebaseServices = FirebaseServices();
  // Future<void> fetchLocalProductSellers() async {
  Future _fetchLocalProductSellers() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Retailers")
        .orderBy("name", descending: true)
        .get()
        .then((_) {
          print("sellers retrieved");
        });

    /*http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final List sList = body["results"];
      allProductSellers = sList.map((model) =>
          ProductSellerModel.fromJson(model)).toList();
      productBloc.productController.sink.add(allProductSellers);
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );*/
  }
  
  @override

  void initState() {
    _fetchLocalProductSellers();
    // fetchRemoteProductSellers();
    super.initState();
  }

  List<ProductSellerModel> allProductSellers = [];

  void productSearch(String searchQuery) {
    List<ProductSellerModel> searchResult = [];

    productBloc.productController.sink.add(searchResult);

    if(searchQuery.isEmpty) {
      productBloc.productController.sink.add(searchResult);
      return;
    }
    allProductSellers.forEach((seller) {
      if (seller.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
      seller.sellerID.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(seller);
      }
    });
    productBloc.productController.sink.add(allProductSellers);

  }

  Future<void> fetchRemoteProductSellers() async {
    final url = "";
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final List sList = body["results"];
      allProductSellers = sList.map((model) =>
          ProductSellerModel.fromJson(model)).toList();
      productBloc.productController.sink.add(allProductSellers);
    }
  }


  Widget build(BuildContext context) {
    return Container();
  }
}
