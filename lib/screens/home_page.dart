import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odm_ui/tabs/home_tab.dart';
import 'package:odm_ui/tabs/profile_tab.dart';
import 'package:odm_ui/tabs/search_tab.dart';
import 'package:odm_ui/tabs/shoppingcart_tab.dart';
import 'package:odm_ui/widgets/bottom_tabs.dart';

import 'side_menu.dart';
import 'package:odm_ui/controllers/menu_controller.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/responsive.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
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
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(child: SideMenu()),
            Expanded(
                flex: 5,
                child: Container(
                  child: PageView(
                    controller: _tabsPageController,
                    onPageChanged: (num) {
                      setState(() {
                        _selectedTab = num;
                      });
                    },
                    children: [
                      HomeTab(),
                      ProfileTab(),
                      SearchTab(),
                      // ShoppingCartTab(),
                    ],
                  ),
                )
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
          ]
        ),
      ),
      /*body: Column (
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
      ),*/

    );
  }
}
