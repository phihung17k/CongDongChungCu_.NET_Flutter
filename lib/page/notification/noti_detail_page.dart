import '../../../models/notification/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class NotiDetailPage extends StatelessWidget {
  final NotiModel noti;
  const NotiDetailPage(this.noti, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Chi tiết'),
      ),
      body: Card(
        margin: EdgeInsets.all(Dimens.size10),
        elevation: Dimens.size4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.size15),
        ),
        child: Container(
          padding: EdgeInsets.all(Dimens.size10),
          margin: EdgeInsets.all(Dimens.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noti.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.size20,
                ),
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              Text(
                noti.createdDate,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: Dimens.size15,
                ),
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              const Divider(
                color: Colors.black26,
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              Text(
                noti.content,
                style: TextStyle(
                  fontSize: Dimens.size16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
