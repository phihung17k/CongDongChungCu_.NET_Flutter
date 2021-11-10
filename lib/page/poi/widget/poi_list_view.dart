import 'package:congdongchungcu/bloc/poi/poi_bloc.dart';
import 'package:congdongchungcu/bloc/poi/poi_event.dart';
import 'package:congdongchungcu/bloc/poi/poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class POIListView extends StatefulWidget {
  const POIListView(
      {Key key,
      this.poiModel,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final POIModel poiModel;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  State<POIListView> createState() => _POIListViewState();
}

class _POIListViewState extends State<POIListView> {
  @override
  Widget build(BuildContext context) {
    POIBloc bloc = BlocProvider.of<POIBloc>(context);
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
                        BlocBuilder<POIBloc,POIState>(
                          bloc: bloc,
                          builder: (context, state){
                            String imagePath = "http://wiki-travel.com.vn/uploads/post/camnhi-202124112127-khu-du-lich-suoi-tien.jpg";
                            if(widget.poiModel.imagePath.isNotEmpty){
                              imagePath = widget.poiModel.imagePath;
                            }
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 4),
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
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(Icons.phone, size: 17,),
                                                  Text(
                                                    widget.poiModel.phone,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              FontAwesomeIcons
                                                                  .mapMarkerAlt,
                                                              size: 16,
                                                              color:
                                                                  Colors.black),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(widget.poiModel.address,
                                                          style: TextStyle(color: Colors.grey
                                                            .withOpacity(0.8),
                                                            fontSize: 16),)
                                                        ],
                                                      ),
                                                    ),
                                                   
                                                  ],
                                                ),
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
}
