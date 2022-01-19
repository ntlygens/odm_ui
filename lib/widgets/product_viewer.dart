import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/custom_btn.dart';
import 'package:odm_ui/widgets/product_wndw.dart';

class ProductViewer extends StatefulWidget {
  final String? prodID;
  final String? prodName;
  final String? prodSrvcName;
  final String? prodSrvcID;
  final String srvcProdID;
  final bool? isSelected;
  final List? prodSellers;
  const ProductViewer({
    this.prodID,
    this.isSelected,
    this.prodName,
    this.prodSrvcName,
    this.prodSrvcID,
    required this.srvcProdID,
    this.prodSellers
  });

  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future _removeServiceProduct(value) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .doc(value)
        .delete()
        .then((_) {
          print("product ${value} removed");
          // _refreshServiceProduct();
        });
  }

  Future _resetProductIsSelected(value) async {
    return _firebaseServices.productsRef
        .doc(value)
        .update({"isSelected" : false})
        .then((_) {
          print("product ${value} UnSelected");
          // _refreshServiceProduct;
          _removeServiceProduct(widget.srvcProdID);
        });
  }

  Future _refreshServiceProduct() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .orderBy("date", descending: true)
        .get()
        .then((_) {
          print("list refreshed");
        });

  }

  Future _getProductSellers() async {
    return _firebaseServices.productsRef
        .doc(widget.prodID)
        .snapshots();
        // .get();
        // .then((_) {
        //   print("product sellers list");
        // });

  }


  @override
  Widget build(BuildContext context) {
    bool _isSelected = widget.isSelected ?? false;
    return Column(
      children: [
        if(_isSelected)
          Container(
            height: 400,
            margin: EdgeInsets.only(top: 110),
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
              // future: _getProductSellers(),
              future:_firebaseServices.productsRef
              .doc(widget.prodID)
              .get(),
              builder: (context, AsyncSnapshot prodSellerSnap) {
                if (prodSellerSnap.hasError){
                  return Container(
                    child: Text("ERROR: ${prodSellerSnap.error}"),
                  );
                }

                if(prodSellerSnap.connectionState == ConnectionState.done) {
                  if(prodSellerSnap.hasData) {
                    List _sellerData = prodSellerSnap.data['seller'];
                    print("product: ${prodSellerSnap.data.id}");
                    print("sellers: ${prodSellerSnap.data['seller']}");
                    // print("sellers: ${_sellerData.length}");
                    return ListView.builder(
                      itemCount: _sellerData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          width: 250,
                          child: Text("Seller: ${_sellerData[index]}"),
                        );
                      });
                  }

                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),

            /*child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getProductSellers(widget.prodID);
                *//*ProductWndw(
                  prodName: "${widget.prodName}",
                  prodID: "${widget.prodID}",
                ),
                ProductWndw(
                  prodID: "${widget.prodID}",
                  prodName: "${widget.prodName}"
                ),*//*
                *//*Container(
                  // future: _firebaseServices.servicesRef.doc(document.id).get(),
                  decoration: BoxDecoration(
                    color: _isSelected ? Theme.of(context).colorScheme.secondary : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // height: _isSelected ? 300 : 55,
                  height: _isSelected ? 350 : 65,
                  // width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 20,
                    right: 14,
                    bottom: 24,
                    left: 14,
                  ),
                  child: Text(
                    "${widget.prodName}",
                    style: TextStyle(
                        color: _isSelected ? Colors.black : Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),*//*


                /// Original Below ///
                *//*Container(
                  // future: _firebaseServices.servicesRef.doc(document.id).get(),
                  decoration: BoxDecoration(
                    color: _isSelected ? Theme.of(context).colorScheme.secondary : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // height: _isSelected ? 300 : 55,
                  height: _isSelected ? 350 : 65,
                  // width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 20,
                    right: 14,
                    bottom: 24,
                    left: 14,
                  ),
                  child: Text(
                    "${widget.prodName}",
                    style: TextStyle(
                        color: _isSelected ? Colors.black : Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),*//*
                /// Original Above ///
                ///
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            SelectedServicePage(
                              serviceID: "${widget.prodSrvcID}",
                            )
                    ));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isSelected ? Colors.amberAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: _isSelected ? 55 : 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: _isSelected ? 6 : 0,
                      horizontal: _isSelected ? 24 : 48,
                    ),
                    child: Text(
                      "${widget.prodSrvcName}",
                      style: TextStyle(
                          color: _isSelected ? Colors.white : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                // ** Temporarily removed to test button not being unselected
                *//*Container(
                  height: _isSelected ? 65 : 50,
                  margin: EdgeInsets.only(
                    right: _isSelected ? 12 : 24,
                    bottom: _isSelected ? 24 : 14,
                    left: _isSelected ? 12 : 24,
                  ),
                  child: CustomBtn(
                    dText: "Remove",
                    outlineBtn: false,
                    onPressed: () {
                      // print("Removed: ${widget.prodName}");
                      _removeServiceProduct(widget.srvcProdID);

                    },
                  ),
                )*//*
                // ** Above temporarily removed
              ],
            ),*/
          )
        else
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // future: _firebaseServices.servicesRef.doc(document.id).get(),
                  decoration: BoxDecoration(
                    color: _isSelected ? Colors.amberAccent : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // height: _isSelected ? 300 : 55,
                  height: _isSelected ? 350 : 65,
                  // width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 20,
                    right: 14,
                    bottom: 24,
                    left: 14,
                  ),
                  child: Text(
                    "${widget.prodName}",
                    style: TextStyle(
                        color: _isSelected ? Colors.black : Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            SelectedServicePage(
                              serviceID: "${widget.prodSrvcID}",
                            )
                    ));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isSelected ? Colors.amberAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: _isSelected ? 55 : 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: _isSelected ? 6 : 0,
                      horizontal: _isSelected ? 24 : 48,
                    ),
                    child: Text(
                      "${widget.prodSrvcName}",
                      style: TextStyle(
                          color: _isSelected ? Colors.white : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _isSelected ? 65 : 50,
                  margin: EdgeInsets.only(
                    right: _isSelected ? 12 : 24,
                    bottom: _isSelected ? 24 : 14,
                    left: _isSelected ? 12 : 24,
                  ),
                  child: CustomBtn(
                    dText: "Remove",
                    outlineBtn: false,
                    onPressed: () {
                      _resetProductIsSelected(widget.prodID);
                      // print("Remove doc: ${widget.prodID}");
                      // _removeServiceProduct(widget.srvcProdID);

                    },
                  ),
                )
              ],
            ),
          )

      ],
    );
  }
}
