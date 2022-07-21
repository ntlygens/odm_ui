import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/screens/service_products_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/product_wndw.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  // HomeTab({});
  late List _srvcData;

  late String? _textVar;
  // var _textVar;
  Future _dsplySrvc(value) async {
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

  Future _getSelectedSrvc<String>() async {
    var _myVar = _firebaseServices.servicesRef
        .get()
        .then((value) => value.docs
        .forEach((element) {
            // var docRef = _firebaseServices.servicesRef
            //   .doc(element.id).snapshots();
            var docRef = element['isSelected'];

            if (docRef == true) {
              _textVar = element.id;
              print("${_textVar} is Selected");
            }

            // docRef.collection('sid');
            // docRef.update({'isSelected': true});

          },
        ))

        // .get();
        // .then((value) => value['type']);
        // .toString()
    ;

    print("thi is: ${_myVar}");
    return _textVar;
  }

  Future _dsplySelectedSrvc(value) async {
    return _firebaseServices.servicesRef
        .get()
        .then((value) => value.docs
          .forEach((element) {
            var docRef = _firebaseServices.servicesRef
                .doc(element.id);

                docRef.update({'isSelected': true});
            },
          ),
        );
  }

  @override
  void initState() {
    _textVar = "VnhXnkWdbvbZcSm7duYF";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseServices.servicesRef
                .orderBy("btnOrder", descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if( snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData){
                    _srvcData = snapshot.data!.docs;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 675,
                          height: 640,
                          padding: EdgeInsets.symmetric (
                            // 8,
                              vertical: 6,
                              horizontal: 8
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: GridView.builder(
                           shrinkWrap: true,
                           physics: ScrollPhysics() ,
                           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                               maxCrossAxisExtent: 300,
                               childAspectRatio: 2 / 1
                           ),
                           itemCount: _srvcData.length,
                           itemBuilder: (BuildContext context, int index) {
                             return GestureDetector(
                               onTap: () {
                                 print("eDOc: ${_srvcData[index]['name']} \n");
                                 print("eDOc2: ${_srvcData[index].id}");

                                 setState(() {
                                   _textVar = _srvcData[index].id;
                                 });
                               },
                               child: Card(
                                 elevation: 4,
                                 margin: EdgeInsets.symmetric(
                                   // 8
                                   vertical: 6,
                                   horizontal: 12,
                                 ),
                                 child: Stack(
                                   children: [
                                     Container(
                                       alignment: Alignment.center,
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(6),
                                         child: Image.network(
                                           "${_srvcData[index]['images'][0]}",
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                             );
                           },
                         )
                        ),
                        Container(
                          width: 700,
                          height: 640,
                          padding: EdgeInsets.all(
                            8,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 0
                          ),
                          child: SelectedServicePage(
                            serviceID: "${_textVar}",
                          ),

                          /*child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                  "${_textVar}",
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  border: Border(
                                    top: BorderSide(color: Colors.green),
                                    bottom: BorderSide(color: Colors.green),
                                  ),
                                ),
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "text here",
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                        )
                      ],
                    );
                  }
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              }
            ),
          ),

          // FutureBuilder<QuerySnapshot>(

          ActionBar(
            title: "Home Page",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
