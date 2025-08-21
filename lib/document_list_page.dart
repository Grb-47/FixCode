import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DocumentListPage extends StatelessWidget {
  final List<Map<String, String>> documents = [
    {"language": "C", "file": "C_Doc.pdf"},
    {"language": "C++", "file": "CPP_Doc.pdf"},
    {"language": "Java", "file": "Java_Doc.pdf"},
    {"language": "Python", "file": "Python_Doc.pdf"},
    {"language": "Flutter", "file": "Flutter_Doc.pdf"},
    {"language": "Dart", "file": "Dart_Doc.pdf"},
    {"language": "JavaScript", "file": "JS_Doc.pdf"},
    {"language": "Gourab's", "file": "GRB_Doc.pdf"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Documents"),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.redAccent),
              title: Text(
                "${documents[index]["language"]} Document",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Filename: ${documents[index]["file"]}"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerPage(
                      pdfPath: "assets/pdfs/${documents[index]["file"]}",
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DocumentViewerPage extends StatefulWidget {
  final String pdfPath;

  const DocumentViewerPage({super.key, required this.pdfPath});

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  String localPath = "";

  @override
  void initState() {
    super.initState();
    copyAssetToLocal();
  }

  Future<void> copyAssetToLocal() async {
    final data = await rootBundle.load(widget.pdfPath);
    final bytes = data.buffer.asUint8List();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${widget.pdfPath.split('/').last}');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: localPath.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPath),
    );
  }
}
