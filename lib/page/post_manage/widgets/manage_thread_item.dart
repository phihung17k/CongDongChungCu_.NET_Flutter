import 'package:congdongchungcu/bloc/post/post_bloc.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/bloc/post/post_state.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_bloc.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_event.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_state.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageThreadItem extends StatefulWidget {
  final Function threadItemAction;
  final PostModel postModel;

  ManageThreadItem({this.postModel, this.threadItemAction});

  @override
  State<ManageThreadItem> createState() => _ManageThreadItemState();
}

class _ManageThreadItemState extends State<ManageThreadItem> {
  @override
  Widget build(BuildContext context) {
    PostManageBloc postManageBloc = BlocProvider.of<PostManageBloc>(context);
    return BlocBuilder<PostManageBloc, PostManageState>(
        bloc: postManageBloc,
        builder: (context, state) {
          String imagePath = "";
          if(widget.postModel.imagePath.isNotEmpty){
            imagePath = widget.postModel.imagePath;
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    //onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                    child: Row(
                      children: <Widget>[
                        //anhr nguoi dung
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                          child: Container(
                              width: 48,
                              height: 48,
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.postModel.userModel != null ? widget.postModel.userModel.avaPath : "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png"))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.postModel.userModel != null ? widget.postModel.userModel.fullName : "Khong ten",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // //Text(Utils.readTimestamp(widget.postModel.createdDate),style: TextStyle(fontSize: 16,color: Colors.black87),),
                            Text(
                              widget.postModel.createdDate,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    //onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 4, 10),
                      child: Column(
                        children: [
                          Text(
                            widget.postModel.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.postModel.content.length > 200
                                ? '${widget.postModel.content.substring(0, 200)} ...'
                                : widget.postModel.content,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //IMAGE post
                  imagePath != "" ?
                  Container(
                    child: Image.network(imagePath),
                  ) : Container(),

                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            postManageBloc.add(ApprovedPostEvent(
                                postModelApproved: PostModel(
                                    id: widget.postModel.id,
                                    title: "",
                                    content: "",
                                    status: Status.Approved)));
                            // postManageBloc.add(RefreshPageManagePostEvent());
                            // postManageBloc.add(LoadPostManageEvent());
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.check_outlined, size: 18, color: Colors.green,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Duyệt bài',
                                  style: TextStyle(
                                    color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            postManageBloc.add(RejectedPostEvent(
                                postModelRejected: PostModel(
                                    id: widget.postModel.id,
                                    title: "",
                                    content: "",
                                    status: Status.Rejected)));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.remove_circle, size: 18, color: Colors.redAccent,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
