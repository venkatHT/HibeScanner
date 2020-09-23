import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/widgets.dart' as pw ;

import 'package:path/path.dart' as path;

import 'package:flutter/services.dart';

import 'image_editor_.dart';


class Sfg extends StatefulWidget {
  File filedit;
  File file;
  var imagePixelSize;
  double width;
  double height;
  Offset tl, tr, bl, br;
  GlobalKey<AnimatedListState> animatedListKey;

  Sfg({this.filedit});

  @override
  _SfgState createState() => _SfgState();
}

class _SfgState extends State<Sfg> {
  TextEditingController nameController = TextEditingController();
  MethodChannel channel = new MethodChannel('opencv');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 0;
  bool isBottomOpened = false;
  PersistentBottomSheetController controller;
  var whiteboardBytes;
  var originalBytes;
  var grayBytes;
  bool isGrayBytes = false;
 

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      images.forEach((imageAsset) async{
        final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          imgFile.add(tempFile);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Gallery"),
        centerTitle: true,
        actions: <Widget>[
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){getimageditor();},
              icon: Icon(Icons.edit,
                color: Colors.white,),
            ),
          ),
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){delItem();},
              icon: Icon(Icons.delete,
                color: Colors.white,),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () async {
          loadAssets();
        },

        child: Icon(Icons.photo),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Expanded(
            flex: 9,
            child: Container(
              child: images.isEmpty?Center(child: Text(
                "Select Images to display here",
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontSize: 18,

                ),
              ),
              )
                  :GridView.count(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,
                children: List.generate(imgFile.length, (index){
                  File file = imgFile[index];
                  return new Card(
                    child: new InkResponse(
                      child: Image.file(file),
                      onTap: (){_toggle(index);},
                    ),
                  
    );
                  for(int i=0;i<imgFile.length;i++){
                    img.add(PdfImage.file(
                      pdf.document,
                      bytes: imgFile[i].readAsBytesSync(),));
                    pdf.addPage(
                        pw.Page(
                            build: (pw.Context context){
                              return pw.Column(

                                children: <pw.Widget>[
                                  pw.Expanded(
                                    flex: 30,
                                    child: pw.Container(
                                      child: pw.Center(
                                        child: pw.Image(img[i]),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      child: pw.Text(
                                          "HIBESCANNER",
                                      ),
                                    ),
                                  ),

                                ],
                              );

                            }
                        ));
                  }
                  try{
                    print("creating folder");
                    final tempDir = await getExternalStorageDirectory();
             
                  "Convert to PDF",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




