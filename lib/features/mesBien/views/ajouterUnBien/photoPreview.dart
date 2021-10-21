import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';

class PhotoPreview extends StatefulWidget {
  final image;
  PhotoPreview(this.image);

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  List<String> filters = [
    'Aucun',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
    'filter',
  ];

  bool showFilters = false;

  int selectedFilter = 0;

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.crop,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.auto_fix_high,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  showFilters = !showFilters;
                });
              }),
          IconButton(
              icon: Icon(
                Icons.edit_rounded,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
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
      body: Column(
        children: [
          Expanded(child: Image.file(File(widget.image))),
          Container(
            height: showFilters ? 160 : 100,
            color: Color(0xff0060A2),
            padding: EdgeInsets.only(top: showFilters ? 15 : 20, left: 20),
            child: showFilters
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (ctx, i) {
                      return buildFilterCard(
                          index: i,
                          title:
                              filters[i] + (i != 0 ? '  ' + i.toString() : ''));
                    },
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'annuler'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Multi',
                              height: 1.1,
                              letterSpacing: 0.77,
                            ),
                          )),
                      IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                      TextButton(
                        onPressed: () async {
                          if (0 == counter++) {
                            AjoutFormController ajoutFormController =
                                Get.find();
                            await ajoutFormController
                                .setPhoto(File(widget.image));

                            Get.offNamedUntil(Routes.monBienPage,
                                ModalRoute.withName(Routes.bienOverviewPage));
                          }
                        },
                        child: Text(
                          'confirmer'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Multi',
                            height: 1.1,
                            letterSpacing: 0.77,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget buildFilterCard({String title, int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        height: 130,
        width: 70,
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Image.file(File(widget.image)),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                height: 30,
                width: 70,
                color: Color.fromRGBO(3, 3, 3, .73),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Multi',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            if (selectedFilter == index)
              Positioned(
                  right: 4,
                  top: 6,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Color.fromRGBO(30, 197, 1, 1),
                  ))
          ],
        ),
      ),
    );
  }
}
