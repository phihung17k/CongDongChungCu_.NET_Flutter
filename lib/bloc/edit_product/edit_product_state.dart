
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class EditProductState extends Equatable
{

  final ProductModel productIsChoose;
  final XFile pickerImage;



  EditProductState({this.productIsChoose,this.pickerImage});

  EditProductState copyWith(
      {ProductModel productIsChoose, XFile pickerImage}) {
    return EditProductState(productIsChoose: productIsChoose ?? this.productIsChoose,
        pickerImage: pickerImage ?? this.pickerImage);
  }



  @override
  // TODO: implement props
  List<Object> get props => [productIsChoose, pickerImage];

}