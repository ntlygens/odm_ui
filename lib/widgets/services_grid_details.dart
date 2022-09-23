import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/selected_service_page.dart';

class ServicesGridDetails extends StatefulWidget {
  const ServicesGridDetails({Key? key}) : super(key: key);

  @override
  State<ServicesGridDetails> createState() => _ServicesGridDetailsState();
}

class _ServicesGridDetailsState extends State<ServicesGridDetails> {
  late PageController _pageController;
  late String? _textVar;
  int _selectedPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    _textVar = "VnhXnkWdbvbZcSm7duYF";
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      alignment: Alignment.center,
      child: Text("serviceID: ${_textVar}")
      // child: SelectedServicePage(serviceID: "${_textVar}")
      // child: PageView(
      //   scrollDirection: Axis.horizontal,
      //   controller: _pageController,
      //   onPageChanged: (num) {
      //     setState(() {
      //       _selectedPage = num;
      //     });
      //   },
      //   children: [
      //     SelectedServicePage(serviceID: "${_textVar}"),
      //   ],
      // ),
    );
  }
}