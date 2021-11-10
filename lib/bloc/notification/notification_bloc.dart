import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/notification/notification_model.dart';

import '../../base_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends BaseBloc<NotificationEvent, NotificationState> {
int pageSize = 10;

  NotificationBloc(): super(NotificationState( notiList: <NotiModel>[],
      currentListNoti: <NotiModel>[], hasNext: false, currPage: 1)) {
    on((event, emit) async {
      if (event is GettingAllNotiEvent) {
        List<NotiModel> notiList = [];
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance.collection('Notification').get();
        for (var element in querySnapshot.docs) {
          Map<String, dynamic> dataMap = element.data();
          notiList.add(NotiModel.fromJson(dataMap));
        }
        notiList.sort();
        if (notiList.length > pageSize){
          for (int i = 0; i < pageSize; i++){
            state.currentListNoti.add(notiList[i]);
          }
          emit(state.copyWith(notiList: notiList, currentListNoti: state.currentListNoti, hasNext: true));
        } else {
          state.currentListNoti.addAll(notiList);
          emit(state.copyWith(notiList: notiList, currentListNoti: state.currentListNoti, hasNext: false));
        }
      } else if (event is LoadMoreEvent){
        int currPage = state.currPage + 1;
        if (state.notiList.length > pageSize * currPage){
          for(int i = pageSize * state.currPage; i < pageSize * currPage; i++){
            state.currentListNoti.add(state.notiList[i]);
          }
          emit(state.copyWith(currentListNoti: state.currentListNoti, hasNext: true));
        } else {
          for(int i = pageSize * state.currPage; i < state.notiList.length; i++){
            state.currentListNoti.add(state.notiList[i]);
          }
          emit(state.copyWith(currentListNoti: state.currentListNoti, hasNext: false));
        }
      } else if (event is RefreshNoti){
        emit(state.copyWith(notiList: <NotiModel>[],
            currentListNoti: <NotiModel>[], hasNext: false, currPage: 1));
      }
    });
  }
}
