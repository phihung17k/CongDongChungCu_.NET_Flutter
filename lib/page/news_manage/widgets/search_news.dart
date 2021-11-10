import '../../../bloc/news_manage/news_manage_state.dart';

import '../../../bloc/news_manage/news_manage_bloc.dart';
import '../../../bloc/news_manage/news_manage_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dimens.dart';

class SearchNewsField extends StatelessWidget {
  var _controller = TextEditingController();

  SearchNewsField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsManageBloc _bloc = BlocProvider.of<NewsManageBloc>(context);
    return BlocBuilder<NewsManageBloc, NewsManageState>(
        bloc: _bloc,
        builder: (context, NewsManageState state) {
          if (state.getNewsModel.keyword != null){
            _controller = TextEditingController(text: state.getNewsModel.keyword);
          }
          return Padding(
            padding: EdgeInsets.all(Dimens.size10),
            child: Column(
              children: [
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        height: Dimens.size45,
                        child: TextFormField(
                          controller: _controller,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            // Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
                            _bloc.add(SaveKeyword(keyword: value));
                            _bloc.add(GettingAllNewsEvent());
                          },
                          // validator: (value) {
                          //   if (value.length > 5) {
                          //     return '<= 50';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _controller.clear,
                              icon: const Icon(Icons.clear),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: Dimens.size1),
                            ),
                            labelText: 'Tìm kiếm tin tức',
                            // errorStyle: TextStyle(color: Colors.red),
                            // errorBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.red),
                            // ),
                          ),
                          // onSaved: (String value) {
                          //   print("search");
                          //
                          // },
                        )
                    ),
                  ),
                ]),
              ],
            ),
          );
        }
    );
  }
}