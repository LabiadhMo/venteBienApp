import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/galleryPage.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/photoPreview.dart';
import 'package:photo_manager/photo_manager.dart';

List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  bool initialized = false;
  List<AssetPathEntity> list = [];
  List<AssetEntity> entities;
  init() async {
    list = await PhotoManager.getAssetPathList(onlyAll: true);

    entities = await list.first.getAssetListRange(start: 0, end: 100);
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        initialized = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppTheme.kAppBarGradient1,
                AppTheme.kAppBarGradient2
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            initialized == true
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    child: CameraPreview(controller))
                : CircularProgressIndicator(),
            Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sensitivity = 8;
                        if (details.delta.dy > sensitivity) {
                          // Down Swipe
                        } else if (details.delta.dy < -sensitivity) {
                          // Up Swipe
                          Get.to(GalleryPage(entities: entities));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sensitivity = 8;
                        if (details.delta.dy > sensitivity) {
                          // Down Swipe
                        } else if (details.delta.dy < -sensitivity) {
                          // Up Swipe
                          Get.to(GalleryPage(entities: entities));
                        }
                      },
                      child: Container(
                        color: Color.fromRGBO(0, 96, 162, .6),
                        height: 100,
                        width: Get.width,
                        margin: EdgeInsets.only(top: 10, bottom: 25),
                        padding: EdgeInsets.symmetric(horizontal: 5.5),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: entities == null ? 0 : entities.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 5.5),
                                color: Colors.white,
                                height: 80,
                                width: 80,
                                child: FutureBuilder(
                                  future: entities[i].thumbData,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    final bytes = snapshot.data;
                                    // If we have no data, display a spinner
                                    if (bytes == null)
                                      return CircularProgressIndicator();
                                    // If there's data, display it as an image
                                    return Image.memory(bytes,
                                        fit: BoxFit.cover);
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: Get.width,
                      padding: EdgeInsets.only(
                        bottom: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              iconSize: 25,
                              icon: SvgPicture.asset(
                                'assets/icons/opacity.svg',
                                height: 25,
                                width: 25,
                              ),
                              onPressed: () {}),
                          IconButton(
                            iconSize: 60,
                            icon: SvgPicture.asset(
                              'assets/icons/emptyCircle.svg',
                              height: 60,
                              width: 60,
                            ),
                            onPressed: () async {
                              XFile file = await controller.takePicture();
                              Get.to(PhotoPreview(file.path));
                            },
                          ),
                          IconButton(
                              iconSize: 25,
                              icon: SvgPicture.asset(
                                'assets/icons/refrech.svg',
                                height: 25,
                                width: 25,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
