import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/TextSearchResultItem.dart';
import 'package:stok_takip_uygulamasi/model/Variant.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
import 'package:textfield_search/textfield_search.dart';

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

  List<Variant>? cevapData = [];
  myData<Variant> cevapSon = myData<Variant>();
  var variantid;
  final _searchController2 = TextEditingController();
  final _variantController = TextEditingController();

  Future<List> variantListeleWithFilter(
      int page, int pageSize, String orderby, bool desc) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Variants/GetAll?VaryantAdiFilter=${_searchController2.text}&Page=${page}&PageSize=${pageSize}&Orderby=${orderby}&Desc=${desc}'));

    List cevapData2 = <dynamic>[];
    var d =
        myData<Variant>.fromJson(json.decode(res.body), Variant.fromJsonModel);
    print("cevapData2 ${d.data}");
    if (d.data!.isNotEmpty) {
      var items =
          myData<Variant>.fromJson(json.decode(res.body), Variant.fromJsonModel)
              .data!;

      for (var el in items) {
        var obj2 = TextSearchResultItem.fromJson(
            {"label": el.varyantAdi, "value": el.id});
        cevapData2.add(obj2);
        // modelid = el.id;
      }

      return cevapData2;
    }

    return cevapData2;
  }

  // Future<myData<Variant>> varyanListeleWithFilter(String VaryantAdiFilter, int Page,
  //     int PageSize, String Orderby, bool Desc, bool isDeleted) async {
  //   //https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=a&Page=1&PageSize=12&Orderby=Id&Desc=false
  //
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/Variants/GetAll?VaryantAdiFilter=${VaryantAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
  //   cevaps = myData<Variant>.fromJson(json.decode(res.body), Variant.fromJsonModel);
  //   // print('----*');
  //   // print(res.body);
  //   // print(cevaps.data);
  //   // print('----');
  //
  //   return cevaps;
  // }

  Future<void> varyantElemanEkle(int variantid) async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/VariantElements');

    if (variantid == null || variantid == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir varyant seçin."),
        backgroundColor: Colors.red,
      ));
    }


    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "variantId": variantid,
          "varyantElemanAdi": _variantController.text
        }));
    if (_variantController.text == "" || _variantController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen model adı girin."),
        backgroundColor: Colors.red,
      ));
    }
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
      Navigator.pop(context);
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
            .convert({"id": varyantId, "varyantAdi": tfVaryantElemanAdi.text}));
    // tfVaryantAdi.text = "";

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
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  color: myColors.baslikColor,
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _variantController,
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedButton(
                color: myColors.baslikColor,
                text: 'Güncelle',
                pressEvent: () {
                  print(tfVaryantElemanAdi.text);

                })
          ],
        ),
      ),
      dialogType: DialogType.noHeader,
      borderSide: BorderSide(
        color: myColors.baslikColor,
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
          backgroundColor: myColors.topColor,
          title: const Text('Varyant Eleman Tanım')),
      endDrawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldSearch(
                label: 'Complex Future List',
                controller: _searchController2,
                future: () {
                  return variantListeleWithFilter(1, 1000, 'Id', true);
                },
                getSelectedValue: (item) {
                  variantid = item.value;

                  if (kDebugMode) {
                    print("getSelectedValue ${item.value}");
                  }
                  variantid = item.value;
                },
                minStringLength: 5,
                textStyle: TextStyle(color: myColors.baslikColor),
                decoration: const InputDecoration(hintText: 'Varyant Arayın'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _variantController,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: myColors.baslikColor,
                      side: BorderSide(
                          width: 1.0, color: myColors.baslikColor),
                    ),
                    onPressed: () {
                      print(variantid);
                      varyantElemanEkle(variantid);
                    },
                    child: (const Text(
                      'VARYANT EKLE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 2.0),
                    ))),
              ),
            ],
          ),

          // child: Form(
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: [
          //       FutureBuilder<myData<Variant>>(
          //         future:
          //         variantListeleWithFilter('', pageNum, pageSize, 'Id', true,false),
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             return ListView.builder(
          //               controller: _controller,
          //               shrinkWrap: true,
          //               itemCount: 1,
          //               itemBuilder: (context, index) {
          //                 // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
          //                 return SearchField<myData<Variant>>(
          //                   autoCorrect: true,
          //                   hint: 'Varyant Seçiniz',
          //                   onSuggestionTap: (e) {
          //                     dropdownvalue = e.searchKey;
          //                     setState(() {
          //                       dropdownvalue = e.key.toString();
          //                     });
          //                   },
          //                   suggestionAction: SuggestionAction.unfocus,
          //                   itemHeight: 50,
          //                   searchStyle: TextStyle(color: myColors.baslikColor),
          //                   suggestionStyle:
          //                   TextStyle(color: myColors.baslikColor),
          //                   // suggestionsDecoration: BoxDecoration(color: Colors.red),
          //                   suggestions: snapshot.data!.data!
          //                       .map(
          //                         (e) => SearchFieldListItem<myData<Variant>>(
          //
          //                         e.varyantAdi.toString(),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                           children: [
          //
          //                             Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Text(e.varyantAdi.toString(),
          //                                   style: TextStyle(
          //                                       color: myColors.baslikColor)),
          //                             ),
          //                             Row(
          //                               children: [
          //                                 GestureDetector(
          //                                   child: const Text('Load More'),
          //
          //                                   onTap: () {
          //                                     // pageNum +=1;
          //                                     print("e: ${e.varyantAdi}");
          //
          //
          //                                     pageSize += 5;
          //
          //                                     setState(() {});
          //                                   },
          //                                 ),
          //                                 GestureDetector(
          //                                   child: Icon(
          //                                     Icons.delete_outline,
          //                                     color: myColors.baslikColor,
          //                                   ),
          //                                   onTap: () {
          //                                     varyantElemanSil(e.id!);
          //                                   },
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 10,
          //                                 ),
          //                                 GestureDetector(
          //                                   child: Icon(
          //                                     Icons.border_color_outlined,
          //                                     color: myColors.baslikColor,
          //                                   ),
          //                                   onTap: () {
          //                                     showGuncellemeDialog(e.id!);
          //                                   },
          //                                 ),
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                         key: Key(e.id.toString())),
          //                   )
          //                       .toList(),
          //                 );
          //
          //
          //               },
          //             );
          //           } else if (!(snapshot.hasError)) {
          //             return SearchField(
          //               suggestions: [],
          //             ).emptyWidget;
          //           }
          //           return CircularProgressIndicator(
          //             color: myColors.baslikColor,
          //           );
          //         },
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       TextFormField(
          //         controller: tfVaryantElemanAdi,
          //         style: TextStyle(color: myColors.baslikColor),
          //         decoration: InputDecoration(
          //             prefixIcon: Icon(
          //               Icons.model_training,
          //               color: myColors.baslikColor,
          //             ),
          //             hintStyle: TextStyle(color: myColors.baslikColor),
          //             hintText: "Varyant Adı",
          //             border: OutlineInputBorder(
          //                 borderSide: BorderSide(color: myColors.baslikColor))),
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Container(
          //         height: 50,
          //         child: OutlinedButton(
          //             style: OutlinedButton.styleFrom(
          //               backgroundColor: myColors.baslikColor,
          //               side: BorderSide(width: 1.0, color: myColors.baslikColor),
          //             ),
          //             onPressed: () {
          //               varyantElemanEkle();
          //             },
          //             child: (const Text(
          //               'VARYANT ELEMAN EKLE',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 15,
          //                   letterSpacing: 2.0),
          //             ))),
          //       )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
