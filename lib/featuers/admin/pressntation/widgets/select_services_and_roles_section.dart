import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_state.dart';

import '../../../../core/helper/dialog_with_textFiald.dart';
import '../../../../core/server/shered_pref_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';

class SelectRoleAndServiceSection extends StatefulWidget {
  const SelectRoleAndServiceSection(
      {super.key,
      required this.items,
      required this.hint,
      required this.onServiceSelected,
      required this.onRoleSelected});

  final List<String> items;
  final String hint;
  final void Function(List<String>) onServiceSelected;
  final void Function(String) onRoleSelected;

  @override
  _SelectRoleAndServiceSectionState createState() => _SelectRoleAndServiceSectionState();
}

class _SelectRoleAndServiceSectionState extends State<SelectRoleAndServiceSection> {
  TextEditingController dilogController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  List<String> _initSelectedItems = [];
  String role = 'Role';
  String? userRole;
  bool isRoleLoading = true;

  void checkRole() async {
    userRole = await SherdPrefHelper().getUserRole();
    if (userRole != null) {
      setState(() {
        isRoleLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dilogController.dispose();
  }

  void _showMultiSelectDialog() async {
    List<String>? selectedItems = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: widget.items,
          initiallySelectedItems: _initSelectedItems,
        );
      },
    );
    if (selectedItems != null) {
      setState(() {
        _initSelectedItems = selectedItems;
      });
      widget.onServiceSelected(selectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is AdminBackToHisAccount) {
          _initSelectedItems.clear();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: _showMultiSelectDialog,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _initSelectedItems.isNotEmpty
                          ? _initSelectedItems.join(', ')
                          : widget.hint,
                      style: Styles.textStyle16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isRoleLoading
                  ? const CupertinoActivityIndicator(
                      color: kPrimaryColor,
                    )
                  :userRole == kRoles[2]? DropdownButton(
                      hint: Text(role),
                      items:  kRoles
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value!;
                        });
                        widget.onRoleSelected(value!);
                      }):DropdownButton(
                      hint: Text(role),
                      items:  [kRoles[0]]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value!;
                        });
                        widget.onRoleSelected(value!);
                      }),
              TextButton(
                child: Text(
                  S.of(context).add_New_Service,
                  style: Styles.textStyle14,
                ),
                onPressed: () {
                  showTextFieldDialog(context, dilogController, () {
                    setState(() {
                      _initSelectedItems.add(dilogController.text);
                      widget.onServiceSelected(_initSelectedItems);

                      dilogController.clear();
                    });
                    Navigator.pop(context);
                  }, key, S.of(context).enter_service_type,
                      S.of(context).service, S.of(context).service_type, false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<dynamic> items;
  final List<dynamic> initiallySelectedItems;
  final void Function(List)? onPressed;
  const MultiSelectDialog(
      {super.key,
      required this.items,
      required this.initiallySelectedItems,
      this.onPressed});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<dynamic> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = widget.initiallySelectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(S.of(context).select_services),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item),
              value: _tempSelectedItems.contains(item),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _tempSelectedItems.add(item);
                  } else {
                    _tempSelectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child:  Text(S.of(context).cancel),
          onPressed: () {
            Navigator.pop(context, widget.initiallySelectedItems);
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed!(_tempSelectedItems);
            } else {
              Navigator.pop(context, _tempSelectedItems);
            }
          },
          child:  Text(S.of(context).ok),
        ),
      ],
    );
  }
}
