import 'package:congdongchungcu/bloc/news_manage/news_manage_event.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_bloc.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_event.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class POICard extends StatefulWidget {

  const POICard(
      {Key key,
      this.poiModel,
      //this.imagePath,
      this.animationController,
      this.animation,
      this.callback,})
      : super(key: key);

  //final String imagePath;
  final VoidCallback callback;
  final POIModel poiModel;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  State<POICard> createState() => _POICardState();
  
}

class _POICardState extends State<POICard> {
  @override
  @override
  Widget build(BuildContext context) {
    POIManageBloc bloc = BlocProvider.of<POIManageBloc>(context);
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: widget.callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        BlocBuilder<POIManageBloc, POIManageState>(
                          bloc: bloc,
                          builder: (context, state){
                            String imagePath = "http://wiki-travel.com.vn/uploads/post/camnhi-202124112127-khu-du-lich-suoi-tien.jpg";
                            if(widget.poiModel.imagePath.isNotEmpty){
                              imagePath = widget.poiModel.imagePath;
                            }
                            // if(state.imageURl.isNotEmpty){
                            //   imagePath = state.imageURl;
                            // }
                          return Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.network(
                                 imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 4),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.poiModel.name,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                      FontAwesomeIcons
                                                          .mapMarkerAlt,
                                                      size: 16,
                                                      color: Colors.black),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      widget.poiModel.address,
                                                      maxLines: 2,
                                                      softWrap: false,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.phone,
                                                          size: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          widget.poiModel.phone,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              bloc.add(NavigatorEditPOIEvent(
                                                                  poi: widget
                                                                      .poiModel,
                                                                  listPoiType: bloc
                                                                      .state
                                                                      .listPoiType));
                                                            },
                                                            icon:
                                                                Icon(Icons.edit)),
                                                        IconButton(
                                                            onPressed: () {
                                                              widget.poiModel
                                                                  .status = false;
                                                              showAlertDialog(
                                                                  context);
                                                            },
                                                            icon: Icon(Icons
                                                                .delete_forever))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget showAlertDialog(BuildContext context) {
    // set up the buttons
    POIManageBloc bloc = BlocProvider.of<POIManageBloc>(context);
    Widget cancelButton = FlatButton(
      child: Text("Có"),
      onPressed: () {
        bloc.add(DeletePOI(poiModelDelete: widget.poiModel));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Xóa địa điểm thành công"),
        ));
        bloc.add(RefreshPOI());
        bloc.add(GetAllPOIEvent());
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xác nhận"),
      content: Text("Bạn có muốn tiếp tục xóa địa điểm này không ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
