import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
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
          backgroundColor: const Color(0xFF976775), title: const Text('Kategori Tanım')),
      endDrawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: tfKategoriAdi,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Kategori Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.branding_watermark_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Marka",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: const Text('Marka Seçiniz'),
                  items: [
                    const DropdownMenuItem(
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
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.model_training, color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Model",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: const Text('Model Seçiniz'),
                  items: [
                    const DropdownMenuItem(
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfBaseCategoryId,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number_sharp,
                          color: Color(0XFF6E3F52)),
                      hintText: "BaseCategoryId",
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.scatter_plot_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Birim",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: const Text('Birim Seçiniz'),
                  items: [
                    const DropdownMenuItem(
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
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.inventory_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Envanter Türü",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: const Text('Envanter Seçiniz'),
                  items: [
                    const DropdownMenuItem(
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfBarkod,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.barcode_reader,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Barkod",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_tree_outlined,
                          color: Color(0XFF6E3F52)),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Varyant",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  hint: const Text('Varyant Seçiniz'),
                  items: [
                    const DropdownMenuItem(
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0XFF463848),
                        side: const BorderSide(width: 1.0, color: Color(0XFF463848)),
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
                      child: (const Text(
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
