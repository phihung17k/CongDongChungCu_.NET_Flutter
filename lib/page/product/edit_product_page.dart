import 'dart:io';

import 'package:congdongchungcu/app_colors.dart';

import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_event.dart';
import 'package:congdongchungcu/bloc/category/category_state.dart';
import 'package:congdongchungcu/bloc/edit_product/edit_product_bloc.dart';
import 'package:congdongchungcu/bloc/edit_product/edit_product_event.dart';
import 'package:congdongchungcu/bloc/edit_product/edit_product_state.dart';

import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/product_agrument.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:congdongchungcu/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../dimens.dart';

class AddNewProduct extends StatefulWidget {
  // const AddNewProduct({Key key}) : super(key: key);

  final EditProductBloc editProductBloc;

  final CategoryBloc categoryBloc;

  AddNewProduct({this.editProductBloc, this.categoryBloc});

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKeyProductName = GlobalKey<FormState>();
  final _formKeyProductPrice = GlobalKey<FormState>();
  final _formKeyProductDescription = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stateController = TextEditingController();
  final descriptionController = TextEditingController();

  //
  EditProductBloc get _editProductBloc => widget.editProductBloc;

  //
  CategoryBloc get _categoryBloc => widget.categoryBloc;

  //
  int storeIdEdit;

  //String _selectedCate = 'Thực phẩm';
  //

  Status _status;

  var _image;
  var imagePicker;

  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    imagePicker = new ImagePicker();

