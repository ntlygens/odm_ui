import 'package:flutter/material.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/custom_btn.dart';

class ProductViewer extends StatefulWidget {
  final String? prodID;
  final String? prodName;
  final String? prodSrvcName;
  final String? prodSrvcID;
  final bool? isSelected;
  final Function? onPressed;
  const ProductViewer({this.prodID, this.isSelected, this.prodName, this.prodSrvcName, this.onPressed, this.prodSrvcID});

  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _isSelected = widget.isSelected ?? false;
    return Column(
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
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 24,
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
            // width: double.infinity,
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
            bottom: _isSelected ? 80 : 24,
            left: _isSelected ? 12 : 24,
          ),
          child: CustomBtn(
            dText: "Remove",
            outlineBtn: false,
            onPressed: () {print("clicked the Remove Btn");},
          ),
        )
      ],
    );
  }
}
