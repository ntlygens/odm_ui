import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({this.dText, this.onPressed, this.outlineBtn, this.isLoading});

  final String dText;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  dText ?? "Text Here",
                  // style: Constants.regHeading,
                  style: TextStyle(
                    fontSize: 16,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
