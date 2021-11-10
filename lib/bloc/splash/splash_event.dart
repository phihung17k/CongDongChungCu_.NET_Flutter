
class SplashEvent{}

class InitiatingUserEvent extends SplashEvent{
  final int residentId;

  InitiatingUserEvent(this.residentId);
}

class CompletedInitiationEvent extends SplashEvent{}