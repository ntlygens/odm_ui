import 'package:flutter/material.dart';
import 'package:odm_ui/screens/merchant_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';

class ProductViewer extends StatefulWidget {
  final String prodID;
  final String prodName;
  final String prodSrvcName;
  final String prodSrvcID;
  final bool isSelected;
  final Function onPressed;
  const ProductViewer({this.prodID, this.isSelected, this.prodName, this.prodSrvcName, this.onPressed, this.prodSrvcID});

  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _isSelected = widget.isSelected;
    return Column(
      children: [
        Container(
          // future: _firebaseServices.servicesRef.doc(document.id).get(),
          decoration: BoxDecoration(
            color: _isSelected ? Colors.amberAccent : Colors.blueGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          // height: _isSelected ? 300 : 55,
          height: _isSelected ? 300 : 55,
          // width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 24,
          ),
          child: Text(
            "${widget.prodName}",
            style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 0,
            right: 12,
            bottom: 36,
            left: 12
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MerchantServicePage(
                        serviceID: "${widget.prodSrvcID}",
                      )
              ));

            },
            child: Container(
              decoration: BoxDecoration(
                color: _isSelected ? Colors.amberAccent : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 45,
              // width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 48,
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
        )
      ],
    );
  }
}
