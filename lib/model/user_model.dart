class CustomUser {
  String uid = "";
  String showName = "";
  String email = "";
  String profilePictureUrl = "";

  CustomUser(inUid, inShowName, inEmail, inProfilePictureUrl) {
    uid = inUid;
    showName = inShowName;
    email = inEmail;
    profilePictureUrl = inProfilePictureUrl;
  }

  void destroy() {
    uid = "";
    showName = "";
    email = "";
    profilePictureUrl = "";
  }
}
