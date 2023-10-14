import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;
import '../../components/psychoeducation/psychoeducation_item.dart';
import '../../models/psychoeducation.dart';

class PsychoeducationPage extends StatefulWidget {
  const PsychoeducationPage({super.key});

  @override
  State<PsychoeducationPage> createState() => _PsychoeducationPageState();
}

class _PsychoeducationPageState extends State<PsychoeducationPage> {
  List<Psychoeducation> ps = [];
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psicoeducação'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ps.isEmpty
            ? Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: ps.map((e) {
                    return PsychoeducationItem(e);
                  }).toList(),
                ),
              ),
      ),
    );
  }

  Future<void> _loadData() async {
    List<Psychoeducation> p = [];
    final xmlString = await rootBundle.loadString('assets/config.xml');
    final document = xml.XmlDocument.parse(xmlString);
    final config = document.findElements('config').first;
    final pe_texts = config.findElements('pe_texts').first;
    final pe_items = pe_texts.findElements('pe_item');

    for (final pe_item in pe_items) {
      final id = pe_item.getAttributeNode('id')!.value;
      final title = pe_item.getAttributeNode('title')!.value;
      final folder = pe_item.getAttributeNode('folder')!.value;
      final text = pe_item.getAttributeNode('text')!.value;
      final images = pe_item.getAttributeNode('images')!.value;
      final reference = pe_item.getAttributeNode('reference')!.value;
      final hasQuestions = pe_item.getAttributeNode('hasQuestions')!.value;
      p.add(Psychoeducation(
        id: int.parse(id),
        title: title,
        folder: folder,
        text: text,
        images: images,
        reference: reference,
        hasQuestions: hasQuestions == "0" ? false : true,
      ));
    }
    setState(() => ps = p);
  }
}
