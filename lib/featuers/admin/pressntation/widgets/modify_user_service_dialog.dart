  import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/data/models/user_info_model.dart';

import 'multi_drop_down_button_to_services.dart';

void showMultiSelectDialog({
  required BuildContext context,
  required UserInfoModel userInfoModel,
  required Function(List selectedServices) onEditServicesSelected,
}) async {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: kServices,
          initiallySelectedItems: userInfoModel.services,
          onPressed: (selectedServices) {
            onEditServicesSelected(selectedServices);
          },
        );
      },
    );
    // print('items is $selectedItems');
    // if (selectedItems != null) {
    //   // setState(() {
    //   //   _initSelectedItems = selectedItems;
    //   // });
    //   // widget.onServiceSelected(selectedItems);
    // }
  }
