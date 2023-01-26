import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/ProductCategory.dart';
import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/tif_listesi.dart';
import 'package:stok_takip_uygulamasi/urun_ozet.dart';
import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class TifKategoriUrunSecimi extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final myData<BaseCategory>? sonuc;
  final String? kategori;
  final String? urunler;
  final int? islemId;
  final String? selected;
  final Product? selectedProduct;


  const TifKategoriUrunSecimi(
      {Key? key,
      this.islemTuru,
      this.islemAdi,
      this.islemAciklamasi,
      this.anaDepo,
      this.hedefDepo,
      this.islemTarihi,
      this.sonuc,
      this.kategori,
      this.urunler,
      this.islemId,this.selected,this.selectedProduct})
      : super(key: key);

  @override
  State<TifKategoriUrunSecimi> createState() => _TifKategoriUrunSecimiState();
}

var urun;
var kategori = 'sdfsdf';
var urunler = 'asdasd';
var islemId;
class _TifKategoriUrunSecimiState extends State<TifKategoriUrunSecimi> {
  @override
  initState() {
    super.initState();
    // baseCategoryListele();
    setState(() {});
    // print("Sonuç: ${this.widget.sonuc![0].malzemeAdi}");

    // tfTif.text = this.widget.sonuc![0].malzemeAdi == "" ?'TİF Listesi' : this.widget.sonuc![0].malzemeAdi.toString();
  }

  var tfTif = new TextEditingController();

  late myData<BaseCategory> baseCategory = myData<BaseCategory>();

  late myData<ProductCategory> category = myData<ProductCategory>();

