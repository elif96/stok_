import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/myColors.dart';

class VaryantTanim extends StatefulWidget {
  const VaryantTanim({Key? key}) : super(key: key);

  @override
  State<VaryantTanim> createState() => _VaryantTanimState();
}



class _VaryantTanimState extends State<VaryantTanim> {

  Future<void> varyantEkle(String varyantAdi) async {
    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Variants');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "varyantAdi": varyantAdi
        }));
    varyantAdi = "";

    print(response.body);
    print(response.statusCode);
    print(response.reasonPhrase);

    if(tfVaryantAdi.text ==""){
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen varyant adı girin."),
        backgroundColor: Colors.red,
      ));
      tfVaryantAdi.clear();
      setState(() {});
    }
    else if(response.reasonPhrase == 'Bad Request'){
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Eklemek istediğiniz varyant zaten var."),
        backgroundColor: Colors.red,
      ));
      tfVaryantAdi.clear();
      setState(() {});
    }
    else if(response.reasonPhrase == 'Created'){
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Varyant ekleme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
      setState(() {});
    }

  }

  var tfVaryantAdi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: myColors.topColor, title: const Text('Varyant Tanım')),
      endDrawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: tfVaryantAdi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.view_in_ar,
                        color: myColors.baslikColor,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Varyant Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: myColors.baslikColor))),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: myColors.baslikColor,
                        side: BorderSide(width: 1.0, color: myColors.baslikColor),
                      ),
                      onPressed: () {
                        varyantEkle(tfVaryantAdi.text);


                      },
                      child: (const Text(
                        'VARYANT EKLE',
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
