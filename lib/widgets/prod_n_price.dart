import 'package:flutter/material.dart';

class ProdNPrice extends StatefulWidget {
  final String prodName;
  final List? altProds;
  ProdNPrice({this.altProds, required this.prodName});

  @override
  _ProdNPriceState createState() => _ProdNPriceState();
}

class _ProdNPriceState extends State<ProdNPrice> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    print("lg: ${widget.altProds!.length}");
    return Container(
      alignment: Alignment.topCenter,
      height: 300,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// selected product NAME
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border(
                top: BorderSide(color: Colors.green),
                bottom: BorderSide(color: Colors.green),
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: 100,
                right: 48,
                bottom: 0,
                left: 48
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "${widget.prodName}",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),

          /// product alternatives
          Container(
            padding: EdgeInsets.only(top: 18, right: 0, bottom: 0, left: 0),
            margin: EdgeInsets.symmetric(horizontal: 48),
            decoration: BoxDecoration(
              // color: Colors.transparent
              color: Color(0x345A5A5A)
            ),
            height: 80,
            // width: ,
            child: Stack(
              fit: StackFit.loose,
              children: [
                PageView(
                    onPageChanged: (num) {
                      setState(() {
                        _selectedPage = num;
                        print("lgn: ${widget.altProds![num]}");
                      });
                    },
                    children: [
                      for(var i = 0; i < widget.altProds!.length; i++)
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 0
                          ),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "${widget.altProds![i]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        )
                    ]

                ),
                Positioned(
                  top: 16,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(var i = 0; i < widget.altProds!.length; i++)
                        AnimatedContainer(
                          duration: Duration(
                              milliseconds: 300
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 6
                          ),
                          width: _selectedPage == i ? 36 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12)
                          ),

                        )
                    ],

                  ),
                )
              ],

            ),
          ),

          /// product price result
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                // top: BorderSide(color: Colors.green),
                // bottom: BorderSide(color: Colors.green),
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: 10,
                // right: 110,
                // bottom: 0,
                // left: 110
            ),
            child: Text(
              "~~   \$12.90   ~~",
              // "${widget.prodName}",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFFF1E80),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
