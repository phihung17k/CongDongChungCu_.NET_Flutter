import '../../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../models/news/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;
  const NewsDetailPage(this.news, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository user = GetIt.I.get<UserRepository>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Chi tiết'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimens.size10),
          margin: EdgeInsets.all(Dimens.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.size20,
                ),
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              Text(
                'Từ: ' + user.selectedResident.apartmentModel.name + ' | ' + news.createdDate,
                style: TextStyle(
                  color: Colors.black54,
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
                news.content,
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
