import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/product_viewer.dart';
import 'package:odm_ui/widgets/action_bar.dart';

import 'merchant_service_page.dart';

class ServiceProductsPage extends StatefulWidget {
  final Function onPressed;
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
          FutureBuilder(
            // get all selected documents from SelectedService
            future: _firebaseServices.usersRef.doc(
                _firebaseServices.getUserID()
            ).collection("SelectedService").orderBy("date", descending: true).get(),
            builder: (context, snapshot) {
              if( snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if(snapshot.connectionState == ConnectionState.done) {
                List _documents = snapshot.data.docs;
                
                // Collect Selected docs into array / ListView
                // display data in listview
                return ListView(
                  padding: EdgeInsets.only(
                    top: 110,
                    bottom: 20,
                  ),
                  children:  [
                    for(var i = 0; i < _documents.length; i++)
                      // seperate array into individual documents
                      ProductViewer(
                        isSelected: i == 0,
                        prodID: _documents[i]['srvc'],
                        prodName: _documents[i]['name'],
                        prodSrvcID: _documents[i]['srvcCtgryID'],
                        prodSrvcName: _documents[i]['srvcCtgry'],
                      )
                  ]
                );
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
