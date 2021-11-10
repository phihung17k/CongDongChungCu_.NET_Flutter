import '../../bloc/create_news/create_news_event.dart';
import '../../bloc/create_news/create_news_bloc.dart';
import 'package:flutter/services.dart';
import '../../app_colors.dart';
import '../../dimens.dart';
import '../../models/news/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CreateNewsPage extends StatefulWidget {
  final CreateNewsBloc bloc;

  const CreateNewsPage(this.bloc, {Key key}) : super(key: key);

  @override
  _CreateNewsPageState createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends State<CreateNewsPage> {
  CreateNewsBloc get _bloc => widget.bloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.listenerStream.listen((event) {
      if (event is CreateSuccess) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Thêm thành công"),
        ));
      } else if (event is CreateFail) {
        Navigator.of(context).pop(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình thêm, vui lòng thử lại sau"),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();
    var _contentController = TextEditingController();
    return BlocProvider.value(
        value: _bloc,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: const Text("Thêm tin mới"),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Bỏ tin?'),
                            content: const Text(
                                'Nếu bỏ bây giờ, bạn sẽ mất tin này.'),
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
                                  child: const Text('Tiếp tục thêm'))
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
                        _bloc.add(SaveNews(NewsModel(
                            title: _titleController.text,
                            content: _contentController.text)));
                      }
                    },
                    child: Text("Đăng",
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
                                    color: Colors.red, width: Dimens.size1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: Dimens.size1),
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
                                    color: Colors.red, width: Dimens.size1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: Dimens.size1),
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
            )));
  }
}
