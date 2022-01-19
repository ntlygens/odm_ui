import 'package:flutter/material.dart';

class ProductWndw extends StatefulWidget {
  final String sellerID;
  final String? sellerName;
  final String? sellerLogo;
  final String? prodQty;
  final String? prodID;
  final String? prodName;
  final bool isSelected;
  final List? prodSeller;

  const ProductWndw({Key? key, required this.prodName, this.prodSeller, required this.prodID, required this.isSelected, required this.sellerID, this.sellerName, this.sellerLogo, this.prodQty});

  @override
  _ProductWndwState createState() => _ProductWndwState();
}

class _ProductWndwState extends State<ProductWndw> {
  double _width = 100;
  double _height = 100;
  bool _isSelected = false;

  _updateState() {
    // _isSelected = true;
    setState(() {
      _isSelected = !_isSelected;
      _width = _isSelected ? 300 : 100;
      _height = _isSelected ? 220 : 100;
      // print("updated ${_isSelected}");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.loose,
      children: [
        /// seller logo
        Container(
        width: 80,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.isSelected
                  ? NetworkImage("${widget.sellerLogo}")
                  : NetworkImage("uri"),
              fit: BoxFit.contain
          ),
        ),
      ),

        /// animated container
        Container(
          child: GestureDetector(
            onTap: () { _updateState(); print(" tapped on ${widget.sellerName} = ${_isSelected}"); },
            child: AnimatedContainer(
              duration: Duration(
                  milliseconds: 400
              ),
              width: _width,
              height: _height,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? Colors.transparent
                    // ? Theme.of(context).accentColor
                    : Color(0xFFDCDCDC),
                border: Border.all(
                    color: Colors.black38,
                    width: 3,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(8),
              ),

            ),
          ),
        ),

        /// nonSelected seller
        Container(
          padding: EdgeInsets.only(bottom: 20),
          // margin: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          child: Text(
            // "${widget.categoryTypeList[index]}",
            widget.isSelected
                ? ""
                : "${widget.sellerName}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.isSelected
                  ? Colors.white
                  : Colors.black,
              fontSize: 16,
            ),
          ),
          /*decoration: BoxDecoration(
            color: widget.isSelected ? Theme
                .of(context)
                .accentColor : Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(4),
          ),*/

        ),
      ],
    );
  }
}
