import 'package:congdongchungcu/bloc/news_manage/news_manage_event.dart';

import '../../../bloc/news_manage/news_manage_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_colors.dart';

class AddNewsButton extends StatelessWidget {
  const AddNewsButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsManageBloc _bloc = BlocProvider.of<NewsManageBloc>(context);
    return FloatingActionButton.extended(
      backgroundColor: AppColors.primaryColor,
      icon: const Icon(Icons.add),
      label: const Text('Đăng tin mới'),
      onPressed: () async {
        _bloc.add(CreateNewsNavigator());
      },
    );
  }
}
