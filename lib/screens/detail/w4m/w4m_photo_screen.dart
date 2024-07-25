import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:motd/service/feed_service.dart';
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/widget/input_walking_count.dart';

class W4mPhotoScreen extends StatefulWidget {
  const W4mPhotoScreen({super.key});

  @override
  State<W4mPhotoScreen> createState() => _W4mPhotoScreenState();
}

class _W4mPhotoScreenState extends State<W4mPhotoScreen> {
  XFile? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Column(
            children: [
              InkWell(
                onTap: () {
                  // close the options modal
                  Navigator.of(context).pop();
                  // get image from gallary
                  getImageFromGallery();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      )),
                  height: 60,
                  width: 60,
                  child: const Icon(Icons.photo_library_outlined),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('갤러리'),
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  // close the options modal
                  Navigator.of(context).pop();
                  // get image from camera
                  getImageFromCamera();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      )),
                  height: 60,
                  width: 60,
                  child: const Icon(Icons.camera_alt_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('카메라'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card.filled(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: double.infinity,
                  child:
                      _image == null ? addImageWidget() : imageViewerWidget(),
                ),
              ),
              InputWalkingCount(
                onSaveWalkingCount: () =>
                    _saveW4m(image: _image, content: "#MOTD"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveW4m({XFile? image, required String content}) async {
    if (image != null) {
      FeedService().postFeed(FeedModel(image, "", content));
    }

    Navigator.pop(context);
  }

  Center imageViewerWidget() {
    return Center(
      child: kIsWeb
          ? Image.network(
              _image!.path,
              fit: BoxFit.fill,
            )
          : Image.file(
              File(_image!.path),
              fit: BoxFit.fill,
            ),
    );
  }

  Column addImageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/upload_image.png",
          height: 150,
          color: Colors.grey.withOpacity(0.5),
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 16,
        ),
        FloatingActionButton(
          backgroundColor: Colors.yellow,
          foregroundColor: const Color(0xFF2f72ba),
          onPressed: showOptions,
          child: const Icon(
            Icons.add,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "걸으며 찍은 사진을 올려주세요 :)",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
