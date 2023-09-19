import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
// import 'package:odm_ui/controllers/menu_controller.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/chart.dart';
import 'package:odm_ui/widgets/storage_info_card.dart';

class ShoppingCartTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActionBar(
                    title: "Cart",
                    hasIcon: true,
                    hasTitle: true,
                    hasBackArrow: false,
                  ),
                  SizedBox(height: defaultPadding),
                  Chart(),
                  SizedBox(height: defaultPadding),
                ],
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Documents Files",
                amountOfFiles: "1.3GB",
                numOfFiles: 1328,
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/media.svg",
                title: "Media Files",
                amountOfFiles: "15.3GB",
                numOfFiles: 1328,
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/folder.svg",
                title: "Other Files",
                amountOfFiles: "1.3GB",
                numOfFiles: 1328,
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/unknown.svg",
                title: "Unknown",
                amountOfFiles: "1.3GB",
                numOfFiles: 140,
              ),
            ],
          ),
    );
  }
}
