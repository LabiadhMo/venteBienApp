import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/photoPreview.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key key, this.entities}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
  final List<AssetEntity> entities;
}

class _GalleryPageState extends State<GalleryPage> {
  final int now = DateTime.now().month;
  int monthCount = DateTime.now().month;
  String path = "";
  int selectedPic;
  Map widgets;
  Map<String, List<AssetEntity>> m = {};
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.entities.length; i++) {
      if (m.keys != null) if (m.keys
          .contains(widget.entities[i].createDateTime.month.toString()))
        m[widget.entities[i].createDateTime.month.toString()]
            .add(widget.entities[i]);
      else
        m.putIfAbsent(widget.entities[i].createDateTime.month.toString(),
            () => [widget.entities[i]]);
      else
        m.putIfAbsent(widget.entities[i].createDateTime.month.toString(),
            () => [widget.entities[i]]);
    }
    setState(() {
      dataLoaded = true;
    });
  }

  lastMonth() {
    if (monthCount-- == 0) monthCount = 12;
  }

  bool dataLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.kgradient2,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sélectionner des photos'.toUpperCase(),
            style: AppTheme.appBarTitleTextStyle,
          ),
        ),
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
          dataLoaded == false
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: m.length,
                    itemBuilder: (c, index) {
                      print(index.toString() +
                          'key' +
                          m.keys.elementAt(index) +
                          'vv' +
                          (((Get.width - 50) / 4) + 20).toString());
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                m.values
                                            .elementAt(index)
                                            .elementAt(0)
                                            .createDateTime
                                            .month ==
                                        DateTime.now().month
                                    ? 'Récent'.toUpperCase()
                                    : DateFormat.MMMM()
                                        .format(m.values
                                            .elementAt(index)
                                            .elementAt(0)
                                            .createDateTime
                                            .toLocal())
                                        .toString()
                                        .toUpperCase(),
                                style: AppTheme.formTitleBlackBoldTextStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Container(
                            height: (((Get.width - 50) / 4) + 20) *
                                m.values.elementAt(index).length /
                                4,
                            child: buildGalleryGrid(
                              entities: m.values.elementAt(index),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
          Container(
            height: 100,
            color: Color(0xff0060A2),
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
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
                  onPressed: () {
                    if (path.length > 0) Get.to(PhotoPreview(path));
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
          ),
        ],
      ),
    );
  }

  GridView buildGalleryGrid({List<AssetEntity> entities}) {
    return GridView.builder(
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // A grid view with 4 items per row
        crossAxisCount: 4,
      ),
      itemCount: entities.length,
      padding: EdgeInsets.all(5),
      itemBuilder: (_, index) {
        return FutureBuilder(
          future: entities[index].thumbData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final bytes = snapshot.data;
            // If we have no data, display a spinner
            if (bytes == null) return CircularProgressIndicator();
            // If there's data, display it as an image
            return GetBuilder<AjoutFormController>(
                id: 'pictureSelected',
                builder: (_) {
                  return InkWell(
                    onTap: () {
                      entities[index].file.then((value) => path = value.path);
                      print(index.toString());
                      _.setSelectedPic(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 95,
                          width: 95,
                          padding: const EdgeInsets.all(5.0),
                          decoration: _.selectedPic != null
                              ? _.selectedPic.value == index
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff1EC501), width: 3))
                                  : null
                              : null,
                          child: Image.memory(bytes, fit: BoxFit.cover),
                        ),
                        if (_.selectedPic != null)
                          if (index == _.selectedPic.value)
                            Positioned(
                              right: 8,
                              top: 2,
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xff1EC501),
                              ),
                            )
                      ],
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
