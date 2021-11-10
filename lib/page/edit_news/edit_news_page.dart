import 'package:congdongchungcu/bloc/news_manage/news_manage_event.dart';
import 'package:flutter/services.dart';

import '../../app_colors.dart';
import '../../bloc/edit_news/edit_news_state.dart';

import '../../bloc/edit_news/edit_news_event.dart';

import '../../dimens.dart';
import '../../models/news/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit_news/edit_news_bloc.dart';
import 'package:flutter/material.dart';

class EditNewsPage extends StatefulWidget {
  final EditNewsBloc bloc;

  const EditNewsPage(this.bloc, {Key key}) : super(key: key);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  EditNewsBloc get _bloc => widget.bloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      EditNewsNavigator event = settings.arguments as EditNewsNavigator;
      _bloc.add(ReceiveDataFromNewsPage(event.editModel));
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.listenerStream.listen((event) {
      if (event is UpdateSuccess) {
        Navigator.of(context).pop(event.updateModel.id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Chỉnh sửa thành công"),
        ));
      } else if (event is UpdateFail) {
        Navigator.of(context).pop(0);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Đã có lỗi trong quá trình cập nhật, vui lòng thử lại sau"),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<EditNewsBloc, EditNewsState>(
            bloc: _bloc,
            builder: (context, EditNewsState state) {
              var model = state.receiveModel;
              if (model.title != null) {
                var _titleController = TextEditingController(text: model.title);
                var _contentController =
                    TextEditingController(text: model.content);
                return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      appBar: AppBar(
                        backgroundColor: AppColors.primaryColor,
                        title: const Text("Chỉnh sửa tin tức"),
                        leading: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: const Text('Bỏ thay đổi?'),
                                    content: const Text('Nếu bạn hủy bây giờ, thay đổi của bạn sẽ bị hủy bỏ.'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Bỏ')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Tiếp tục chỉnh sửa'))
                                    ],
                                  );
                                });
                            //Navigator.of(context).pop();
                          },
                        ),
                        actions: [
                          FlatButton(
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _bloc.add(UpdateNews(NewsModel(
                                    id: model.id,
                                    title: _titleController.text,
                                    content: _contentController.text)));
                              }
                            },
                            child: Text("Lưu",
                                style: TextStyle(
                                  fontSize: Dimens.size18,
                                )),
                            shape: const CircleBorder(
                                side: BorderSide(color: Colors.transparent)),
                          ),
                        ],
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(Dimens.size8),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimens.size8),
                                    child: Text(
                                      "Tiêu đề",
                                      style: TextStyle(
                                        fontSize: Dimens.size20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  child: TextFormField(
                                    controller: _titleController,
                                    maxLines: 3,
                                    maxLength: 200,
                                    //initialValue: model.title,
                                    keyboardType: TextInputType.multiline,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(200),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 10) {
                                        return 'Nhập ít nhất 10 ký tự';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red,
                                            width: Dimens.size1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: Dimens.size1),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintText: 'Nhập tiêu đề',
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimens.size8),
                                    child: Text(
                                      "Nội dung",
                                      style: TextStyle(
                                        fontSize: Dimens.size20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  child: TextFormField(
                                    controller: _contentController,
                                    maxLines: 14,
                                    maxLength: 1000,
                                    // initialValue: model.content,
                                    keyboardType: TextInputType.multiline,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1000),
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 10) {
                                        return 'Nhập ít nhất 10 ký tự';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red,
                                            width: Dimens.size1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: Dimens.size1),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintText: 'Nhập nội dung',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              } else {
                return const Text('Đợi xíu bạn nhé');
              }
            }));
  }
}
