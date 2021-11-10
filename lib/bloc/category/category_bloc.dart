import 'package:congdongchungcu/models/category_model/category_model.dart';

import '/base_bloc.dart';
import '/bloc/category/category_event.dart';
import '/bloc/category/category_state.dart';
import '/models/category_model/category_result.dart';
import '/models/category_model/get_category_model.dart';
import '/service/services.dart';

class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState>
{
  //
  final ICategoryService service;
  //
  CategoryBloc(this.service) : super(CategoryState(
    listCategory: [],
    getCategoryModel: GetCategoryModel(storeId: 0),


  )){
    on((event, emit) async{

      if(event is LoadCategoryEvent)
        {

          // print("STORE ID :" + event.getCategoryModel.StoreId.toString());

          //gọi service
          CategoryResult result = await service.getCategoriesOfStore(event.getCategoryModel);
          //
          //
          if(event.categoryModel != null) {

            for(int i = 0; i < result.listCate.length ; i++)
              {
                if(result.listCate[i].id == event.categoryModel.id)
                  {
                    emit(
                      //set state lại
                        state.copyWith(list: result.listCate,
                            isCategoryChoose: result.listCate[i])
                    );
                  }
              }

          }else
            {
              emit(
                //set state lại
                  state.copyWith(list: result.listCate, isCategoryChoose: result.listCate[0])
              );
            }
        }

      if(event is LoadCategoryDefault)
        {
          CategoryResult result = await service.getCategoriesOfStore(GetCategoryModel(storeId: null));


          if(result != null)
            {
              print("LoadCategoryDefault thành công");
              emit(
                state.copyWith(list: result.listCate)
              );
            }
          else{
            print("LoadCategoryDefault lỗi");
          }
        }

      if(event is SelectCategoryEvent)
        {
          print("giá trị của category được chọn: " + event.categoryModelIsChoose.name);
          //
          listener.add(SelectCategoryEvent(categoryModelIsChoose: event.categoryModelIsChoose));
          //
          emit(
            state.copyWith(isCategoryChoose: event.categoryModelIsChoose)
          );
        }


    }
    );
  }

}

// if(event is DefaultValueOfDropdown)
//   {
//     print("DefaultValueOfDropdown: "+ event.categoryModel.name);
//     //set giá trị mặc định cho nó
//     emit(
//       state.copyWith(isCategoryChoose: event.categoryModel)
//     );
//   }



// if(event is PassDataCategoryIsChooseEvent)
//   {
//     listener.add(PassDataCategoryIsChooseEvent(categoryModel: event.categoryModel));
//     //cập nhật lại trạng thái category nào đang đc chọn
//     emit(
//       state.copyWith(isCategoryChoose: event.categoryModel)
//     );
//   }
//
// //nhận giá trị store id từ product page
// if(event is RecieveDataFromProductPageEvent)
// {
//    print("CATEGORY-LOAD-FOLLOW-BY-DATA-SEND-PRODUCTpage");
//    //
//    GetCategoryModel request = GetCategoryModel(StoreId: event.storeId);
//    //
//    //gọi service
//    CategoryResult result = await service.getCategoriesOfStore(request);
//
//    //tạo luôn event để chuyển lại trang productpage kèm theo list cate
//    listener.add(PassDataCategoryEvent(listCategory: result.listCate));
//    //
//    emit(
//      state.copyWith(list: result.listCate, getCategoryModel:request)
//    );
//
// }