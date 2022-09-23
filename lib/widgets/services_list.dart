import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/responsive.dart';
import 'package:odm_ui/services/firebase_services.dart';

class ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // return Container(
    //   padding: EdgeInsets.all(defaultPadding),
    //   child: StreamBuilder<QuerySnapshot>(
    //     stream: _firebaseServices.servicesRef
    //       .orderBy("btnOrder", descending: false)
    //         .snapshots(),
    //     builder: (context, AsyncSnapshot snapshot){
    //       if(snapshot.hasError){
    //         return Scaffold(
    //           body: Center(
    //             child: Text("dError: ${snapshot.error}"),
    //           ),
    //         );
    //       }
    //
    //       if(snapshot.connectionState == ConnectionState.active){
    //         if(snapshot.hasData){
    //           // _srvcData = snapshot.data!.docs;
    //           setState(() {
    //             _srvcData = snapshot.data!.docs;
    //           });
    //
    //
    //           return Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "Services List",
    //                     style: Theme.of(context).textTheme.subtitle1,
    //                   ),
    //                   ElevatedButton.icon(
    //                     style: TextButton.styleFrom(
    //                       padding: EdgeInsets.symmetric(
    //                         horizontal: defaultPadding * 1.5,
    //                         vertical: defaultPadding
    //                       ),
    //                     ),
    //                     onPressed: () {},
    //                     icon: Icon(Icons.sixty_fps_select),
    //                     label: Text("Select One"),
    //                   )
    //                 ],
    //               ),
    //               SizedBox(height: defaultPadding),
    //               Responsive(
    //                   mobile: ServicesGridView(
    //                     crossAxisCount: _size.width < 650 ? 2 : 4,
    //                     childAspectRatio: _size.width < 650 ? 1.3 : 1,
    //                   ),
    //                   tablet: ServicesGridView(
    //                     childAspectRatio: _size.width < 850 ? 1.2 : 1,
    //                   ),
    //                   desktop: ServicesGridView(
    //                     childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
    //                   )
    //               )
    //             ],
    //           );
    //
    //
    //           // return Center(
    //           //   child: Text("amt: ${_srvcData.length}"),
    //           // );
    //         }
    //       }
    //
    //       /*return Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );*/
    //     },
    //   ),
    //
    // );
    return Column(
      children: [
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Services List",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: defaultPadding
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.sixty_fps_select),
              label: Text("Select One"),
            )
          ],
        ),
        SizedBox(height: defaultPadding),
        */
        Responsive(
            mobile: ServicesGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: ServicesGridView(
              childAspectRatio: _size.width < 850 ? 1.2 : 1,
            ),
            desktop: ServicesGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            )
        )
      ],
    );
  }
}

// Grid View stateless widget //
class ServicesGridView extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  ServicesGridView({
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,

  });

  final int crossAxisCount;
  final double childAspectRatio;

  late List _srvcData;
  late String? _textVar;
  late double maxAxisExtent;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultPadding),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseServices.servicesRef
                .orderBy("btnOrder", descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("dError: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  _srvcData = snapshot.data!.docs;
                  if(Responsive.isDesktop(context))
                    maxAxisExtent = 145;
                  if(Responsive.isTablet(context) && this.crossAxisCount == 3)
                    maxAxisExtent = 135;
                  if(Responsive.isMobile(context) && this.crossAxisCount == 4)
                    maxAxisExtent = 120;
                  if(Responsive.isMobile(context) && this.crossAxisCount == 3)
                    maxAxisExtent = 135;
                  if(Responsive.isMobile(context) && this.crossAxisCount == 2)
                    maxAxisExtent = 130;
                    print("axisCount: ${crossAxisCount}, maxAxis: ${maxAxisExtent}");
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: _srvcData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: childAspectRatio,
                      mainAxisExtent:  maxAxisExtent,

                    ),
                    // itemBuilder: (context, index) => _srvcData[index],
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("\nsNme: ${_srvcData[index]['name']}");
                          print("sId: ${_srvcData[index].id}" );
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
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
                              Text(
                                "${_srvcData[index]['name']}",
                                style: Constants.serviceLabels,
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
            }
        )
    );
  }
}



