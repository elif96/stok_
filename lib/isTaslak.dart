import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/islemTurDetay.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class IsTaslak extends StatefulWidget {



  const IsTaslak({Key? key}) : super(key: key);

  @override
  State<IsTaslak> createState() => _IsTaslakState();
}

class _IsTaslakState extends State<IsTaslak> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('İşlem Taslakları')),
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
      // body: GestureDetector(onTap: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>IslemTurDetay(islemTuru: this.widget.islemTuru.toString())));
      // },
      // //     child: Text("Taslak 1 (${this.widget.islemTuru.toString()} - ${this.widget.islemAdi} - ${this.widget.islemAciklamasi} - ${this.widget.islemTarihi})")),
      // body: ListView.builder(
      //     itemCount: 1,
      //     itemBuilder: (context, index) {
      //        Text("Taslak 1 (${this.widget.islemTuru.toString()} - ${this.widget.islemAdi} - ${this.widget.islemAciklamasi} - ${this.widget.islemTarihi})");
      //
      //     }),
      body:  ListView(
        children: [

          GestureDetector(
            onTap: (){
            },
            child: ListTile(
              title: Text('İŞLEM ADI',style: TextStyle(color: Color(0XFF976775))),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("İşlem Türü: İşlem Türü"),
                  Text("İşlem Açıklaması: İşlem Açıklaması"),
                  Text("İşlem Tarihi: İşlem Tarihi"),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>IslemTurDetay(islemTuru: this.widget.islemTuru.toString(), islemAdi: this.widget.islemAdi, islemAciklamasi: this.widget.islemAciklamasi, islemTarihi: this.widget.islemTarihi,)));
            },
            child: ListTile(
              title: Text('İşlem Adı',style: TextStyle(color: Color(0XFF976775))),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("İşlem Türü: İşlem türü"),
                  Text("İşlem Açıklaması: İşlem açıklaması"),
                  Text("İşlem Tarihi: İşlem tarihi"),
                ],
              ),
            ),
          ),

          // ListTile(
          //   title: Text(this.widget.islemAdi.toString()),
          // ),


        ],
      ),
    );
  }
}
