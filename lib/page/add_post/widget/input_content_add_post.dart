// import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
// import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
// import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class TextfieldInputPostContent extends StatefulWidget {
//
//   @override
//   _TextfieldInputPostContentState createState() =>
//       _TextfieldInputPostContentState();
// }
//
// class _TextfieldInputPostContentState extends State<TextfieldInputPostContent> {
//
//   @override
//   Widget build(BuildContext context) {
//     AddPostBloc addPostBloc = BlocProvider.of<AddPostBloc>(context);
//     var size = MediaQuery
//         .of(context)
//         .size;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Nội dung: ", style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 5,),
//           Container(
//             width: size.width,
//             child: BlocBuilder<AddPostBloc, AddPostState>(
//                 bloc: addPostBloc,
//                 builder: (context, state) {
//                   return TextFormField(
//                     inputFormatters: [
//                       LengthLimitingTextInputFormatter(500),
//                     ],
//                     maxLength: 500,
//                       validator: (value) {
//                         if (value.length < 3) {
//                           return 'Nhập ít nhất 3 ký tự';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       maxLines: 4,
//                       //controller: TextEditingController()..text = state.postReceive.content,
//                       onChanged: (value) {
//                         addPostBloc.add(GetPostContentEvent(content: value));
//                         //state.postReceive.content = value;
//                       }
//                   );
//                 }
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }