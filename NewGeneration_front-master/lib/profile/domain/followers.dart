class Followers {

  String userId;
  String followerId;

  Followers(this.userId, this.followerId);

  static List<Followers> getFromMap(List<dynamic> followersJson) {
    List<Followers> followers = [];
    for (var followers in followersJson) {
      followers.add(Followers(
          followers["userId"].toString(),
          followers["followerId"].toString()
      )
      );

    }
    return followers;
  }

  static Followers getFollowersFromBody(dynamic dynamicFollowers) {
    return Followers(
        dynamicFollowers["userId"].toString(),
        dynamicFollowers["followerId"].toString());


  }
}
