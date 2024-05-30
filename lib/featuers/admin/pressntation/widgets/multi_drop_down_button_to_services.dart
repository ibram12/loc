import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_state.dart';

import '../../../../core/helper/dialog_with_textFiald.dart';
import '../../../../core/utils/constants.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown(
      {super.key,
      required this.items,
      required this.hint,
      required this.onServiceSelected, required this.onRoleSelected});

  final List<String> items;
  final String hint;
  final void Function(List<String>) onServiceSelected;
    final void Function(String) onRoleSelected;


  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  TextEditingController dilogController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  List<String> _initSelectedItems = [];
  String role = 'Role';
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
    print('items is $selectedItems');
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
                DropdownButton(
                        hint: Text(role),
                        items: kRoles
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                          widget.onRoleSelected(value!);
                        }),
              TextButton(
                child: const Text(
                  'Add New Service?',
                  style: Styles.textStyle14,
                ),
                onPressed: () {
                  showTextFieldDialog(
                    context, dilogController, () {
                    setState(() {
                      _initSelectedItems.add(dilogController.text);
                      widget.onServiceSelected(_initSelectedItems);
              
                      dilogController.clear();
                    });
                    Navigator.pop(context);
                  }, key, 'Enter Service Type', 'Service', 'Service Type',false);
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
  final List<String> items;
  final List<String> initiallySelectedItems;

  MultiSelectDialog(
      {required this.items, required this.initiallySelectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = widget.initiallySelectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Services'),
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
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, widget.initiallySelectedItems);
          },
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, _tempSelectedItems);
          },
        ),
      ],
    );
  }
}
