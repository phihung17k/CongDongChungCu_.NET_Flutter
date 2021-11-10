
class DialogWidgetEvent{}

class SavingChangedItemEvent extends DialogWidgetEvent{
  final int hour;

  SavingChangedItemEvent(this.hour);
}

class SubmitItemEvent extends DialogWidgetEvent{
  final int hour;

  SubmitItemEvent({this.hour});
}