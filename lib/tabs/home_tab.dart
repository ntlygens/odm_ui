import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/product_wndw.dart';

class HomeTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  // HomeTab({});
  late List _srvcData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 675,
                  height: 600,
                  padding: EdgeInsets.symmetric(
                      // 8,
                    vertical: 16,
                    horizontal: 8
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: FutureBuilder<QuerySnapshot>(
                    future: _firebaseServices.servicesRef
                      .get(),
                    builder: (context, acctSrvcSnap) {
                      int _totalItems = 0;
                      if (acctSrvcSnap.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error: ${acctSrvcSnap.error}"),
                          ),
                        );
                      }

                      // collection data to display
                      if(acctSrvcSnap.connectionState == ConnectionState.done) {
                        // display data in listview
                        if (acctSrvcSnap.hasData) {
                          List _srvcData = acctSrvcSnap.data!.docs;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics() ,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 325,
                                childAspectRatio: 2 / 1
                            ),
                            itemCount: _srvcData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  // print("eDOc: ${_srvcData[index]['name']}");
                                  Navigator.push(context, MaterialPageRoute(
                                      builder:
                                          (BuildContext context) {
                                            return Container(
                                              child: SelectedServicePage(
                                                  serviceID: _srvcData[index].id
                                              ),
                                            );

                                          }

                                  ));
                                },
                                child: Card(
                                  elevation: 3,
                                  margin: EdgeInsets.symmetric(
                                    // 8
                                    vertical: 8,
                                    horizontal: 10,
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
                          );

                        }

                      }

                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10
                  ),
                  child: Column(
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
                          "text goes here",
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
                  ),
                )
              ],
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
