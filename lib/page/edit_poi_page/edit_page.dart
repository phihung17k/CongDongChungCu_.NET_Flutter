import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_event.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_event.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_colors.dart';
import '../../router.dart';
import 'widget/choose_image_gallery.dart';
import 'widget/dropdown_poi_type.dart';
import 'widget/input_poi_address.dart';
import 'widget/input_poi_name.dart';
import 'widget/input_poi_phone.dart';

class EditPoiPage extends StatefulWidget {
  final EditPOIBloc bloc;

  EditPoiPage(this.bloc);

  @override
  _EditPoiPageState createState() => _EditPoiPageState();
}

class _EditPoiPageState extends State<EditPoiPage> {
  EditPOIBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.listenerStream.listen((event) {
      if (event is NavigatorGoogleMapAdminEvent) {
        Navigator.pushNamed(context, Routes.mapAdmin, arguments: event.model)
            .then((value) {
          POIModel result = value as POIModel;
          if (result != null) {
            print("result latlng ${result.latitude} and ${result.longitude}");
            //do something
            //update new lat lng
            bloc.add(UpdateLatLngPOIEvent(model: result));
          }
        });
      }
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement initState
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      NavigatorEditPOIEvent event = settings.arguments as NavigatorEditPOIEvent;
      bloc.add(ReceiveDataFromPOIPage(
          poiReceive: event.poi, listPoiType: event.listPoiType));
    }
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
              title: Text("Chỉnh sửa địa điểm",
                  style: TextStyle(color: Colors.black54)),
              backgroundColor: AppColors.primaryColor,
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<EditPOIBloc, EditPOIState>(
                  bloc: bloc,
                  builder: (context, state) {
                    print("poi receive");
                    print(state.poiReceive.imagePath);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChooseImageInGallery(),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownPOITypeUI(),
                        TextfieldInputPOIName(),
                        TextfieldInputPOIAddress(),
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
                                  controller: TextEditingController()..text =
                                      "${state.poiReceive.latitude}, ${state.poiReceive.longitude}",
                                  readOnly: true,
                                  onTap: () {
                                    bloc.add(NavigatorGoogleMapAdminEvent(
                                        model: state.poiReceive));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        TextfieldInputPOIPhone(),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {
                              bloc.add(
                                  UpdatePOI(poiModelUpdate: state.poiReceive));
                              bloc.add(UploadFileImageToFireBase(
                                  pickedFile: state.pickedFile));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Chỉnh sửa địa điểm thành công"),
                              ));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Lưu',
                                style: TextStyle(color: Colors.black54)),
                          ),
                        ),
                      ],
                    );
                  }),
            )),
      ),
    );
  }
}
