import 'package:flutter/material.dart';
import 'package:odm_ui/screens/service_products_page.dart';
import 'package:odm_ui/services/firebase_services.dart';

class CategoryTypes extends StatefulWidget {
  final List categoryTypeList;
  final String serviceCategoryName;
  final String serviceCategoryID;
  final Function(String) onSelected;
  CategoryTypes({this.categoryTypeList, this.onSelected, this.serviceCategoryName, this.serviceCategoryID});

  @override
  _CategoryTypesState createState() => _CategoryTypesState();
}

class _CategoryTypesState extends State<CategoryTypes> {
  int _isSelected = 0;
  String _selectedProductName = "selected-product-name";
  String _selectedProductID = "selected-produc-idt";
  String _selectedSrvcCtgryName = "selected-service-name";
  String _selectedSrvcCtgryID = "selected-service-id";

  FirebaseServices _firebaseServices = FirebaseServices();

  Future _selectedServiceProduct() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .doc()
        .set({
          "name": _selectedProductName,
          "srvc": _selectedProductID,
          "srvcCtgry": _selectedSrvcCtgryName,
          "srvcCtgryID": _selectedSrvcCtgryID,
        });
  }

  @override
  Widget build(BuildContext context) {
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
            return FutureBuilder(
              future: _firebaseServices.productsRef.doc(widget.categoryTypeList[index]).get(),
              builder: (context, productSnap) {
                if(productSnap.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${productSnap.error}"),
                    ),
                  );
                }

                if(productSnap.connectionState == ConnectionState.done) {
                  Map<String, dynamic> prodData = productSnap.data.data();
                  int _amt = 0;

                  return GestureDetector(
                    onTap: () async {
                      _selectedProductName = "${prodData['name']}";
                      _selectedProductID = "${productSnap.data.id}";
                      _selectedSrvcCtgryName = widget.serviceCategoryName;
                      _selectedSrvcCtgryID = widget.serviceCategoryID;

                      setState(() {
                        // _isSelected = index;
                      });
                      await _selectedServiceProduct();

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
                          "${prodData['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _isSelected == index ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: _isSelected == index ? Theme.of(context).accentColor : Color(0xFFDCDCDC),
                        borderRadius: BorderRadius.circular(8),
                      ),

                    ),
                  );

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
