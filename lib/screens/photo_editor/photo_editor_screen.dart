import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:motd/main.dart';
import 'package:motd/service/feed_service.dart';
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/widget/edittext_form.dart';

class PhotoEditorScreen extends StatefulWidget {
  const PhotoEditorScreen({super.key});

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  XFile? _image;
  final picker = ImagePicker();
  late String _editContent = "";

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

  void _handleTapboxChanged(String content) {
    setState(() {
      _editContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () => _saveMotd(
                image: _image,
                content: _editContent,
              ),
              child: const Text("저장"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card.filled(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: double.infinity,
                  child:
                      _image == null ? addImageWidget() : imageViewerWidget(),
                ),
              ),
            ),
            EditTextForm(
              getContent: _handleTapboxChanged,
              hintText: '#워킹포미라클 #삼성동독거노인굿모닝 #장애인복지센터방문 #나의MOTD',
            ),
          ],
        ),
      ),
    );
  }

  void _saveMotd({XFile? image, required String content}) async {
    // FeedService().test();
    if (image != null) {
      FeedService().postFeed(FeedModel(image, "", content));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사진을 추가해주세요~'),
        ),
      );
    }
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
          "오늘의 기적을 함께 나눠요 :)",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
