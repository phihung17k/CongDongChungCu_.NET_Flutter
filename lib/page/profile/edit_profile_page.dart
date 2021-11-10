import 'package:congdongchungcu/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:congdongchungcu/bloc/edit_profile/edit_profile_event.dart';
import 'package:congdongchungcu/bloc/edit_profile/edit_profile_state.dart';
import 'package:congdongchungcu/bloc/profile/profile_bloc.dart';
import 'package:congdongchungcu/bloc/profile/profile_event.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';

class EditProfile extends StatefulWidget {
  // const EditProfile({Key key}) : super(key: key);
  final EditProfileBloc bloc;
  final ProfileBloc profileBloc;

  EditProfile(this.bloc, this.profileBloc);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileBloc get _editProfileBloc => widget.bloc;
  ProfileBloc get _profileBloc => widget.profileBloc;
  //
  UserRepository user = GetIt.I.get<UserRepository>();
  final usernameController = TextEditingController(text: GetIt.I.get<UserRepository>().username);
  final passwordController = TextEditingController(text: "********");
  final nameController = TextEditingController(text: GetIt.I.get<UserRepository>().fullname);
  final emailController = TextEditingController(text: GetIt.I.get<UserRepository>().email);
  final phoneController = TextEditingController(text: GetIt.I.get<UserRepository>().phone);
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editProfileBloc.listenerStream.listen((event) {
      if(event is NavigateToProfilePageEvent){
        _profileBloc.add(AutoLoadProfileEvent());
        Navigator.pop(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _editProfileBloc,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
              'Cập nhật thông tin',
              style: TextStyle(
                  color: Colors.black54,
                fontSize: Dimens.size23
              )
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: ListView(
          padding: EdgeInsets.only(
              top: 0,
              right: Dimens.size30,
              left: Dimens.size30,
              bottom: Dimens.size30),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.symmetric(vertical: Dimens.size30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(user.imagePath),
                    fit: BoxFit.contain
                ),
              ),
            ),
            SizedBox(
              height: Dimens.size15,
            ),
            BlocBuilder<EditProfileBloc, EditProfileState>(
              bloc: _editProfileBloc,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Dimens.size16),
                    ),
                    SizedBox(height: Dimens.size10),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size18),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Dimens.size16),
                    ),
                    SizedBox(height: Dimens.size10),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size18),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Họ và tên',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Dimens.size16),
                    ),
                    SizedBox(height: Dimens.size10),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size18),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Dimens.size16),
                    ),
                    SizedBox(height: Dimens.size10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size18),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Số điện thoại',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Dimens.size16),
                    ),
                    SizedBox(height: Dimens.size10),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size18),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: Dimens.size30,
                    ),
                    InkWell(
                      onTap: () {
                        //
                        print("phoneController: ${phoneController}");
                        _editProfileBloc.add(
                            UpdateProfileEvent(
                                userModel: UserModel(
                                    id: user.id,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    fullName: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    isSystemAdmin: false,
                                    status: true
                                )
                            )
                        );

                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Dimens.size15)),
                            color: Color.fromRGBO(240, 103, 103, 1),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: Dimens.size30),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  "Cập nhật",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                );
              },
            ),
            // SizedBox(
            //   height: Dimens.size30,
            // ),
            // InkWell(
            //   onTap: () {
            //     // here
            //     _editProfileBloc.add(UpdateProfileEvent(userModel: state.));
            //   },
            //   child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(Dimens.size15)),
            //         color: Color.fromRGBO(240, 103, 103, 1),
            //       ),
            //       margin: EdgeInsets.symmetric(horizontal: Dimens.size30),
            //       child: Padding(
            //         padding: const EdgeInsets.all(15.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             SizedBox(width: 5),
            //             Text(
            //               "Cập nhật",
            //               style: TextStyle(color: Colors.white, fontSize: 20),
            //             )
            //           ],
            //         ),
            //       )),
            // )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }
}
