import 'package:congdongchungcu/bloc/productBloc/product_bloc.dart';
import 'package:congdongchungcu/bloc/productBloc/product_event.dart';
import 'package:congdongchungcu/bloc/productBloc/product_state.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';

class ProductDetail extends StatefulWidget {

  final ProductBloc productBloc;

  ProductDetail({this.productBloc});


  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  ProductBloc get _productBloc => widget.productBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _productBloc.listenerStream.listen((event) {
      if(event is NavigatorToStoreDetailEvent)
        {
          Navigator.of(context).pushNamed(Routes.storeDetail, arguments: event.storeId);
        }
    });

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //nhận productDTO từ
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      ProductModel pro = settings.arguments as ProductModel;

      if(pro != null)
      {
        //thêm sự kiện để cập nhật state
        _productBloc.add(RecieveDataEvent(pro));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc,ProductState>(
      bloc: _productBloc,
      builder: (context, state) {
         return state.productIsChoose.name == ""
             ? Text("Không nhận được product model")
             : Scaffold(
             appBar: AppBar(
               iconTheme: IconThemeData(color:Colors.black),
               title: Text(
                   'Chi tiết sản phẩm',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: Dimens.size23
                    )
               ),
               backgroundColor: AppColors.primaryColor,
               centerTitle: true,
             ),
             body: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Column(
                 children: [
                   SizedBox(
                     child: Image.network(
                       state.productIsChoose.imagePath,
                       fit: BoxFit.contain,
                     ),
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   Padding(
                       padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             // widget.product.name,
                               state.productIsChoose.name,
                               style: TextStyle(
                                   fontSize: Dimens.size25,
                                   fontWeight: FontWeight.bold)
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           Row(
                             children: [
                               Container(
                                   child: Image.asset(
                                     "assets/images/vnd.png",
                                     width: Dimens.size18,
                                     color: Colors.red,
                                   )
                               ),
                               Container(
                                 child: Container(
                                   child: Text(
                                     NumberFormat.decimalPattern()
                                         .format(state.productIsChoose.price),
                                     style: TextStyle(
                                         fontSize: Dimens.size22,
                                         color: Colors.red
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           Divider(
                             thickness: 5,
                             height: 30,
                             color: Colors.grey[300],
                             indent: Dimens.size5,
                             endIndent: Dimens.size5,
                           ),
                           Container(
                             child: Row(
                               children: [
                                 Container(
                                   width: 80,
                                   height: 80,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                   ),
                                   child: CircleAvatar(
                                     backgroundImage:
                                     AssetImage('assets/images/background.jpg'),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 20,
                                 ),
                                 Expanded(
                                   child: Text(
                                     state.productIsChoose.storeName,
                                     // widget.product.shopName,
                                     style: TextStyle(
                                         fontSize: Dimens.size18, fontWeight: FontWeight.bold),
                                   ),
                                 ),
                                 Container(
                                   width: 120,
                                   height: 40,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.rectangle,
                                     borderRadius: BorderRadius.circular(5),
                                     border: Border.all(color: AppColors.primaryColor),
                                   ),
                                   child: ElevatedButton(
                                     onPressed: () {
                                       // làm event để chuyển sang trang store detail
                                       //
                                       _productBloc.add(NavigatorToStoreDetailEvent(state.productIsChoose.storeId));

                                     },
                                     style: ButtonStyle(
                                         backgroundColor:
                                         MaterialStateProperty.all(Colors.white)),
                                     child: Text(
                                       "Xem shop",
                                       style: TextStyle(
                                           fontSize: Dimens.size16,
                                           fontWeight: FontWeight.w600,
                                           color: AppColors.primaryColor),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 20,
                           ),
                           Text(
                             "Chi tiết sản phẩm",
                             style: TextStyle(
                                 fontSize: Dimens.size20,
                                 fontWeight: FontWeight.w600),
                             textAlign: TextAlign.center,
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           Text(
                               state.productIsChoose.description,
                               style: TextStyle(
                                 fontSize: Dimens.size16,
                               )
                           ),
                         ],
                       )
                   )
                 ],
               ),
             )
         );
      },
    );



  }
}
