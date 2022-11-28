import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class ModelTanim extends StatefulWidget {
  const ModelTanim({Key? key}) : super(key: key);

  @override
  State<ModelTanim> createState() => _ModelTanimState();
}

class _ModelTanimState extends State<ModelTanim> {
  var tfModelAdi = TextEditingController();
  var marka;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Model Tanım')),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: const Color(0XFF6E3F52)),
              child: Text(' '),
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Color(0XFF976775),
              ),
              title: const Text(
                'TANIMLAMALAR',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF976775)),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Tanimlamalar()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Color(0XFF976775),
              ),
              title: const Text(
                'İŞLEM TASLAKLARI',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF976775)),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IsTaslak()));              },
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Color(0XFF976775),
              ),
              title: const Text(
                'ONAY İŞLEMLERİ',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF976775)),
              ),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => IsTaslak()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.branding_watermark_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Marka",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: Text('Marka Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                          'Marka Seçiniz',
                          style: TextStyle(color: Color(0XFF976775)),
                        )),
                  ],
                  onChanged: (newVal) {
                    setState(() {
                      marka = newVal;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfModelAdi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.model_training,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Model Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0XFF463848),
                        side: BorderSide(width: 1.0, color: Color(0XFF463848)),
                      ),
                      onPressed: () {
                        // kategori ekleme api
                        if(true){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            backgroundColor: Colors.green.shade300,
                            content: const Text(
                                'Model Eklendi'),
                            duration:
                            const Duration(seconds: 2),
                          ));
                        }
                      },
                      child: (Text(
                        'MODEL EKLE',
                        style: TextStyle(color: Color(0XFFDBDCE8), fontSize: 15, letterSpacing: 2.0),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
