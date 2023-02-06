import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/depodan_urun_secimi.dart';
import 'package:stok_takip_uygulamasi/is_baslat.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/tif_kategori_urun_secimi.dart';

import 'drawer_menu.dart';
import 'package:http/http.dart' as http;

class onayaGonderileceklerListe extends StatefulWidget {
  final int? islemId;

  const onayaGonderileceklerListe({Key? key, this.islemId}) : super(key: key);

  @override
  State<onayaGonderileceklerListe> createState() =>
      _onayaGonderileceklerListeState();
}

class _onayaGonderileceklerListeState extends State<onayaGonderileceklerListe> {
  @override
  initState() {
    super.initState();
    onayaGidecekUrunlerListele();
    // print("işlem if: ${widget.islemId}");
  }

  late myData<ProductProcess> onayaGidecekUrunler = myData<ProductProcess>();

  Future<myData<ProductProcess>> onayaGidecekUrunlerListele() async {
    // print("işlemid:${widget.islemId}");
    print(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAll?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=${widget.islemId}&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false');
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAll?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=${widget.islemId}&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));
     print(res.body);
    onayaGidecekUrunler = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);
    return onayaGidecekUrunler;
  }

  Future<void> sendToAproval(int id) async{
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/SendForApprovalToProductProcess/$id'));
    if(res.statusCode == 204 && res.reasonPhrase == 'No Content'){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem başarıyla onaya gönderildi."),
        backgroundColor: Colors.green,
      ));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> IsBaslat()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('ONAYA GÖNDERLİCEKLER',
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                      height: 500,
                      child: FutureBuilder(
                        builder: (context, snapshot) {

                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ürün Adı: ${onayaGidecekUrunler.data?[0].productTransactions?[index].product?.productName}'),
                                    Text('Ürün Miktarı: ${onayaGidecekUrunler.data?[0].productTransactions?[index].miktar}'),
                                    Text((onayaGidecekUrunler?.data?[0].productTransactions?.length).toString())

                                  ],
                                ),
                              );
                            },
                            itemCount: onayaGidecekUrunler?.data?[0].productTransactions?.length,
                          );
                        },
                        future: onayaGidecekUrunlerListele(),
                      ),
              // ListView.builder(
              //           shrinkWrap: true,
              //             itemCount: onayaGidecekUrunler.data?.length,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (BuildContext context, int index) {
              //               return Card(
              //                 child: Column(
              //                   children: [
              //                     Text('${onayaGidecekUrunler.data?[index].id}'),
              //                     Text('${onayaGidecekUrunler.data?[index].onayIsteyenUser}'),
              //                     Text('${onayaGidecekUrunler.data?[index].productTransactions?[index].miktar}'),
              //                     Text('${onayaGidecekUrunler.data?[index].productTransactions?[index].hareketAciklamasi}'),
              //                     Text('${onayaGidecekUrunler.data?[index].id}'),
              //                   ],
              //                 ),
              //               );
              //             }
              //         ),
                    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0XFF463848),
                      side: const BorderSide(width: 1.0, color: Color(
                          0XFF463848)),
                    ),
                    onPressed: () async {
                      // final Future<SharedPreferences> _prefs =
                      // SharedPreferences.getInstance();
                      //


                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>  TifListesi(islemTuru: this.widget.islemTuru
                      //     .toString(),
                      //     islemAdi: this.widget.islemAdi.toString(),
                      //     islemAciklamasi: this.widget.islemAciklamasi
                      //         .toString(),
                      //     anaDepo: int.parse(
                      //         this.widget.anaDepo.toString()),
                      //     hedefDepo: int.parse(
                      //         this.widget.hedefDepo.toString()),
                      //     islemTarihi: this.widget.islemTarihi.toString())));
                      // setState(() {});
                      print("işlem tur: ${onayaGidecekUrunler.data![0].islemTuru.toString()}");
                      print("işlem id: ${widget.islemId}");
                      print("açıklama: ${onayaGidecekUrunler.data![0].islemAciklama}");
                      print("ana depo: ${onayaGidecekUrunler.data?[0].anaDepoId}");
                      print("hedef depo: ${onayaGidecekUrunler.data?[0].hedefDepoID}");
                      print("işlem tarihi: ${onayaGidecekUrunler.data![0].islemTarihi}");
                      if(onayaGidecekUrunler.data![0].islemTuru.toString() == "5" || onayaGidecekUrunler.data![0].islemTuru.toString()=="6" || onayaGidecekUrunler.data![0].islemTuru.toString() == "7" || onayaGidecekUrunler.data![0].islemTuru.toString() =="8"){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DepodanUrunSecimi(
                          islemTuru: onayaGidecekUrunler.data![0].islemTuru.toString(),
                          islemId: widget.islemId, islemAciklamasi: onayaGidecekUrunler.data![0].islemAciklama,
                            anaDepo: onayaGidecekUrunler.data?[0].anaDepoId, hedefDepo: onayaGidecekUrunler.data?[0]?.hedefDepoID,
                            islemTarihi: onayaGidecekUrunler.data![0].islemTarihi,
                          islemAdi: onayaGidecekUrunler.data![0].islemAdi,

                        )));

                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TifKategoriUrunSecimi(islemTuru: onayaGidecekUrunler.data![0].islemTuru.toString(),
                          islemId: widget.islemId, islemAciklamasi: onayaGidecekUrunler.data![0].islemAciklama,
                          anaDepo: onayaGidecekUrunler.data?[0].anaDepoId, hedefDepo: onayaGidecekUrunler.data?[0]?.hedefDepoID,
                          islemTarihi: onayaGidecekUrunler.data![0].islemTarihi,)));
                      }

                    },
                    child: const Text("DAHA FAZLA\nÜRÜN EKLE",
                        style: TextStyle(
                            color: Color(0XFFDBDCE8),
                            fontSize: 15,
                            letterSpacing: 2.0)),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0XFF463848),
                    side: const BorderSide(
                        width: 1.0, color: Color(0XFF463848)),
                  ),
                  onPressed: () {
                    sendToAproval(int.parse(widget.islemId.toString()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> OnayaGonderGrid()));
                    setState(() {});
                  },
                  child: const Text("ONAYA GÖNDER",
                      style: TextStyle(
                          color: Color(0XFFDBDCE8),
                          fontSize: 15,
                          letterSpacing: 2.0)),
                )

              ],
            )
          ],
        )


      ),
    );
  }
}
