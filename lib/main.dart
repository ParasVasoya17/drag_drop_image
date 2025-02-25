import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DragDropImageWeb()));
}

class DragDropImageWeb extends StatefulWidget {
  const DragDropImageWeb({super.key});

  @override
  State<DragDropImageWeb> createState() => _DragDropImageWebState();
}

class _DragDropImageWebState extends State<DragDropImageWeb> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    _setupDragDrop();
  }

  void _setupDragDrop() {
    html.document.body?.onDragOver.listen((event) {
      event.preventDefault();
    });

    html.document.body?.onDrop.listen(
      (event) async {
        event.preventDefault();

        if (event.dataTransfer.files?.isNotEmpty ?? false) {
          final file = event.dataTransfer.files!.first;

          final reader = html.FileReader();
          reader.readAsArrayBuffer(file);
          reader.onLoadEnd.listen(
            (_) {
              setState(() {
                imageData = reader.result as Uint8List;
              });
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drag & Drop Image in Flutter Web")),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.black),
          ),
          child: imageData != null ? Image.memory(imageData!) : const Center(child: Text("Drag & Drop an Image Here")),
        ),
      ),
    );
  }
}
