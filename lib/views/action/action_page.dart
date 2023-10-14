import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psicoapp/models/action_m.dart';
import 'package:xml/xml.dart' as xml;
import '../../components/action/action_item.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  List<ActionM> ac = [];
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plano de Ação'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ac.isEmpty
            ? Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : GridView(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 170,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 10,
                ),
                children: ac.map((e) {
                  return ActionItem(e);
                }).toList(),
              ),
      ),
    );
  }

  Future<void> _loadData() async {
    List<ActionM> a = [];
    final xmlString = await rootBundle.loadString('assets/config.xml');
    final document = xml.XmlDocument.parse(xmlString);
    final config = document.findElements('config').first;
    final act_folders = config.findElements('act_folders').first;
    final act_folder = act_folders.findElements('act_folder');

    for (final item in act_folder) {
      final id = item.getAttributeNode('id')!.value;
      final title = item.getAttributeNode('title')!.value;
      final images = item.getAttributeNode('images')!.value;
      final pageToGo = item.getAttributeNode('pageToGo')!.value;
      a.add(ActionM(
          id: int.parse(id), title: title, images: images, pageToGo: pageToGo));
    }

    setState(() => ac = a);
  }
}