    //tạo thành công thì navigate lại shop
    _editProductBloc.listenerStream.listen((event) {
      if (event is NavigatorToMyShopEvent) {
        //
        print(
            "ĐÂY LÀ TRANG EDIT PRODUCT PAGE GỬI STORE ID KHI EDIT THÀNH CÔNG");
        print("----Store ID : " + event.storeId.toString());
        // Navigator.of(context).pushReplacementNamed(Routes.storePersonal,
        //     arguments: event.storeId);

        Navigator.of(context).pop(event.storeId);
      }
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    //nhận agrument của bên trang product để load category có trong storeId đó
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      ProductAgrument proAgru = settings.arguments as ProductAgrument;

      if (proAgru.productModel != null) {
        ProductModel productChoose = proAgru.productModel;
        //
        print("nhận dữ liệu selecting product");
        // có state
        _editProductBloc
            .add(RecieveProductModel(productRecieve: productChoose));

        //
        _categoryBloc.add(LoadCategoryEvent(
            getCategoryModel: GetCategoryModel(storeId: productChoose.storeId),
            categoryModel: CategoryModel(
                id: productChoose.categoryId,
                name: productChoose.categoryName)));

        //
        storeIdEdit = productChoose.storeId;
        //_status = productChoose.status;
      }

      if (proAgru.storeId != null) {
        int storeId = proAgru.storeId;
        //
        print("nhận dữ liệu store id");
        //
        storeIdEdit = proAgru.storeId;

        _categoryBloc.add(LoadCategoryEvent(
          getCategoryModel: GetCategoryModel(),
        ));
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProductBloc, EditProductState>(
      bloc: _editProductBloc,
      builder: (context, state) {
        //
        //_status = state.productIsChoose.status;

        if (state.productIsChoose.name == "") {
          nameController.text = "";
          priceController.text = "";
          stateController.text = "";
          descriptionController.text = "";
        }
        if (state.productIsChoose.name != "") {
          nameController.text = state.productIsChoose.name;
          priceController.text = state.productIsChoose.price.toString();
          stateController.text = state.productIsChoose.status.toString();
          descriptionController.text = state.productIsChoose.description;
        }
        return state.productIsChoose.name.isEmpty
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  title: Text('Thêm mới sản phẩm',
                      style: TextStyle(
                          color: Colors.black54, fontSize: Dimens.size23)),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                height: 230,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.size10),
                                child: InkWell(
                                  onTap: () async {
                                    XFile image = await imagePicker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                        preferredCameraDevice:
                                            CameraDevice.front);
                                    // setState(() {
                                    _image = File(image.path);
                                    // });
                                    _editProductBloc.add(ChooseImage(image));
                                  },
                                  child: _image != null
                                      ? Image.file(
                                          _image,
                                          fit: BoxFit.contain,
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              "https://support.sapo.vn/Upload/ImageManager/Image/HaBTT/Sapoweb/San%20pham/sp6.jpg"),
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: BlocBuilder<CategoryBloc, CategoryState>(
                                bloc: _categoryBloc,
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loại Sản Phẩm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        // color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimens.size10,
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: Colors.grey),
                                            borderRadius: BorderRadius.circular(
                                                Dimens.size10)),
                                        child: DropdownButton<CategoryModel>(
                                          isExpanded: true,
                                          value: state.isCategoryChoose,
                                          onChanged: (CategoryModel newValue) {
                                            print("newValue: ${newValue}");
                                            _categoryBloc.add(
                                                SelectCategoryEvent(
                                                    categoryModelIsChoose:
                                                        newValue));
                                          },
                                          items: state.listCategory
                                              .map((CategoryModel value) {
                                            return DropdownMenuItem<
                                                CategoryModel>(
                                              value: value,
                                              child: Text(
                                                value.name,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Tên sản phẩm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductName,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            controller: nameController,
                                            maxLines: 1,
                                            maxLength: 20,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 2) {
                                                return 'Nhập ít nhất 2 ký tự';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductName
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập tên sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Giá thành (VND)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductPrice,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            controller: priceController,
                                            maxLines: 1,
                                            maxLength: 20,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 2) {
                                                return 'Nhập ít nhất 2 số';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductPrice
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập giá sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Mô tả sản phẩm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductDescription,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            controller: descriptionController,
                                            maxLines: 5,
                                            maxLength: 200,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 10) {
                                                return 'Nhập ít nhất 10 ký tự';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductDescription
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập mô tả sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //validate Name
                                          if (_formKeyProductName.currentState
                                              .validate()) {
                                            //validate Price
                                            if (_formKeyProductPrice
                                                .currentState
                                                .validate()) {
                                              //validate Description
                                              if (_formKeyProductDescription
                                                  .currentState
                                                  .validate()) {
                                                //tạo event create sản phẩm
                                                _editProductBloc
                                                    .add(AddNewProductEvent(
                                                        model: ProductModel(
                                                  name: nameController.text,
                                                  price: double.parse(
                                                      priceController.text),
                                                  description:
                                                      descriptionController
                                                          .text,
                                                  storeId: storeIdEdit,
                                                  categoryId:
                                                      state.isCategoryChoose.id,
                                                )));

                                                double p = double.parse(
                                                    priceController.text);

                                                print("Name : " +
                                                    nameController.text);

                                                print(p);

                                                print("Description : " +
                                                    descriptionController.text);

                                                print("Category-id : " +
                                                    state.isCategoryChoose.id
                                                        .toString());

                                                print("Store-id :" +
                                                    storeIdEdit.toString());
                                              }
                                            }
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: Color.fromRGBO(
                                                  240, 103, 103, 1),
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Thêm mới sản phẩm",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  );
                                },
                              )),
                        ],
                      )),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  title: Text('Cập nhật sản phẩm',
                      style: TextStyle(
                          color: Colors.black54, fontSize: Dimens.size23)),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                height: 230,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.size10),
                                child: InkWell(
                                    onTap: () async {
                                      XFile image = await imagePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50,
                                          preferredCameraDevice:
                                              CameraDevice.front);
                                      // setState(() {
                                      //   _image = File(image.path);
                                      // });
                                      _image = File(image.path);
                                      _editProductBloc.add(ChooseImage(image));
                                    },
                                    child: _image != null
                                        ? Image.file(
                                            _image,
                                            fit: BoxFit.contain,
                                          )
                                        : ((state.productIsChoose.imagePath !=
                                                null)
                                            ? Image.network(
                                                state.productIsChoose.imagePath)
                                            : Image.network(
                                                "https://support.sapo.vn/Upload/ImageManager/Image/HaBTT/Sapoweb/San%20pham/sp6.jpg"))),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: BlocBuilder<CategoryBloc, CategoryState>(
                                bloc: _categoryBloc,
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loại Sản Phẩm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      SizedBox(height: Dimens.size15),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimens.size15),
                                        child: DropdownButton<CategoryModel>(
                                          isExpanded: true,
                                          value: state.isCategoryChoose,
                                          onChanged: (CategoryModel newValue) {
                                            _categoryBloc.add(
                                                SelectCategoryEvent(
                                                    categoryModelIsChoose:
                                                        newValue));
                                          },
                                          items: state.listCategory
                                              .map((CategoryModel value) {
                                            return DropdownMenuItem<
                                                CategoryModel>(
                                              value: value,
                                              child: Text(
                                                value.name,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.size15),
                                            border: Border.all(
                                                color: Colors.grey[500])),
                                      ),
                                      SizedBox(height: Dimens.size20),
                                      SizedBox(height: 20),
                                      Text(
                                        'Tên sản phẩm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductName,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: nameController,
                                            maxLines: 1,
                                            maxLength: 20,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 2) {
                                                return 'Nhập ít nhất 2 ký tự';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductName
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập tên sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Giá thành (VND)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductPrice,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            controller: priceController,
                                            maxLines: 1,
                                            maxLength: 20,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 2) {
                                                return 'Nhập ít nhất 2 số';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductPrice
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập giá sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Mô tả sản phẩm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimens.size16),
                                      ),
                                      Form(
                                        key: _formKeyProductDescription,
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: TextFormField(
                                            controller: descriptionController,
                                            maxLines: 5,
                                            maxLength: 200,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 10) {
                                                return 'Nhập ít nhất 10 ký tự';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyProductDescription
                                                  .currentState
                                                  .validate()) {
                                                //nameController.text = value;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: Dimens.size1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: Dimens.size1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: 'Nhập mô tả sản phẩm ',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (_formKeyProductName.currentState.validate()) {
                                      //validate Price
                                      if (_formKeyProductPrice.currentState.validate()) {
                                        //validate Description
                                        if (_formKeyProductDescription.currentState.validate()) {
                                          //tạo event XÓA sản phẩm
                                          // print("DELETE");
                                          //
                                          // double p = double.parse(priceController.text);
                                          //
                                          // print("Name : " + nameController.text);
                                          //
                                          // print(p);
                                          //
                                          // print("Description : " + descriptionController.text);
                                          //
                                          // //print("Category-id : " + state.isCategoryChoose.id.toString());
                                          //
                                          // print("Store-id :" + storeIdEdit.toString());

                                          _editProductBloc.add(DeleteProductEvent(
                                              model: ProductModel(
                                                  storeId: storeIdEdit,
                                                  id: state.productIsChoose.id,
                                                  price: double.parse(
                                                      priceController.text),
                                                  description:
                                                  descriptionController.text,
                                                  status: Status.InActive)));
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        color: Color.fromRGBO(240, 103, 103, 1),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              "Xóa sản phẩm",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    //validate name
                                    if (_formKeyProductName.currentState.validate())
                                    {//validate price
                                      if(_formKeyProductPrice.currentState.validate())
                                        {//validate description
                                          if(_formKeyProductDescription.currentState.validate())
                                            {
                                              //tạo event UPDATEsản phẩm
                                              print("UPDATE");

                                              double priceProduct =
                                              double.parse(priceController.text);

                                              print("Name : " + nameController.text);

                                              print(priceProduct);

                                              print("Description : " +
                                                  descriptionController.text);

                                              //print("Category-id : " + state.isCategoryChoose.id.toString());

                                              print("Store-id :" +
                                                  storeIdEdit.toString());

                                              print("Status :" +
                                                  state.productIsChoose.status
                                                      .toString());

                                              //gọi hàm update
                                              // _editProductBloc
                                              //     .add(UploadFileToFirebase());
                                              print(
                                                  "priceController: ${priceController.text}");

                                              _editProductBloc.add(UpdateProductEvent(
                                                  model: ProductModel(
                                                      storeId: storeIdEdit,
                                                      id: state.productIsChoose.id,
                                                      name: nameController.text,
                                                      price: priceProduct,
                                                      description:
                                                      descriptionController.text,
                                                      status: state
                                                          .productIsChoose.status)));
                                            }
                                        }
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        color: Color.fromRGBO(240, 103, 103, 1),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              "Cập nhật sản phẩm",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ]),
                        ],
                      )),
                ),
              );
      },
    );
  }
}
