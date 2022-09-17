import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/controllers/menu_controller.dart';
import 'package:odm_ui/responsive.dart';
import 'package:odm_ui/screens/header.dart';
import 'package:odm_ui/screens/service_products_page.dart';
import 'package:odm_ui/screens/side_menu.dart';
import 'package:odm_ui/tabs/home_tab.dart';
import 'package:odm_ui/tabs/profile_tab.dart';
import 'package:odm_ui/tabs/search_tab.dart';
import 'package:odm_ui/tabs/shoppingcart_tab.dart';
import 'package:provider/src/provider.dart';
import 'package:odm_ui/widgets/bottom_tabs.dart';

class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
  const DashboardScreen({Key? key}) :
    super(key: key);
}

class _DashboardScreenState extends State<DashboardScreen>{
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                // SearchTab(),
                                // ORIGINAL
                                // if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                // if (Responsive.isMobile(context))
                                  /*Expanded(
                                    flex: 5,
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
                                      ],
                                    ),
                                  ),*/
                                  BottomTabs(
                                      selectedTab: _selectedTab,
                                        tabClicked: (num) {
                                          _tabsPageController.animateToPage(
                                              num,
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOutCubic
                                          );
                                        }
                                  ),
                                if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                if (Responsive.isMobile(context))
                                  ShoppingCartTab(),
                              ],
                            ),

                        ),
                        if (!Responsive.isMobile(context))
                          SizedBox(width: defaultPadding),
                          // Expanded(
                          //     flex: 5,
                          //     child: PageView(
                          //       controller: _tabsPageController,
                          //       onPageChanged: (num) {
                          //         setState(() {
                          //           _selectedTab = num;
                          //         });
                          //       },
                          //       children: [
                          //         HomeTab(),
                          //         ProfileTab(),
                          //         SearchTab(),
                          //       ],
                          //     ),
                          //   ),
                          /*BottomTabs(
                              selectedTab: _selectedTab,
                              tabClicked: (num) {
                                _tabsPageController.animateToPage(
                                    num,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic
                                );
                              }
                          ),*/
                          // SizedBox(width: defaultPadding),
                          if (!Responsive.isMobile(context))
                            Expanded(
                              flex: 2,
                              child: ShoppingCartTab(),
                            ),

                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
