import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import '../../../requests/data/models/user_request_model.dart';

class RequestItemBody extends StatelessWidget {
  const RequestItemBody(
      {super.key, required this.requestModel, required this.isLoading});
  final RequestModel requestModel;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Banner(
      message: requestModel.daily == false ? S.of(context).not_daily : S.of(context).daily,
      color: requestModel.daily == false ? Colors.red : Colors.green,
      location: BannerLocation.topEnd,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 34,
                              child: ClipOval(
                                child: requestModel.imageUrl == null ? Image.asset('assets/images/person.png') : CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error,color: Colors.red,),
                                    imageUrl: requestModel.imageUrl!),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              requestModel.name,
                              overflow: TextOverflow.fade,
                              style: Styles.textStyle18,
                            ),
                          ],
                        ),
                        Text(
                          requestModel.service,
                          style:
                              Styles.textStyle18.copyWith(color: Colors.green),
                              overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${S.of(context).date}: ${DateFormat('dd-MM-yyyy').format(requestModel.startTime.toDate())}',
                          style: Styles.textStyle16,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${S.of(context).start_time}: ${DateFormat('hh:mm a').format(requestModel.startTime.toDate())}',
                          style: Styles.textStyle16,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${S.of(context).end_time}: ${DateFormat('hh:mm a').format(requestModel.endTime.toDate())}',
                          style: Styles.textStyle16,
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (requestModel.replyState.description == 'No reply yet')
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 20,
                        child: Image.asset(
                          'assets/images/9032185_pending_chatting_load_chat_social media_icon.png',
                          height: 30,
                        ),
                      ),
                    if (requestModel.replyState != ReplyState.noReplyYet)
                      CircleAvatar(
                        backgroundColor: requestModel.replyState.description ==
                                ReplyState.accepted.description
                            ? Colors.green
                            : Colors.red,
                        radius: 20,
                        child: Icon(
                          requestModel.replyState.description ==
                                  ReplyState.accepted.description
                              ? Icons.check
                              : Icons.close,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
