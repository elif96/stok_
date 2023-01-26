import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:http/http.dart' as http;
import 'drawer_menu.dart';

class OnayaGonderGrid extends StatefulWidget {
  // final String islemId;

  const OnayaGonderGrid({Key? key}) : super(key: key);



  @override
  State<OnayaGonderGrid> createState() => _OnayaGonderGridState();
}
class _OnayaGonderGridState extends State<OnayaGonderGrid> {
  @override
  initState() {
    super.initState();
    // onayaGidecekUrunlerListele();
    // print("işlem if: ${widget.islemId}");
   }

  late myData<Product> onayaGidecekUrunler = myData<Product>();

  // Future<myData<Product>> onayaGidecekUrunlerListele() async {
  //   // print("işlemid:${widget.islemId}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/ProductTransactions/GetAll?ProductIdFilter=0&ProductProcessIdFilter=${widget.islemId}&DepartmentIdFilter=0&WarehouseIdFilter=0&ParentIdFilter=0&MinMiktarFilter=0&MaksMiktarFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));
  //
  //   onayaGidecekUrunler = myData<Product>.fromJson(
  //       json.decode(res.body), Product.fromJsonModel);
  //   return onayaGidecekUrunler;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('SEÇİLEN ÜRÜNLER',
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
          child: Column(
            children: [
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'ÜRÜN',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'KATEGORİ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'ADET',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(onayaGidecekUrunler.data.toString())),
                      DataCell(Text("widget.categoryAdi.toString()")),
                      // ${widget.miktar.toString()}
                      DataCell(
                          Row(
                        children: [
                          Text("widget.miktar.toString()"),

                        ],
                      )),
                    ],
                  ),

                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('Janine')),
                  //     DataCell(Text('43')),
                  //     DataCell(Text('Professor')),
                  //   ],
                  // ),
                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('William')),
                  //     DataCell(Text('27')),
                  //     DataCell(Text('Associate Professor')),
                  //   ],
                  // ),
                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('William')),
                  //     DataCell(Text('27')),
                  //     DataCell(Text('Associate Professor')),
                  //   ],
                  // ),
                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('William')),
                  //     DataCell(Text('27')),
                  //     DataCell(Text('Associate Professor')),
                  //   ],
                  // ),
                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('William')),
                  //     DataCell(Text('27')),
                  //     DataCell(Text('Associate Professor')),
                  //   ],
                  // ),
                ],
              ),

              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(onayaGidecekUrunler.data?[0].productName.toString() == null ? '' : onayaGidecekUrunler.data![0].productName, style: GoogleFonts.notoSansTaiLe(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0XFF976775),
                      )),
                      // Text(widget.productVariantElements![index].variantElement.varyantElemanAdi.toString()),
                    ],
                  );
                },
                itemCount: onayaGidecekUrunler.data?.length,
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
                        setState(() {});
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
          ),
        ),
      )
      ,
    );
  }
}
