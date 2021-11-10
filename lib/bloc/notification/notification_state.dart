import '../../models/notification/notification_model.dart';
import 'package:equatable/equatable.dart';

class NotificationState extends Equatable{
  final List<NotiModel> notiList;
  List<NotiModel> currentListNoti;
  final int currPage;
  final bool hasNext;
  //
  NotificationState({this.notiList, this.currentListNoti, this.hasNext, this.currPage});

  NotificationState copyWith({List<NotiModel> notiList, List<NotiModel> currentListNoti,
    int currPage, bool hasNext}){
    return NotificationState(
      notiList: notiList ?? this.notiList,
      currentListNoti: currentListNoti ?? this.currentListNoti,
      hasNext: hasNext ?? this.hasNext,
      currPage: currPage ?? this.currPage,
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [notiList, currentListNoti, hasNext, currPage];
}