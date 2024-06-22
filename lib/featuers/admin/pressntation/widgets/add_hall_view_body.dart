import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/featuers/admin/pressntation/manager/add_hall_cubit/add_hall_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/Custom_image_contaner.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/widgets/Custom_TextField.dart';
import '../../../../generated/l10n.dart';

class AddHallViewBody extends StatefulWidget {
  const AddHallViewBody({super.key});

  @override
  State<AddHallViewBody> createState() => _AddHallViewBodyState();
}

class _AddHallViewBodyState extends State<AddHallViewBody> {
  late TextEditingController location;
  late TextEditingController floor;
  GlobalKey<FormState> key = GlobalKey();
  File packedImage = File('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = TextEditingController();
    floor = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    location.dispose();
    floor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHallCubit, AddHallState>(
      builder: (context, state) {
        if (state is AddHallSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, S.of(context).hall_added_successfully);
          });
          location.clear();
          floor.clear();
        } else if (state is AddHallError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, S.of(context).something_went_wrong_please_try_later);
          });
        }
        return ModalProgressHUD(
          inAsyncCall: state is AddHallLoading,
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageContaner(
                  onSelected: (value) {
                     packedImage = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          onSaved: (value) {
                            location.text = value!;
                          },
                          hinttext: S.of(context).name_loc,
                          textEditingController: location,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomTextField(
                          onSaved: (value) {
                            floor.text = value!;
                          },
                          hinttext: S.of(context).floor,
                          textEditingController: floor,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate() &&
                          packedImage != File('')) {
                        await BlocProvider.of<AddHallCubit>(context)
                            .addHall(floor.text, location.text, packedImage);
                      } else if (packedImage.path == '') {
                        showSnackBar(context, S.of(context).please_select_image);
                      }
                    },
                    child: Text(S.of(context).add_loc)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}