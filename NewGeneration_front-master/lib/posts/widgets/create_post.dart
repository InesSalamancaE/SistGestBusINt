import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:newgeneration_front/posts/domain/post.dart';
import 'package:newgeneration_front/users/repository/user_repository.dart';
import 'package:newgeneration_front/users/domain/user.dart';
import 'package:video_player/video_player.dart';


Future<void> createPost(XFile pickedImage, {required Map body}) async {
  // var response = await http.post(Uri.parse('http://10.0.2.2:5030/api/posts'),
  //     body: json.encode({'text': body["body"]}),
  //     headers: {
  //       "Accept": "application/json",
  //       "content-type": "application/json"
  //     });
  // print(response.statusCode);
  // print(response.body);
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://10.0.2.2:5000/api/posts'));
  request.fields.addAll({
    'userId': body['userId'],
    'title': body["title"],
    'body': body["body"],
    'hashtags': body["hashtags"],
    'community': body["community"]
  });
  request.files
      .add(await http.MultipartFile.fromPath('file', pickedImage.path));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class CreatePost extends StatefulWidget {
  static const String routeName = '/create-post';

  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePost createState() => _CreatePost();
}

//HTTP POST request
class _CreatePost extends State<CreatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController hashtagsController = TextEditingController();

  // Community is decided by isInComunity, if true is automatically added, if false it does not appear

  XFile? _pickedImage;
  bool _isVideo = false;

  // Only while there are no auth system
  List<User> _users = [];
  String _dropdownValue = '';

  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImageFile;
      _isVideo = false;
    });
  }

  void _pickImageFromCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImageFile;
      _isVideo = false;
    });
  }

  void _pickVideoFromCamera() async {
    final pickedVideoFile =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedVideoFile;
      _isVideo = true;
    });
  }

  Widget _previewVideo() {
    VideoPlayerController controller =
        VideoPlayerController.file(File(_pickedImage!.path));
    controller.setVolume(1.0);
    controller.initialize();
    controller.setLooping(true);
    controller.play();

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }

  Widget _previewImage() {
    return Image.file(File(_pickedImage!.path));
  }

  Widget _handlePreview() {
    if (_isVideo) {
      return _previewVideo();
    } else {
      return _previewImage();
    }
  }

  @override
  void initState() {
    super.initState();
    UserRepository.getUsers().then((x) {
      setState(() {
        _users = x;
        _dropdownValue = x.first.id;
      });
    });
  }

  // Interaction with the user, adding manually the tittle, body and hashtags
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              Container(
                child: _pickedImage != null ? _handlePreview() : null,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
              ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Add image'),
              ),
              TextButton.icon(
                onPressed: _pickImageFromCamera,
                icon: Icon(Icons.camera),
                label: Text('Add image'),
              ),
              TextButton.icon(
                onPressed: _pickVideoFromCamera,
                icon: Icon(Icons.videocam),
                label: Text('Add video'),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "title....", labelText: 'Post Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                    hintText: "body....", labelText: 'Post Body'),
              ),
              TextField(
                controller: hashtagsController,
                decoration: InputDecoration(
                    hintText: "hashtags....", labelText: 'Post hashtags'),
              ),
              DropdownButton(
                value: _dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownValue = newValue!;
                  });
                },
                items: _users.map((User value) {
                  return DropdownMenuItem(
                    value: value.id,
                    child: Text(value.username),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  Post newPost = Post(
                      postId: '',
                      userId: _dropdownValue,
                      title: titleController.text,
                      body: bodyController.text,
                      community: 'Funny',
                      hashtags: 'Scroll',
                      fileUrl: '');
                  await createPost(_pickedImage!, body: newPost.toMap());
                },
                child: const Text("Create"),
              )
            ],
          ),
        ));
  }
}
