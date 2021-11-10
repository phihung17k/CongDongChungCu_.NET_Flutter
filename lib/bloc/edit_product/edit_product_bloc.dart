import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:congdongchungcu/service/interface/i_product_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';
import 'edit_product_event.dart';
import 'edit_product_state.dart';

class EditProductBloc extends BaseBloc<EditProductEvent, EditProductState> {
  final IProductService service;

  //đưa init state vào cho bloc
  EditProductBloc({this.service})
      : super(EditProductState(
          productIsChoose: ProductModel(name: ""),
          pickerImage: XFile(""),
        )) {
    on((event, emit) async {
      if (event is RecieveProductModel) {
        //set state
        print("Nhận data từ productpage");
        //
        emit(state.copyWith(productIsChoose: event.productRecieve));
      }

      if (event is AddNewProductEvent) {
        //
        print("Tạo product ");
        //
        ProductModel result = await service.addProduct(event.model);
        //
        if (result != null) {
          print("Tạo Thành Công Product");
          await FirebaseUtils.uploadFile(state.pickerImage.path,
              result.id.toString(), "product_image");
          //
          listener.add(NavigatorToMyShopEvent(event.model.storeId));
        } else {
          print("Tạo Không Thành Công");
        }
      }

      if (event is UpdateProductEvent){
        // print("state.pickerImage.path ${state.pickerImage.path}");
        //
        print("update product ");
        //trường hợp này ng dùng qua trang update mà không sửa gì hết và ấn update
        //=> 2 object giống với nhau nên kh cần gọi service
        if(event.model == state.productIsChoose){
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          await FirebaseUtils.uploadFile(state.pickerImage.path,
              event.model.id.toString(), "product_image");
          listener.add(NavigatorToMyShopEvent(event.model.storeId));
        } else{
          bool result = await service.updateProduct(event.model);
          //
          if (result) {
            print("Update Thành Công Product");
            print(event.model.storeId);
            //
            await FirebaseUtils.uploadFile(state.pickerImage.path,
                event.model.id.toString(), "product_image");
            //
            listener.add(NavigatorToMyShopEvent(event.model.storeId));
          } else {
            print("Update Không Thành Công");
          }
        }
        //
        // bool result = await service.updateProduct(event.model);
        // //
        // if (result) {
        //   print("Update Thành Công Product");
        //   print(event.model.storeId);
        //   //
        //   await FirebaseUtils.uploadFile(state.pickerImage.path,
        //       event.model.id.toString(), "product_image");
        //   //
        //   listener.add(NavigatorToMyShopEvent(event.model.storeId));
        // } else {
        //   print("Update Không Thành Công");
        // }
      }

      if (event is ApproveProductEvent) {
        //
        print("update product ");
        //
        bool result = await service.updateProduct(event.model);
        //
        if (result) {
          print("Update Thành Công Product");
          print(event.model.storeId);
          //
          listener.add(NavigateToProductPageManagement(event.model.storeId));
        } else {
          print("Update Không Thành Công");
        }
      }

      if (event is ChangeStatusEvent) {
        print("Change Status Event");

        state.productIsChoose.status = event.status;

        print("Status của Event : " + event.status.toString());

        print("Test State của Product is choose: " +
            state.productIsChoose.status.toString());

        ProductModel model = state.productIsChoose;

        print(model.name);

        model.status = event.status;

        emit(state.copyWith(productIsChoose: model));
      }

      //delete
      if (event is DeleteProductEvent) {
        //
        print("Delete product ");
        //
        bool result = await service.updateProduct(event.model);
        //
        if (result) {
          print("Delete Thành Công Product");
          //
          listener.add(NavigatorToMyShopEvent(event.model.storeId));
        } else {
          print("Delete Không Thành Công");
        }
      }

      // if(event is UploadFileToFirebase){
      //   print(state.productIsChoose.id.toString());
      //   await FirebaseUtils.uploadFile(state.pickerImage.path, state.productIsChoose.id.toString(), "product_image");
      // }

      if (event is ChooseImage) {
        print('event picker file: ' + event.pickerFile.path);
        emit(state.copyWith(pickerImage: event.pickerFile));
      }
    });
  }
}
