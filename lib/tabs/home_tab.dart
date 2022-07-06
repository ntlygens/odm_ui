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
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFDCDCEF),
                    borderRadius: BorderRadius.circular(12)
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
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1 / 1
                            ),
                            itemCount: _srvcData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  print("eDOc: ${_srvcData[index]['name']}");
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          SelectedServicePage(
                                              serviceID: _srvcData[index].id
                                          )
                                  ));
                                },
                                child: Card(
                                  elevation: 3,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.network(
                                            "${_srvcData[index]['images'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16,
                                        left: 20,
                                        child: Text(
                                              _srvcData[index]['name'],
                                              style: Constants.regHeading,
                                            ),

                                        ),
                                    ],
                                  ),
                                ),

                              );
                            },
                          );
                          
                          
                          // acctSrvcSnap.data!.docs.map((eDoc) {
                          //   // print ("${eDoc['name'] + 'edoc' }" );
                          //  
                          // });
                          // print ("srvc: ${acctSrvcSnap.data['name']}");
                          // _totalItems = _srvcData.length;
                          // print ("$_totalItems & ${_srvcData[1]['name']}");

                          /*return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1 / 1,
                                // mainAxisSpacing: 0
                              ),
                              itemCount: _srvcData.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return StreamBuilder(
                                  stream: _firebaseServices.sellersRef
                                      .doc()
                                  // .doc("${_srvcData[index].id}")
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot srvcsSnap) {

                                    if(srvcsSnap.connectionState == ConnectionState.active) {
                                      if(srvcsSnap.hasData) {
                                        // print("ID: ${srvcsSnap.data.id} \n Name: ${srvcsSnap.data['name']}");
                                        // print("ID: ${srvcsSnap.data!.id}");
                                        print("ID: ${_srvcData[index]['name'] }");

                                        return ProductWndw(
                                          sellerID: "${_srvcData[index].id}",
                                          sellerName: "${_srvcData[index]['name']}",
                                          sellerLogo: "${_srvcData[index]['images'][0]}",
                                          prodID: "${_srvcData[index].id}",
                                          prodName: "${_srvcData[index]['name']}",
                                          isSelected: true,
                                        );

                                        // print ("srvc: ${srvcsSnap}");

                                        // return SelectedServicePage(serviceID: srvcsSnap.data!.id);


                                        // return Center(
                                        //   child: Text(
                                        //     "${srvcsSnap.data!.id}",
                                        //     style: TextStyle(
                                        //       fontSize: 16,
                                        //       fontWeight: FontWeight.w600,
                                        //       color: Colors.black,
                                        //     ),
                                        //
                                        //   ),
                                        // );

                                      }

                                    }

                                    return Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                );
                              }
                          );*/

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
