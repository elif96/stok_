import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class KategoriTanim extends StatefulWidget {
  const KategoriTanim({Key? key}) : super(key: key);

  @override
  State<KategoriTanim> createState() => _KategoriTanimState();
}

class _KategoriTanimState extends State<KategoriTanim> {
  var tfKategoriAdi = TextEditingController();
  var marka;
  var model;
  var tfBaseCategoryId = TextEditingController();
  var birim;
  var envarterTuru;
  var tfBarkod = TextEditingController();
  var varyant;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Kategori Tanım')),
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
                TextFormField(
                  controller: tfKategoriAdi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Kategori Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
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
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.model_training, color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Model",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: Text('Model Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Model Seçiniz',
                      style: TextStyle(color: Color(0XFF976775)),
                    ))
                  ],
                  onChanged: (newVal) {
                    setState(() {
                      model = newVal;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfBaseCategoryId,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number_sharp,
                          color: Color(0XFF6E3F52)),
                      hintText: "BaseCategoryId",
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.scatter_plot_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Birim",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: Text('Birim Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Birim Seçiniz',
                      style: TextStyle(color: Color(0XFF976775)),
                    ))
                  ],
                  onChanged: (newVal) {
                    setState(() {
                      birim = newVal;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.inventory_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Envanter Türü",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: Text('Envanter Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Envanter Türü Seçiniz',
                      style: TextStyle(color: Color(0XFF976775)),
                    ))
                  ],
                  onChanged: (newVal) {
                    setState(() {
                      envarterTuru = newVal;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfBarkod,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.barcode_reader,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Barkod",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_tree_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Varyant",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: Text('Varyant Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Varyant Seçiniz',
                      style: TextStyle(color: Color(0XFF976775)),
                    )),
                  ],
                  onChanged: (newVal) {
                    setState(() {
                      varyant = newVal;
                    });
                  },
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
                                'Kategori Eklendi'),
                            duration:
                            const Duration(seconds: 2),
                          ));
                        }
                      },
                      child: (Text(
                        'KATEGORİ EKLE',
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
