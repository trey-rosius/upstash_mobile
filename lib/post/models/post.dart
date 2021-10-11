class Post {
  String? postText;
  String? userId;
  String? createdOn;
  String? id;
  String? postImage;
  PostAdmin? postAdmin;

  Post(
      {this.postText,
      this.userId,
      this.createdOn,
      this.id,
      this.postImage,
      this.postAdmin});

  Post.fromJson(Map<String, dynamic> json) {
    postText = json['postText'];
    userId = json['userId'];
    createdOn = json['createdOn'];
    id = json['id'];
    postImage = json['postImage'];
    postAdmin = json['postAdmin'] != null
        ? new PostAdmin.fromJson(json['postAdmin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postText'] = this.postText;
    data['userId'] = this.userId;
    data['createdOn'] = this.createdOn;
    data['id'] = this.id;
    data['postImage'] = this.postImage;
    if (this.postAdmin != null) {
      data['postAdmin'] = this.postAdmin!.toJson();
    }
    return data;
  }
}

class PostAdmin {
  String? timestamp;
  String? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? profilePic;

  PostAdmin(
      {this.timestamp,
      this.userId,
      this.username,
      this.firstName,
      this.lastName,
      this.profilePic});

  PostAdmin.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    userId = json['userId'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePic'] = this.profilePic;
    return data;
  }
}