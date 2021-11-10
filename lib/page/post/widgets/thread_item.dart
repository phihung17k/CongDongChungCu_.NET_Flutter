import 'package:congdongchungcu/bloc/post/post_bloc.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ThreadItem extends StatelessWidget {
  final Function threadItemAction;
  final PostModel postModel;
  var residentId = GetIt.I.get<UserRepository>().selectedResident.id;
  var residentIsGroupAdmin =
      GetIt.I.get<UserRepository>().selectedResident.isAdmin;

  ThreadItem({this.postModel, this.threadItemAction});

  @override
  Widget build(BuildContext context) {
    PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              //onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
              child: Row(
                children: <Widget>[
                  //anhr nguoi dung
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                    child: Container(
                        width: 48,
                        height: 48,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(postModel.userModel.avaPath))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        postModel.userModel.username,
                        style: TextStyle(
                            fontSize: 19.5, fontWeight: FontWeight.bold),
                      ),
                      // //Text(Utils.readTimestamp(widget.postModel.createdDate),style: TextStyle(fontSize: 16,color: Colors.black87),),
                      Text(
                        postModel.createdDate,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  ),
                  const Spacer(),
                  (residentId == postModel.residentId ||
                          residentIsGroupAdmin == true )
                      ? PopupMenuButton<int>(
                          itemBuilder: (context) {
                            if (residentId != postModel.residentId && residentIsGroupAdmin == true) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    //print("aaaaaaaaaaaa");
                                    postBloc.add(DeletePostEvent(
                                        postModelDelete: PostModel(
                                            id: postModel.id,
                                            title: "",
                                            content: "",
                                            status: Status.InActive)));
                                    //showAlertDialog(context);
                                  },
                                  value: 2,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.delete, size: 18),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text('Xoá bài viết'),
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            }
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  postBloc.add(NavigatorEditPostEvent(
                                      postModel: postModel));
                                },
                                value: 1,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.edit, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Chỉnh sửa bài viết'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  //print("aaaaaaaaaaaa");
                                  postBloc.add(DeletePostEvent(
                                      postModelDelete: PostModel(
                                          id: postModel.id,
                                          title: "",
                                          content: "",
                                          status: Status.InActive)));
                                  //showAlertDialog(context);
                                },
                                value: 2,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.delete, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Xoá bài viết'),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                          initialValue: 1,
                          onCanceled: () {
                            // print("You have canceled the menu.");
                          },
                          // onSelected: (value) {
                          //   showDialog(
                          //       context: widget.parentContext,
                          //       builder: (BuildContext context) => ReportPost(postUserName: widget.data.username,postId:widget.data.postID,content:widget.data.postContent,reporter: widget.myData.myName,));
                          // },
                        )
                      : Container(),
                ],
              ),
            ),
            GestureDetector(
              //onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 4, 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        postModel.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        postModel.content.length > 200
                            ? '${postModel.content.substring(0, 132)} ...'
                            : postModel.content,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //IMAGE post
            // postModel.postImage != 'NONE' ? GestureDetector(
            //     //onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : widget.threadItemAction(),
            //     child: Utils.cacheNetworkImageWithEvent(context,widget.postModel.postImage,0,0)
            // ) :
            postModel.imagePath != ''
                ? Image.network(postModel.imagePath)
                : Container(),
            const Divider(
              height: 1,
              color: Colors.black38,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.comment,
                      arguments: postModel.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.comment_bank_outlined, size: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Bình luận',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
