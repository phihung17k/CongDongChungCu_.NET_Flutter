import 'package:congdongchungcu/category_private/category_private_event.dart';

import '/base_bloc.dart';
import '/bloc/category/category_event.dart';
import '/bloc/category/category_state.dart';
import '/models/category_model/category_result.dart';
import '/models/category_model/get_category_model.dart';
import '/service/services.dart';
import 'category_private_state.dart';

class CategoryPrivateBloc extends BaseBloc<CategoryPrivateEvent, CategoryPrivateState>
{
  //
  final ICategoryService service;
  //
  CategoryPrivateBloc(this.service) : super(CategoryPrivateState(
    listCategory: [],
    getCategoryModel: GetCategoryModel(storeId: 0),


  )){
    on((event, emit) async{

      if(event is LoadCategoryPrivateEvent)
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
              state.copyWith(list: result.listCate, isCategoryChoose: result.listCate[0] ?? [])
          );
        }
      }

      if(event is LoadCategoryPrivateDefault)
      {
        CategoryResult result = await service.getCategoriesOfStore(GetCategoryModel(storeId:  null));

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

      if(event is SelectCategoryPrivateEvent)
      {
        print("giá trị của category được chọn: " + event.categoryModelIsChoose.name);
        //
        listener.add(SelectCategoryPrivateEvent(categoryModelIsChoose: event.categoryModelIsChoose));
        //
        emit(
            state.copyWith(isCategoryChoose: event.categoryModelIsChoose)
        );
      }


    }
    );
  }

}