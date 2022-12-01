import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/model/Varyant.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';
import 'package:http/http.dart' as http;

class VaryantElemanTanim extends StatefulWidget {
  const VaryantElemanTanim({Key? key}) : super(key: key);

  @override
  State<VaryantElemanTanim> createState() => _VaryantElemanTanimState();
}

class _VaryantElemanTanimState extends State<VaryantElemanTanim> {
  var tfVaryantAdi = TextEditingController();
  var tfVaryantElemanAdi = TextEditingController();
  var dropdownvalue;

  Future<Varyant> varyantListele() async {
    http.Response res = await http
        .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Variants'));
    var cevap = Varyant.fromJson(json.decode(res.body));
    // print(cevap);
    // print(cevap.data[0].markaAdi);

    return cevap;
  }

  Future<void> varyantElemanEkle() async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/VariantElements');
    // print(dropdownvalue);
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder
            .convert({"variantId": dropdownvalue, "varyantElemanAdi": tfVaryantElemanAdi.text}));
    tfVaryantElemanAdi.text = "";

    print(response.body);
    print(response.statusCode);
    print(response.reasonPhrase);

    if(response.reasonPhrase == 'Bad Request' && response.body.contains('VariantElement already has')){
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Bu varyant elemanı zaten var."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    }
    else if(response.reasonPhrase == 'Bad Request'){
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant eleman adı boş bırakılamaz."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    }
    else if(response.reasonPhrase == 'Created'){
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant eleman ekleme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    }
  }

  Future<void> varyantElemanSil(int varyantId) async {
    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Variants/$varyantId');
    print(url);

    http.Response response = await http.delete(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'});
    print(response.statusCode);
    print(response.body);

    print(response.reasonPhrase);

    if(response.reasonPhrase == 'Not Found'){
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Silinecek varyant bulunamadı."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    }
    else if(response.reasonPhrase == 'Internal Server Error'){
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Silinmek istenen varyanta ait varyant elemanları tanımlı olduğu için silme işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    }
    else if(response.reasonPhrase == 'No Content'){
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant silme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    }
    setState(() {});
  }

  Future<void> varyantGuncelle(int varyantId) async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/Variants');

    http.Response response = await http.put(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder
            .convert({"id": varyantId, "varyantAdi": tfVaryantAdi.text}));
    tfVaryantAdi.text = "";

    print(response.statusCode);
    if (response.statusCode <= 299 || response.statusCode >= 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant güncelleme işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfVaryantAdi.text == "" || tfVaryantAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant adı boş olamaz."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Güncelleme gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Varyant Eleman Tanım')),
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
                    MaterialPageRoute(builder: (context) => IsTaslak()));
              },
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
      body:


      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                FutureBuilder<Varyant>(
                  future: varyantListele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          //   title: Text(snapshot.data!.data[index].markaAdi.toString()),
                          return DropdownButtonFormField(
                            hint: Row(
                              children: [
                                Icon(
                                  Icons.view_in_ar,
                                  color: Color(0XFF6E3F52),
                                ),
                                Text(
                                  ' Varyant Seçiniz',
                                  style: TextStyle(color: Color(0XFF976775)),
                                ),
                              ],
                            ),
                            items: snapshot.data!.data.map(
                                  (map) => DropdownMenuItem(
                                value: map.id,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(map.varyantAdi.toString(),
                                        style: TextStyle(
                                            color: Color(0XFF976775))),

                                    GestureDetector(
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Color(0XFF6E3F52),
                                      ),
                                      onTap: (){
                                        varyantElemanSil(map.id!);
                                      },
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.border_color_outlined,
                                        color: Color(0XFFAAA3B4),
                                      ),
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          body: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    'Lütfen güncellemek istediğiniz yeni varyant adını girin.',
                                                    style: GoogleFonts
                                                        .notoSansTaiLe(
                                                      fontSize: 15,
                                                      color:
                                                      Color(0XFF976775),
                                                    )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                TextField(
                                                  controller: tfVaryantAdi,
                                                  decoration:
                                                  InputDecoration(
                                                    hintText: 'Varyant Adı',
                                                    hintStyle: TextStyle(
                                                        color: Color(
                                                            0XFF976775)),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0XFF463848)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                AnimatedButton(
                                                    color:
                                                    Color(0XFF463848),
                                                    text: 'Güncelle',
                                                    pressEvent: () {
                                                      print(
                                                          tfVaryantAdi.text);
                                                      if (tfVaryantAdi.text ==
                                                          "") {
                                                        ScaffoldMessenger
                                                            .of(context)
                                                            .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                              Colors.red,
                                                              content: const Text(
                                                                  'Varyant adını boş bırakamazsınız.'),
                                                              duration:
                                                              const Duration(
                                                                  seconds:
                                                                  2),
                                                            ));
                                                      } else {
                                                        varyantGuncelle(
                                                            map.id!);
                                                        print(
                                                            "mapid:${map.id!}");
                                                        Navigator.pop(
                                                            context);
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                          dialogType: DialogType.noHeader,
                                          borderSide: const BorderSide(
                                            color: Color(0XFF6E3F52),
                                            width: 2,
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          buttonsBorderRadius:
                                          const BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          dismissOnTouchOutside: true,
                                          dismissOnBackKeyPress: false,
                                          headerAnimationLoop: false,
                                          animType: AnimType.bottomSlide,
                                          showCloseIcon: true,
                                        ).show();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                                .toList(),
                            onChanged: (newVal) {
                              setState(() {
                                dropdownvalue = newVal;
                              });
                            },
                            value: dropdownvalue,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: tfVaryantElemanAdi,
                  style: TextStyle(color: Color(0XFF976775)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.fitbit,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Varyant Eleman Adı",
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
                        varyantElemanEkle();

                      },
                      child: (Text(
                        'VARYANT ELEMAN EKLE',
                        style: TextStyle(
                            color: Color(0XFFDBDCE8),
                            fontSize: 15,
                            letterSpacing: 2.0),
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
