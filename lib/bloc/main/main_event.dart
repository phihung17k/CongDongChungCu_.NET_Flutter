

class MainEvent{}

class SwitchingPageEvent extends MainEvent{
  int pageIndex;

  SwitchingPageEvent({this.pageIndex});
}

class HidingFloatingActionButtonEvent extends MainEvent{}

class ShowingFloatingActionButtonEvent extends MainEvent{}