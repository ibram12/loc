import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dalog.dart';
import 'package:loc/core/helper/delightful_toast.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/manager/Modify_permissions_cubit/modify_permissions_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/edit_role_dialog.dart';
import 'package:loc/featuers/admin/pressntation/widgets/modify_user_permations_dialog.dart';
import 'package:loc/featuers/admin/data/models/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import 'modify_user_service_dialog.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({super.key, required this.userInfoModel});
  final UserInfoModel userInfoModel;

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  bool? isDarkMode;

  Future<void> featchThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
  isDarkMode = prefs.getBool('themeMode') == true;
});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    if (isDarkMode == null) {
      return const Center(
      );
    }
    return BlocConsumer<ModifyPermissionsCubit, ModifyPermissionsState>(
      listener: (context, state) {
        if (state is ModifyRolePermissionsSuccess) {
          showSnackBar(context,
              '${S.of(context).you_have_modified} ${widget.userInfoModel.name} ${S.of(context).role_to} ${widget.userInfoModel.role}');
        } else if (state is ModifyPermissionsError) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        } else if (state is ModifyServicePermissionsSuccess) {
          showAlertDialog(
              context: context,
              message:
                  '${S.of(context).services_has_been_modified_to} ${widget.userInfoModel.services.join(', ')}',
              onOkPressed: () {
                Navigator.pop(context);
              });
        }
      },
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 34,
              child: ClipOval(
                child: widget.userInfoModel.imageUrl == ''
                    ? Image.asset('assets/images/person.png')
                    : CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                        imageUrl: widget.userInfoModel.imageUrl),
              ),
            ),
            title: SizedBox(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '${widget.userInfoModel.name} ',
                      style: Styles.textStyle18.copyWith(
                        color: isDarkMode!?Colors.white:Colors.black
                      )
                      ),
                  TextSpan(
                    text: '(${widget.userInfoModel.role})',
                    style: Styles.textStyle14.copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            )),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userInfoModel.email,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.userInfoModel.services.join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: state is ModifyPermissionsLoading
                  ? const CupertinoActivityIndicator()
                  : IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        showModifyUserPermationsDialog(
                          context: context,
                          userInfoModel: widget.userInfoModel,
                          onEditRolePressed: () {
                            Navigator.pop(context);
                            showEditRoleDialog(context, widget.userInfoModel,
                                (role) {
                              BlocProvider.of<ModifyPermissionsCubit>(context)
                                  .modifyRolePermissions(
                                      context: context,
                                      selectedRole: role,
                                      userId: widget.userInfoModel.id);
                            });
                          },
                          onEditServicesPressed: () {
                            Navigator.pop(context);
                            showMultiSelectDialog(
                              context: context,
                              userInfoModel: widget.userInfoModel,
                              onEditServicesSelected: (selectedServices) {
                                BlocProvider.of<ModifyPermissionsCubit>(context)
                                    .modifyServicePermissions(
                                        context: context,
                                        modifiedServices: selectedServices,
                                        userId: widget.userInfoModel.id);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
            ),
          ),
        );
      },
    );
  }
}
