class User {
  String id;
  String username;
  String name;
  String bio;
  String avatarFileUrl;
  int followers;
  int followed;
  int friends;

  User(this.id, this.username, this.name, this.bio, this.avatarFileUrl,
      this.followers, this.followed, this.friends);

  static List<User> getFromMap(List<dynamic> usersJson) {
    List<User> users = [];
    for (var user in usersJson) {
      users.add(User(
          user["id"].toString(),
          user["username"].toString(),
          user["name"].toString(),
          user["bio"].toString(),
          user["avatarFileUrl"] ?? "https://i.imgur.com/AD3MbBi.jpeg",
          user["followers"],
          user["followed"],
          user["friends"]));
    }
    return users;
  }

  static User getUserFromBody(dynamic dynamicUser) {
    return User(
        dynamicUser["id"].toString(),
        dynamicUser["username"],
        dynamicUser["name"].toString(),
        dynamicUser["bio"].toString(),
        dynamicUser["avatarFileUrl"] ?? "https://i.imgur.com/AD3MbBi.jpeg",
        dynamicUser["followers"],
        dynamicUser["followed"],
        dynamicUser["friends"]);
  }
}
