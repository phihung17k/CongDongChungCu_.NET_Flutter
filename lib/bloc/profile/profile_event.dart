class ProfileEvent {}

class AutoLoadProfileEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class NavigatorToMyShopEvent extends ProfileEvent {}

class SendStoreIdToMyShopEvent extends ProfileEvent {
  final int storeId;

  SendStoreIdToMyShopEvent({this.storeId});
}
