import 'package:hibescanner/sfg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'Sfc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String directory;
  List file = new List();
  MethodChannel channel = MethodChannel('opencv');
  File _file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  static GlobalKey<AnimatedListState> animatedListKey =
  GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("HibeScanner"),

      ),




      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text('Camera'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Sfc()),
                  );
                },
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                width: 3,
                height: 15,
              ),
              FlatButton(
                child: Text('Import from gallery'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Sfg ()),
                  );
                },
              )
            ],
          )),
      body: FutureBuilder(
          builder: (context, snapshot){
            return Container(
              child: ListView.builder(
                  itemCount: file.length,
                  itemBuilder: (BuildContext context, int index) {
                    _listofFiles();
                    return Card(
                      color: Colors.grey[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          ListTile(
                            leading: const Icon(Icons.picture_as_pdf,
                              color: Colors.white,),
                            title: Text(file[index].toString().substring(file[index].toString().lastIndexOf("/")+1).replaceAll("'",""),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FlatButton.icon(
                            color: Colors.grey[800],
                            icon: Icon(Icons.folder_open,
                              color: Colors.white,),
                            label: Text(
                              "Open pdf",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
      ),
    );
  }
  void _listofFiles() async {

    setState(() {
      file = io.Directory("$directory/HibeScanner/").listSync();  //use your folder name insted of resume.
    });
  }

}

