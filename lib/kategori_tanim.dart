import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
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
          backgroundColor: myColors.topColor, title: const Text('Kategori Tanım')),
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
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: myColors.topColor,
                      ),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Kategori Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.branding_watermark_outlined,
                          color: myColors.baslikColor),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Marka",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                  hint: const Text('Marka Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Marka Seçiniz',
                      style: TextStyle(color: myColors.baslikColor),
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
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.model_training, color: myColors.baslikColor),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Model",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                  hint: const Text('Model Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Model Seçiniz',
                      style: TextStyle(color: myColors.baslikColor),
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
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number_sharp,
                          color: myColors.baslikColor),
                      hintText: "BaseCategoryId",
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.scatter_plot_outlined,
                          color: myColors.baslikColor),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Birim",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                  hint: const Text('Birim Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Birim Seçiniz',
                      style: TextStyle(color: myColors.baslikColor),
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
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.inventory_outlined,
                          color: myColors.baslikColor),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Envanter Türü",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                  hint: const Text('Envanter Seçiniz'),
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      'Envanter Türü Seçiniz',
                      style: TextStyle(color: myColors.baslikColor),
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
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.barcode_reader,
                        color: myColors.baslikColor,
                      ),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Barkod",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.account_tree_outlined,
                          color: myColors.baslikColor),
                      hintStyle: TextStyle(color: myColors.baslikColor),
                      hintText: "Varyant",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                  hint: const Text('Varyant Seçiniz'),
                  items: [
                     DropdownMenuItem(
                        child: Text(
                      'Varyant Seçiniz',
                      style: TextStyle(color: myColors.baslikColor),
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
                        backgroundColor: myColors.baslikColor,
                        side: BorderSide(width: 1.0, color: myColors.baslikColor),
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
                      child: ( Text(
                        'KATEGORİ EKLE',
                        style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 2.0),
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
