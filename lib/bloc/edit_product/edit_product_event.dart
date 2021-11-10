import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProductEvent{}

//nhận data
class RecieveProductModel extends EditProductEvent
{
  final ProductModel productRecieve;

  RecieveProductModel({this.productRecieve});
}

//add new product
class AddNewProductEvent extends EditProductEvent
{
  final ProductModel model;

  AddNewProductEvent({this.model});
}

//update
class UpdateProductEvent extends EditProductEvent
{
  final ProductModel model;

  UpdateProductEvent({this.model});
}

//management
class ApproveProductEvent extends EditProductEvent
{
  final ProductModel model;

  ApproveProductEvent(this.model);
}

class NavigateToProductPageManagement extends EditProductEvent
{
  final int storeId;

  NavigateToProductPageManagement(this.storeId);
}



//delete product
class DeleteProductEvent extends EditProductEvent
{
  final ProductModel model;

  DeleteProductEvent({this.model});
}


//
class ChangeStatusEvent extends EditProductEvent
{
  final Status status;

  ChangeStatusEvent({this.status});
}

class NavigatorToMyShopEvent extends EditProductEvent
{
 final int storeId;

 NavigatorToMyShopEvent(this.storeId);
}

class UploadFileToFirebase extends EditProductEvent{}

class ChooseImage extends EditProductEvent{
  final XFile pickerFile;

  ChooseImage(this.pickerFile);
}

