class Post {
  String postId;
  String userId;
  String title;
  String body;
  String? hashtags;
  String? community;
  String fileUrl;

  Post(
      {required this.postId,
      required this.userId,
      required this.title,
      required this.body,
      this.hashtags,
      this.community,
      this.fileUrl = ""});

  factory Post.fromJson(Map json) {
    return Post(
      postId: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      hashtags: json['hashtags'],
      community: json['community'],
      fileUrl: json['fileUrl'],
    );
  }

  static List<Post> fromMap(List<dynamic> postsJson) {
    List<Post> posts = [];
    for (var post in postsJson) {
      posts.add(Post(
          postId: post['id'],
          userId: post['userId'],
          title: post['title'],
          body: post['body'],
          hashtags: post['hashtags'],
          community: post['community'],
          fileUrl: post['fileUrl']));
    }
    return posts;
  }

  Map toMap() {
    var map = {};
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;
    map["hashtags"] = hashtags;
    map["community"] = community;

    return map;
  }
}
