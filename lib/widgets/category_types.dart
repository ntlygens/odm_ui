import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/screens/service_products_page.dart';
import 'package:odm_ui/services/firebase_services.dart';

class CategoryTypes extends StatefulWidget {
  final List categoryTypeList;
  final String serviceCategoryName;
  final String serviceCategoryID;
  final Function(String)? onSelected;
  CategoryTypes({
    required this.categoryTypeList,
    this.onSelected,
    required this.serviceCategoryName,
    required this.serviceCategoryID,
  });

  @override
  _CategoryTypesState createState() => _CategoryTypesState();
}

class _CategoryTypesState extends State<CategoryTypes> {
  int _isSelected = 0;
  String? _selectedProductName = "selected-product-name";
  String _selectedProductID = "selected-produc-id";
  String _selectedProductSrvcID = "selected-produc-service-id";
  String _selectedSrvcCtgryName = "selected-service-name";
  String _selectedSrvcCtgryID = "selected-service-id";

  FirebaseServices _firebaseServices = FirebaseServices();

  Future _selectServiceProduct() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .doc()
        .set({
          "prodName": _selectedProductName,
          "prodID": _selectedProductID,
          "srvcCtgry": _selectedSrvcCtgryName,
          "srvcCtgryID": _selectedSrvcCtgryID,
          "date": _firebaseServices.setDayAndTime(),
        })
        .then((_) {
          print("Name: ${_selectedProductName} | ID: ${_selectedProductID} Selected");
          _setProductIsSelected(_selectedProductID);
        });
  }

  Future _setProductIsSelected(value) async {
    return _firebaseServices.productsRef
        .doc(value)
        .update({"isSelected": true})
        .then((_) {
          // _selectServiceProduct();
          print("selection done");
        });
  }

  @override
  Widget build(BuildContext context) {
    // print("amt: ${widget.categoryTypeList.length}");
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.categoryTypeList.length,
          itemBuilder: (BuildContext ctx, index) {
            return StreamBuilder(
              stream: _firebaseServices.productsRef
                  .doc("${widget.categoryTypeList[index]}")
                  .snapshots(),
              builder: (context, AsyncSnapshot productSnap) {
                /*if(productSnap.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${productSnap.error}"),
                    ),
                  );
                }*/

                if(productSnap.connectionState == ConnectionState.active) {
                  // Map<String, dynamic> prodData = productSnap.data;
                  // bool _prodSelected = false;
                  // print("servProdsAmt: ${widget.categoryTypeList.length}");
                  // int _amt = 0;
                  if(productSnap.hasData) {
                    // print("ID: ${productSnap.data.id} \n Name: ${productSnap.data['name']}");
                    return GestureDetector(
                      onTap: () async {
                        _selectedProductName = await "${productSnap.data['name']}";
                        _selectedProductID = await "${productSnap.data.id}";
                        _selectedProductSrvcID = await "${productSnap.data['srvc']}";
                        _selectedSrvcCtgryName = widget.serviceCategoryName;
                        _selectedSrvcCtgryID = widget.serviceCategoryID;
                        // _prodSelected = true;

                        setState(() {
                          _isSelected = index;
                        });

                        // print("datentime: ${_firebaseServices.setDayAndTime()}");

                        await _selectServiceProduct();
                        // await _setProductIsSelected(_selectedProductID);

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              ServiceProductsPage(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            // "${widget.categoryTypeList[index]}",
                            "${productSnap.data['name']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: productSnap.data['isSelected']
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: productSnap.data['isSelected'] ? Theme
                              .of(context)
                              .accentColor : Color(0xFFDCDCDC),
                          borderRadius: BorderRadius.circular(8),
                        ),

                      ),
                    );
                  }

                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
