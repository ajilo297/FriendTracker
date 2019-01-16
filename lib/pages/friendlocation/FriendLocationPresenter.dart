import './IFriendLocation.dart';

class FriendLocationPresenter implements IFriendLocationPresenter {
  IFriendLocationPage view;
  FriendLocationPresenter(IFriendLocationPage view) {
    this.view = view;
  }
}