  Future<myData<ProductCategory>> categoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Categories/GetAll?BaseCategoryIdFilter=${this.widget.sonuc?.data![0].id}&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));

    // print(res.body);
    category = myData<ProductCategory>.fromJson(
        json.decode(res.body), ProductCategory.fromJsonModel);
    // print("kat: ${category.data![0].id}");
    // print(category.data![0].ad);
    // print("uzunluk:${category.data?.length}");
    // print(this.widget.sonuc?.data![0].id);
    return category;
  }

  late myData<Product> product = myData<Product>();

  Future<myData<Product>> productListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Products/GetAll?CategoryIdFilter=${category.data![0].id}&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));
    // print(res.body);
    // print(
    //     'https://stok.bahcelievler.bel.tr/api/Products/GetAll?CategoryIdFilter=${category.data![0].id}&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true');
    //
    // print(json.decode(res.body));
    product =
        myData<Product>.fromJson(json.decode(res.body), Product.fromJsonModel);
    // print(json.decode(res.body));
    // print('object');
    print(product.data![0]);
    // print(category.data![1].id);
    //
    // print("uzunluk:${category.data?.length}");
    // print('object');

    return product;
  }

  myData<Product> selectedProduct = myData<Product>();

  Future<myData<Product>> getSelected(String id) async {
    setState(() {});
    // print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Products/GetAll?CategoryIdFilter=0&BrandIdFilter=0&BrandModelIdFilter=0&Id=$id&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));


    selectedProduct = myData<Product>.fromJson(json.decode(res.body), Product.fromJsonModel);


    print(selectedProduct);

    // print("duzey son: ${selected.data![0].malzemeAdi}");
    // print("duzey son: ${selected.data![0].duzeyKodu}");
    // print("duzey son: ${selected.data![0].hesapKodu}");
    // print("duzey son: ${selected.data![0].id}");

    return selectedProduct;
  }


  var dropdownvalue;
  int pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('TİF-KATEGORİ-ÜRÜN',
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: tfTif,
                  decoration: InputDecoration(
                    hintText: this.widget.sonuc?.data![0].malzemeAdi.toString(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TifListesi(
                                    islemTuru: this.widget.islemTuru.toString(),
                                    islemAdi: this.widget.islemAdi.toString(),
                                    islemAciklamasi:
                                        this.widget.islemAciklamasi.toString(),
                                    anaDepo: int.parse(
                                        this.widget.anaDepo.toString()),
                                    hedefDepo: int.parse(
                                        this.widget.hedefDepo.toString()),
                                    islemTarihi:
                                        this.widget.islemTarihi.toString(),
                                islemId: this.widget.islemId)));
                      },
                      icon: Icon(Icons.search_sharp),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<myData<ProductCategory>>(
                  future: categoryListele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return SearchField<myData<ProductCategory>>(
                            autoCorrect: true,
                            hint: 'Kategori Seçiniz',
                            onSuggestionTap: (e) {
                              dropdownvalue = e.searchKey;
                              setState(() {
                                dropdownvalue = e.key.toString();
                              });
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data == null
                                ? []
                                : snapshot.data!.data!
                                    .map(
                                      (e) => SearchFieldListItem<
                                              myData<ProductCategory>>(
                                          e.ad.toString(),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(e.ad.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF6E3F52))),
                                              ),
                                            ],
                                          ),
                                          key: Key(e.ad.toString())),
                                    )
                                    .toList(),
                          );
                        },
                      );
                    }
                    return SearchField<myData<BaseCategory>>(
                        autoCorrect: true,
                        hint: 'Kategori Seçiniz',
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
                        suggestions: []);
                  },
                ),
                // const SizedBox(
                //   height: 40,
                // ),
                const SizedBox(
                  height: 10,
                ),

                FutureBuilder<myData<Product>>(
                  future: productListele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return SearchField<myData<Product>>(
                            autoCorrect: true,
                            hint: 'Ürün Seçiniz',
                            onSuggestionTap: (e) {
                              setState(() {});
                              dropdownvalue = e.searchKey;
                              setState(() {
                                dropdownvalue = e.key.toString();
                              });
                              print(((((dropdownvalue.replaceAll('[', '')).replaceAll(']', ''))
                                              .replaceAll('<', ''))
                                          .replaceAll('>', ''))
                                      .replaceAll("'", ''));

                              getSelected(((((dropdownvalue.replaceAll('[', '')).replaceAll(']', ''))
                                  .replaceAll('<', ''))
                                  .replaceAll('>', ''))
                                  .replaceAll("'", ''));
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data == null
                                ? []
                                : snapshot.data!.data!
                                    .map(
                                      (e) => SearchFieldListItem<
                                              myData<Product>>(
                                          e.productName.toString(),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    e.productName.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF6E3F52))),
                                              ),
                                            ],
                                          ),
                                          key: Key(e.id.toString())),
                                    )
                                    .toList(),
                          );
                        },
                      );
                    }
                    return SearchField<myData<Product>>(
                        autoCorrect: true,
                        hint: 'Ürün Seçiniz',
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
                        suggestions: []);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // SearchField<myData<BaseCategory>>(
                //   hint: 'Kategori Seçiniz',
                //
                //   onSuggestionTap: (e) {
                //     urun = e.searchKey;
                //
                //     setState(() {
                //       urun = e.key.toString();
                //     });
                //   },
                //   suggestionAction: SuggestionAction.unfocus,
                //   itemHeight: 50,
                //   searchStyle: const TextStyle(color: Color(0XFF976775)),
                //   suggestionStyle: const TextStyle(color: Color(0XFF976775)),
                //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
                //   suggestions: baseCategory.data!
                //       .map(
                //         (e) => SearchFieldListItem<myData<BaseCategory>>(
                //             e.toString(),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(e.hesapKodu.toString(),
                //                       style: const TextStyle(
                //                           color: Color(0XFF6E3F52))),
                //                 ),
                //               ],
                //             ),
                //             key: Key(e.toString())),
                //       )
                //       .toList(),
                // ),
                // SearchField<myData<BaseCategory>>(
                //   hint: 'Ürün Seçiniz',
                //
                //   onSuggestionTap: (e) {
                //     urun = e.searchKey;
                //
                //     setState(() {
                //       urun = e.key.toString();
                //     });
                //   },
                //   suggestionAction: SuggestionAction.unfocus,
                //   itemHeight: 50,
                //   searchStyle: const TextStyle(color: Color(0XFF976775)),
                //   suggestionStyle: const TextStyle(color: Color(0XFF976775)),
                //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
                //   suggestions: baseCategory.data!
                //       .map(
                //         (e) => SearchFieldListItem<myData<BaseCategory>>(
                //             e.toString(),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(e.hesapKodu.toString(),
                //                       style: const TextStyle(
                //                           color: Color(0XFF6E3F52))),
                //                 ),
                //               ],
                //             ),
                //             key: Key(e.toString())),
                //       )
                //       .toList(),
                // ),

                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0XFF6E3F52)),
                        color: const Color(0XFF976775),
                        shape: BoxShape.rectangle,
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.barcode_reader),
                          color: const Color(0XFF463848),
                          onPressed: () {
                            categoryListele();
                          })),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedButton(
                    color: const Color(0XFF463848),
                    text: 'Seç',
                    pressEvent: () {
                      // print(product.data![0].productName);
                      // print(product.data![0].categoryId);
                      // print(product.data![0].barkod);
                      // print(product.data![0].urunKimlikNo);
                      // print(product.data![0].sistemSeriNo);
                      // print(product.data![0].id);
                      // print(product.data![1].id);
                      // print(product.data?[0].productVariantElements?[0]);
                      // print(product.data?[0].category?.ad);
                      // print(product.data?[0].productVariantElements?[0].id);
                      // print(product
                      //     .data![0].productVariantElements![0].productId);
                      // print(product.data![0].productVariantElements![0]
                      //     .variantElementId);
                      // print(product.data?[0].productVariantElements[0].variantElement.varyantElemanAdi);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UrunOzet(
                                  islemTuru: widget.islemTuru,
                                  productVariantElements:
                                      product.data?[0].productVariantElements,
                                  productName: product.data?[0].productName,
                                  categoryAdi: product.data?[0].category?.ad,
                                  categorybirim:
                                      product.data?[0].category?.birim,
                                  categoryEnvanterTuru:
                                      product.data?[0].category?.envanterTuru,
                                  barkod: product.data?[0].barkod,
                                  urunKimlikNo: product.data?[0].urunKimlikNo,
                                  sistemSeriNo: product.data?[0].sistemSeriNo,
                                  id: product.data?[0].id,

                              islemId: widget.islemId,
                                  selectedProduct:selectedProduct)));

                      // builder: (context) => VaryantSecimi(variantAdi: product.data![0].productName, varyantElemanAdi: product.data![0].productVariantElements,productName: product.data![0].productName)));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OnayaGonderGrid(
                      //             sonuc: this.widget.sonuc,
                      //             kategori: kategori,
                      //             urunler: urunler)));
                      setState(() {});
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
