import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ProductWndw extends StatefulWidget {
  final String prodName;

  const ProductWndw({Key? key, required this.prodName}) : super(key: key);

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
      _width = _isSelected ? double.maxFinite : 100;
      _height = _isSelected ? 220 : 100;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () { _updateState(); print(" tapped on product ${_isSelected}"); },
        child: AnimatedContainer(
          duration: Duration(
              milliseconds: 400
          ),
          width: _width,
          height: _height,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent.withOpacity(0.6),
            border: Border.all(
                color: Colors.black38,
                width: 3,
                style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(8),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "${widget.prodName}".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Other"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}