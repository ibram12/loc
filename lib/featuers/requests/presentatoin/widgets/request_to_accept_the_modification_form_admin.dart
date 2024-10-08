import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_accept_admin_offer_cubit/user_accept_admin_offer_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_reject_admin_offer_cubit/user_reject_admin_offer_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/user_disetoin_button.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/user_request_model.dart';
import 'Request_card.dart';

class RequestToAcceptTheModificationFormAdminItem extends StatelessWidget {
  const RequestToAcceptTheModificationFormAdminItem(
      {super.key, required this.requestModel});
  final UserRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RequstCard(
            requestModel: requestModel,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: Styles.textStyle20Extra, // Base style
                      children: [
                         TextSpan(
                          text: '${requestModel.modifier} ' ,
                          style: const TextStyle(
                              color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              S.of(context).wants_to_modify_your_request_to_be,
                          style: TextStyle(
                              color: Colors
                                  .grey[700]), // Slightly less prominent color
                        ),
                        TextSpan(
                          text: ' ${S.of(context).on} ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: DateFormat('dd-MM-yyyy').format(requestModel.startTime.toDate()),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight
                                  .bold), // Highlighted color for date
                        ),
                        TextSpan(
                          text: ' ${S.of(context).at} ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: DateFormat('hh:mm a').format(requestModel.startTime.toDate()),
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight
                                  .bold), // Highlighted color for time
                        ),
                        TextSpan(
                          text: ' ${S.of(context).to} ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: DateFormat('hh:mm a').format(requestModel.endTime.toDate()),
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight
                                  .bold), // Highlighted color for time
                        ),
                      ],
                    ),
                  ),
                   Wrap(
                    children: [
                      UserDisetoinButton(
                        onPressed: () => context.read<UserAcceptAdminOfferCubit>().userAcceptUserOffer(context: context,userRequestModel: requestModel),
                          bottonName: "accept the the offer",
                          color: Colors.green),
                      UserDisetoinButton(
                        onPressed: ()=> context.read<UserRejectAdminOfferCubit>().userRejectAdminOffer(context: context,userRequestModel: requestModel),
                          bottonName: "cancel the request", color: Colors.red),
                    ],
                  )
                ],
              ),
            )),
        Positioned.directional(
         start: 10,
        textDirection: Directionality.of(context),
            child: const Icon(
              Icons.error_sharp,
              color: Colors.red,
              size: 40,
            )),
      ],
    );
  }
}
