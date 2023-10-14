import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:psicoapp/dao/db_util.dart';
import 'package:psicoapp/models/photo.dart';
import 'package:psicoapp/utils/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/settings/profile_menu.dart';
import '../../utils/miscellaneous.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _photo;
  var img;
  var _name;
  bool _imgLoaded = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var photo = await DbUtil.read('photo');
    if (photo.isNotEmpty) {
      _photo =
          photo.map((item) => Photo(imageBase64: item['imageBase64'])).first;

      setState(() {
        img = Image.memory(base64Decode(_photo.imageBase64));
      });
    }

    var name = await DbUtil.read('register');

    if (name.isNotEmpty) {
      _name = name.map((item) => item['nome']).first;
    }

    setState(() {
      _imgLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: !_imgLoaded
                      ? CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : img != null
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
            SizedBox(height: 30),
            !_imgLoaded
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    _name ?? "Olá Usuário",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 30),
                  ),
            SizedBox(height: 50),
            ProfileMenu(
              text: "Editar cadastro",
              icon: Icon(Icons.task_alt_rounded),
              press: () => Navigator.of(context).pushNamed(AppRoutes.REGISTER),
            ),
            ProfileMenu(
                text: "Alterar avatar",
                icon: Icon(Icons.person_rounded),
                press: () => Navigator.of(context).pushNamed(AppRoutes.AVATAR)),
            ProfileMenu(
                text: "Preencher escala",
                icon: Icon(Icons.list_alt_rounded),
                press: () => Navigator.of(context).pushNamed(AppRoutes.SCALE)),
            ProfileMenu(
              text: "Diário de emoções",
              icon: Icon(Icons.schedule_rounded),
              press: () => Navigator.of(context).pushNamed(
                AppRoutes.MOOD_HISTORY,
              ),
            ),
            ProfileMenu(
                text: "Sobre o PsicoApp",
                icon: Icon(Icons.schedule_rounded),
                press: () async {
                  Uri uri = Uri.parse('https://www.youtube.com/@PsicoApp');
                  try {
                    await launchUrl(uri, mode: LaunchMode.inAppWebView);
                  } catch (error) {
                    print(error);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
