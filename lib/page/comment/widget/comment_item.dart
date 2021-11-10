
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget{
   final Size size;
  final CommentModel commentModel;

  CommentItem({this.size, this.commentModel});
  @override State<StatefulWidget> createState() => _CommentItem();
}

class _CommentItem extends State<CommentItem>{

  @override
  void initState() {
    //_currentMyData = widget.myData;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0,2.0,10.0,2.0),
                child: Container(
                  //anh nguoi comment
                  //   width: widget.myData == null ? 48 : 40,
                  //   height: widget.myData == null ? 48 : 40,
                  width: 48,
                    height: 48,
                    child: CircleAvatar(backgroundImage: NetworkImage(widget.commentModel.userModel != null ? widget.commentModel.userModel.avaPath  : "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png")),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: widget.commentModel.ownerComment.isNotEmpty ? Text(widget.commentModel.ownerComment,style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.bold),) : Text("Khong"),
                            //child: Text("aaaaaaaaaaaa",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: widget.commentModel.content == null ? Text(widget.commentModel.content,maxLines: null,) :
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: widget.commentModel.content, style: TextStyle(color: Colors.black, fontSize: 17.5)),
                                  //TextSpan(text: Utils.commentWithoutReplyUser(widget.data['commentContent']), style: TextStyle(color:Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: widget.size.width * 0.38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(widget.commentModel.createdTime,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}