import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:psicoapp/dao/db_util.dart';
import 'package:psicoapp/models/photo.dart';
import 'package:xml/xml.dart' as xml;
import 'package:psicoapp/models/action_m.dart';
import 'package:psicoapp/utils/app_routes.dart';

import '../utils/miscellaneous.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ActionM? page;
  var _photo;
  var img;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadData();
    await DbUtil.database();

    var photo = await DbUtil.read('photo');
    if (photo.isNotEmpty) {
      _photo =
          photo.map((item) => Photo(imageBase64: item['imageBase64'])).first;

      setState(() {
        img = Image.memory(base64Decode(_photo.imageBase64));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Miscellaneous.mainColor,
      body: SafeArea(
        child: page == null
            ? Center(
                child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
              )
            : Stack(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(AppRoutes.AVATAR),
                          child: img != null
                              ? Image(
                                  image: img.image,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : FluttermojiCircleAvatar(
                                  backgroundColor: Miscellaneous.mainColor,
                                  radius: 100,
                                ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 5),
                        child: Container(
                          constraints: BoxConstraints.tight(Size(150, 150)),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              page!.pageToGo.split('#')[0],
                              arguments: page!.pageToGo.split('#').length > 1
                                  ? page!.pageToGo.split('#')[1]
                                  : "",
                            ),
                            child: getLastEnableActionButton(page!),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  getLastEnableActionButton(ActionM action) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(action.images),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(4, 5, 0, 5),
            width: double.infinity,
            color: Color(0xCC555555),
            child: Text(
              action.title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    final xmlString = await rootBundle.loadString('assets/config.xml');
    final document = xml.XmlDocument.parse(xmlString);
    final config = document.findElements('config').first;
    final act_folders = config.findElements('act_folders').first;
    final item = act_folders.findElements('act_folder').last;

    final id = item.getAttributeNode('id')!.value;
    final title = item.getAttributeNode('title')!.value;
    final images = item.getAttributeNode('images')!.value;
    final pageToGo = item.getAttributeNode('pageToGo')!.value;
    setState(() {
      page = ActionM(
          id: int.parse(id), title: title, images: images, pageToGo: pageToGo);
    });
  }
}
