import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/tabs/home_tab.dart';
import 'package:odm_ui/tabs/profile_tab.dart';
import 'package:odm_ui/tabs/search_tab.dart';
import 'package:odm_ui/tabs/shoppingcart_tab.dart';
import 'package:odm_ui/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    // print("userID: ${_firebaseServices.getUserID()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                  // print ("selected tab: ${_selectedTab}");
                },
                children: [
                  HomeTab(),
                  ProfileTab(),
                  SearchTab(),
                  ShoppingCartTab(),
                ],
              ),
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabClicked: (num) {
              _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic
              );
            },
          ),

        ],
      ),

    );
  }
}
