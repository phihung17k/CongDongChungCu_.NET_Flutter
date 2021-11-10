import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../router.dart';
import 'widget/choose_image_gallery.dart';
import 'widget/dropdown_poi_type.dart';
import 'widget/input_poi_address.dart';
import 'widget/input_poi_name.dart';
import 'widget/input_poi_phone.dart';

class AddPOIPage extends StatefulWidget {
  final AddPOIBloc bloc;

  AddPOIPage(this.bloc);

  @override
  _AddPOIPageState createState() => _AddPOIPageState();
}

class _AddPOIPageState extends State<AddPOIPage> {
  AddPOIBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GetPOIType());
    bloc.listenerStream.listen((event) {
      if (event is NavigatorGoogleMapAdminEvent) {
        //the first choose location
        if (event.model == null) {
          Navigator.of(context).pushNamed(Routes.mapAdmin).then((value) {
            POIModel model = value as POIModel;
            if (model != null) {
              print("valueeeeeeee ${model.latitude} and ${model.longitude}");
              bloc.add(UpdateLocationEvent(
                latitude: model.latitude,
                longitude: model.longitude,
              ));
            }
          });
        } else {
          //choose location again
          Navigator.of(context)
              .pushNamed(Routes.mapAdmin, arguments: event.model)
              .then((value) {
            POIModel model = value as POIModel;
            if (model != null) {
              print("valueeeeee again ${model.latitude} and ${model.longitude}");
              bloc.add(UpdateLocationEvent(
                latitude: model.latitude,
                longitude: model.longitude,
              ));
            }
          });
        }
      }
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement initState

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: bloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Thêm địa điểm",
                  style: TextStyle(color: Colors.black54)),
              backgroundColor: AppColors.primaryColor,
            ),
            body: SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<AddPOIBloc, AddPOIState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChooseImageInGalleryInAdd(),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownPOITypeUIAdd(),
                          TextfieldInputPOINameAdd(),
                          TextfieldInputPOIAddressAdd(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Vị trí: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: const Icon(Icons.map),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    controller: TextEditingController()
                                      ..text = state.latitude == null
                                          ? ""
                                          : "${state.latitude}, ${state.longitude}",
                                    readOnly: true,
                                    onTap: () {
                                      bloc.add(NavigatorGoogleMapAdminEvent());
                                    },
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Chọn vị trí';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          TextfieldInputPOIPhoneAdd(),
                          Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.primaryColor,
                                  textStyle: const TextStyle(fontSize: 20)),
                              onPressed: () {
                                if (state.name != null &&
                                    state.address != null &&
                                    state.phone != null) {
                                  bloc.add(AddPOI(
                                      name: state.name,
                                      address: state.address,
                                      phone: state.phone,
                                      poiTypeID: state.dropdownNewValue));

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Thêm địa điểm thành công"),
                                  ));
                                  //Navigator.popUntil(context, ModalRoute.withName('/poi_manage'));
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Lưu',
                                  style: TextStyle(color: Colors.black54)),
                            ),
                          ),
                        ],
                      );
                    }))),
      ),
    );
  }
}
