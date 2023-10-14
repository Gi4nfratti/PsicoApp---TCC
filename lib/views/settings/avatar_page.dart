import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psicoapp/components/alert.dart';
import 'package:psicoapp/dao/db_util.dart';
import 'package:psicoapp/data/test_data.dart';
import 'package:psicoapp/models/photo.dart';
import 'package:psicoapp/utils/miscellaneous.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  var _storedImage;
  var _photo;
  var img;
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  Future<void> _saveAvatar(BuildContext context) async {
    final value = await FluttermojiFunctions().encodeMySVGtoString();
    print(value);
  }

  _takePicture() async {
    try {
      XFile imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      ) as XFile;

      setState(() {
        _storedImage = File(imageFile.path);
      });

      String base64File = base64Encode(_storedImage.readAsBytesSync());
      Map<String, Object> data = {'imageBase64': base64File};

      if (await DbUtil.read('photo').then((value) => value.isEmpty))
        await DbUtil.insert('photo', data);
      else
        await DbUtil.update('photo', data);
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: "Ocorreu um erro!", desc: "Ocorreu um erro ao salvar."));
    } finally {
      _isLoading = false;
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var photo = await DbUtil.read('photo');
    if (photo.isNotEmpty) {
      _photo =
          photo.map((item) => Photo(imageBase64: item['imageBase64'])).first;

      setState(() {
        img = Image.memory(base64Decode(_photo.imageBase64));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _storedImage != null || _photo != null
            ? Text("Foto")
            : Text("Avatar"),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.camera_alt_rounded, size: 30),
            ),
            color: Colors.white,
            onPressed: () => _takePicture(),
          ),
          _enableDisableSaveAvatar()
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_SwitchAvatarAndPhoto()],
          ),
        ),
      ),
    );
  }

  var emoji = FluttermojiCustomizer(
    attributeTitles: [...avatarTitles],
    theme: FluttermojiThemeData(
      labelTextStyle: TextStyle(fontFamily: 'Poppins', color: Colors.black87),
      primaryBgColor: Miscellaneous.mainColor,
      secondaryBgColor: Miscellaneous.mainColor,
      selectedIconColor: Colors.yellow,
      unselectedIconColor: Colors.black,
      iconColor: Colors.yellow,
    ),
  );

  _enableDisableSaveAvatar() {
    if (_storedImage == null && _photo == null) {
      return FluttermojiSaveWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.save,
            size: 30,
            color: Colors.white,
          ),
        ),
        onTap: () => _saveAvatar(context),
      );
    } else {
      return IconButton(
        onPressed: () async {
          await DbUtil.delete('photo');
          setState(() {
            _storedImage = null;
            _photo = null;
            _SwitchAvatarAndPhoto();
          });
        },
        icon: Icon(Icons.delete, size: 30),
      );
    }
  }

  Widget _SwitchAvatarAndPhoto() {
    Widget w;
    if (_storedImage == null && _photo == null) {
      w = Column(children: [
        FluttermojiCircleAvatar(
          backgroundColor: Miscellaneous.mainColor,
          radius: 100,
        ),
        SizedBox(
          height: 50,
        ),
        emoji,
      ]);
    } else {
      w = _isLoading
          ? CircularProgressIndicator(
              color: Colors.blue,
            )
          : Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: img != null
                    ? Image(
                        image: img.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _storedImage!,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
              ),
            );
    }
    return w;
  }
}
