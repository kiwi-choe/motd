import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:motd/service/feed_service.dart';
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/widget/edittext_form.dart';

class PhotoEditorScreen extends StatefulWidget {
  const PhotoEditorScreen({super.key});

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  File? _image;
  final picker = ImagePicker();
  late String _editContent = "";

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: <Widget>[
          TextButton(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          TextButton(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
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
                color: Colors.blue[100],
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

  void _saveMotd({File? image, required String content}) {
    // if (image != null) {
    //   Navigator.pop(context, FeedModel(image, content));
    // } else {
    //   debugPrint("File image is null");
    // }
    if (image != null) {
      FeedService().postFeed(FeedModel(image, content));
    } else {
      debugPrint("File image is null");
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
              _image!,
              fit: BoxFit.fill,
            ),
    );
  }

  Column addImageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No Image selected'),
        IconButton(
          onPressed: showOptions,
          icon: const Icon(Icons.add),
          iconSize: 20,
        ),
      ],
    );
  }
}
