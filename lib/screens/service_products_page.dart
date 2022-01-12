import 'package:flutter/material.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/product_viewer.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ServiceProductsPage extends StatefulWidget {
  final Function? onPressed;
  ServiceProductsPage({this.onPressed});

  @override
  _ServiceProductsPageState createState() => _ServiceProductsPageState();
}

class _ServiceProductsPageState extends State<ServiceProductsPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            // get all selected documents from SelectedService
            stream: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserID())
                .collection("SelectedService")
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              /*if( snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }*/

              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData){
                    List _prodData = snapshot.data.docs;
                    // print("prodID: ${_prodData[0].id}");
                    // Collect Selected docs into array / ListView
                    // display data in listview
                    return ListView(
                        padding: EdgeInsets.only(
                          top: 110,
                          bottom: 20,
                        ),
                        children: [
                          // children: _prodData.map((prodData, index) =>
                          for (var i = 0; i < _prodData.length; i++)
                            // seperate array into individual documents
                            ProductViewer(
                              isSelected: i == 0,
                              prodID: _prodData[i]['prodID'],
                              prodName: _prodData[i]['prodName'],
                              prodSrvcID: _prodData[i]['srvcCtgryID'],
                              prodSrvcName: _prodData[i]['srvcCtgry'],
                              srvcProdID: _prodData[i].id,
                            )
                        ]);
                  }
                }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          ),
          ActionBar(
            title: "Service Products",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
