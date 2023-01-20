import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/Variant.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/myData.dart';

class VaryantElemanTanim extends StatefulWidget {
  const VaryantElemanTanim({Key? key}) : super(key: key);

  @override
  State<VaryantElemanTanim> createState() => _VaryantElemanTanimState();
}

class _VaryantElemanTanimState extends State<VaryantElemanTanim> {
  var tfVaryantAdi = TextEditingController();
  var tfVaryantElemanAdi = TextEditingController();
  var dropdownvalue;
  var trimmedValue;

  var cevap;
  late myData<Variant> cevaps;

  Future<myData<Variant>> varyanListeleWithFilter(String VaryantAdiFilter, int Page,
      int PageSize, String Orderby, bool Desc, bool isDeleted) async {
    //https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=a&Page=1&PageSize=12&Orderby=Id&Desc=false

    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Variants/GetAll?VaryantAdiFilter=${VaryantAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    cevaps = myData<Variant>.fromJson(json.decode(res.body), Variant.fromJsonModel);
    // print('----*');
    // print(res.body);
    // print(cevaps.data);
    // print('----');

    return cevaps;
  }

  Future<void> varyantElemanEkle() async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/VariantElements');
    print(dropdownvalue);
    if(dropdownvalue == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir varyant seçin."),
        backgroundColor: Colors.red,
      ));
    }
    else{
      trimmedValue = ((((dropdownvalue.replaceAll('[', '')).replaceAll(']', ''))
          .replaceAll('<', ''))
          .replaceAll('>', ''))
          .replaceAll("'", '');
    }

    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "variantId": trimmedValue,
          "varyantElemanAdi": tfVaryantElemanAdi.text
        }));
    print(trimmedValue);
    print(tfVaryantElemanAdi.text);
    // tfVaryantElemanAdi.text = "";
    print(response.body);
    if (response.reasonPhrase == 'Bad Request' &&
        response.body.contains('VariantElement already has')) {
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bu varyant elemanı zaten var."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'Bad Request') {
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Varyant eleman adı boş bırakılamaz."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'Created') {
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Varyant eleman ekleme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    }
  }

  Future<void> varyantElemanSil(int varyantId) async {
    var url =
        Uri.parse('https://stok.bahcelievler.bel.tr/api/Variants/$varyantId');
    print(url);

    http.Response response = await http.delete(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'});
    print(response.statusCode);
    print(response.body);

    print(response.reasonPhrase);

    if (response.reasonPhrase == 'Not Found') {
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Silinecek varyant bulunamadı."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'Internal Server Error') {
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Silinmek istenen varyanta ait varyant elemanları tanımlı olduğu için silme işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'No Content') {
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Varyant güncelleme işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfVaryantAdi.text == "" || tfVaryantAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Varyant adı boş olamaz."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Güncelleme gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
    }
  }

  void showGuncellemeDialog(int trimmedValue) {
    AwesomeDialog(
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text('Lütfen güncellemek istediğiniz yeni marka adını girin.',
                style: GoogleFonts.notoSansTaiLe(
                  fontSize: 15,
                  color: const Color(0XFF976775),
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: tfVaryantElemanAdi,
              decoration: const InputDecoration(
                hintText: 'Varyant Adı',
                hintStyle: TextStyle(color: Color(0XFF976775)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedButton(
                color: const Color(0XFF463848),
                text: 'Güncelle',
                pressEvent: () {
                  print(tfVaryantElemanAdi.text);
                  if (tfVaryantElemanAdi.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Varyant eleman adını boş bırakamazsınız.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    print('TTT');
                    print(trimmedValue);
                    varyantGuncelle(trimmedValue);
                    print(trimmedValue);
                    Navigator.pop(context);
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
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
    ).show();
  }

  int pageNum = 1;
  int pageSize = 5;
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: const Color(0xFF976775),
          title: const Text('Varyant Eleman Tanım')),
      endDrawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                FutureBuilder<myData<Variant>>(
                  future:
                  varyanListeleWithFilter('', pageNum, pageSize, 'Id', true,false),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
                          return SearchField<myData<Variant>>(
                            autoCorrect: true,
                            hint: 'Varyant Seçiniz',
                            onSuggestionTap: (e) {
                              dropdownvalue = e.searchKey;
                              setState(() {
                                dropdownvalue = e.key.toString();
                              });
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle: const TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                            const TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data!.data!
                                .map(
                                  (e) => SearchFieldListItem<myData<Variant>>(

                                  e.varyantAdi.toString(),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.varyantAdi.toString(),
                                            style: const TextStyle(
                                                color: Color(0XFF6E3F52))),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            child: const Text('Load More'),

                                            onTap: () {
                                              // pageNum +=1;
                                              print("e: ${e.varyantAdi}");


                                              pageSize += 5;

                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: const Icon(
                                              Icons.delete_outline,
                                              color: Color(0XFF6E3F52),
                                            ),
                                            onTap: () {
                                              varyantElemanSil(e.id!);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            child: const Icon(
                                              Icons.border_color_outlined,
                                              color: Color(0XFF6E3F52),
                                            ),
                                            onTap: () {
                                              showGuncellemeDialog(e.id!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  key: Key(e.id.toString())),
                            )
                                .toList(),
                          );


                        },
                      );
                    } else if (!(snapshot.hasError)) {
                      return SearchField(
                        suggestions: [],
                      ).emptyWidget;
                    }
                    return const CircularProgressIndicator(
                      color: Color(0XFF976775),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfVaryantElemanAdi,
                  style: const TextStyle(color: Color(0XFF976775)),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.model_training,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Varyant Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
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
                        varyantElemanEkle();
                      },
                      child: (const Text(
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
