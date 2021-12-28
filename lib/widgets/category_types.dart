import 'package:flutter/material.dart';

class CategoryTypes extends StatefulWidget {
  final List categoryTypeList;
  CategoryTypes({this.categoryTypeList});

  @override
  _CategoryTypesState createState() => _CategoryTypesState();
}

class _CategoryTypesState extends State<CategoryTypes> {
  int _isSelected = 0;

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
            return GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "${widget.categoryTypeList[index]}",
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
      ),
    );
  }
}
