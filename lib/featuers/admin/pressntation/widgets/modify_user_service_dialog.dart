import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/user_info_model.dart';

import 'multi_drop_down_button_to_services.dart';

void showMultiSelectDialog({
  required BuildContext context,
  required UserInfoModel userInfoModel,
  required Function(List selectedServices) onEditServicesSelected,
}) async {
  List<String> services = [
    'ملائكه',
    'خدمه ابتدائي بنين',
    'خدمه ابتدائي بنات',
    'خدمه اعدادي بنين',
    'خدمه اعدادي بنات',
    'خدمه ثانوي بنين',
    'خدمه ثانوي بنات',
    'جامعين',
    'رجاله',
    'حديثي الزواج',
    'كشافه',
  ];
  
  List allServices = [];

  Set prescribedElements = {
    'ملائكه',
    'خدمه ابتدائي بنين',
    'خدمه ابتدائي بنات',
    'خدمه اعدادي بنين',
    'خدمه اعدادي بنات',
    'خدمه ثانوي بنين',
    'خدمه ثانوي بنات',
    'جامعين',
    'رجاله',
    'حديثي الزواج',
    'كشافه',
  };

  allServices.addAll(services);

  allServices.addAll(userInfoModel.services.where((service) => !prescribedElements.contains(service)));

  showDialog(
    context: context,
    builder: (BuildContext context) {

      return MultiSelectDialog(
        items: allServices,
        initiallySelectedItems: userInfoModel.services,
        onPressed: (selectedServices) {
          onEditServicesSelected(selectedServices);
        },
      );
    },
  );

}
