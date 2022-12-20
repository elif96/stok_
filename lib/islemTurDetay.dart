import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/islemTanim.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class IslemTurDetay extends StatefulWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;

  const IslemTurDetay({Key? key, required this.islemTuru, required this.islemAdi, required this.islemAciklamasi, required this.islemTarihi }) : super(key: key);

  @override
  State<IslemTurDetay> createState() => _IslemTurDetayState();
}

class _IslemTurDetayState extends State<IslemTurDetay> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('İşlem Türü Detay')),
      endDrawer: DrawerMenu(),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (this.widget.islemTuru == 'Giriş İşlemleri') {
              return WidgetGiris(islemTuru: this.widget.islemTuru, islemAdi: this.widget.islemAdi, islemAciklamasi: this.widget.islemAciklamasi, islemTarihi: this.widget.islemTarihi,);
            }
            else if (this.widget.islemTuru == 'Departman İçi Hareket') {
              return WidgetDepartmanIciHareket(islemTuru: this.widget.islemTuru, islemAdi: this.widget.islemAdi, islemAciklamasi: this.widget.islemAciklamasi, islemTarihi: this.widget.islemTarihi);
            }
            else if (this.widget.islemTuru == 'Çıkış İşlemleri') {
              return WidgetCikis(islemTuru: this.widget.islemTuru, islemAdi: this.widget.islemAdi, islemAciklamasi: this.widget.islemAciklamasi, islemTarihi: this.widget.islemTarihi);
            }
          }),
    );
  }


}
class WidgetGiris extends StatelessWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;
  const WidgetGiris({Key? key , required this.islemTuru, required this.islemAdi, required this.islemAciklamasi, required this.islemTarihi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [

        ListTile(
          title: Text("Avans Yoluyla",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("İhale Yoluyla",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("Satın Alma",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("Üretim",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
      ],
    );
    // return ExpansionTile(
    //   title: Row(
    //     children: [
    //       Text(
    //         this.islemTuru,
    //         style: TextStyle(color: Color(0XFF976775)),
    //       ),
    //     ],
    //   ),
    //   subtitle: Text(
    //     this.islemTuru,
    //     style: TextStyle(color: Color(0XFFAAA3B4)),
    //   ),
    //   children: [
    //     ListTile(
    //       onTap: () {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => stokIslemleri()));
    //       },
    //       title: Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: Text(
    //           'Avans Yoluyla',
    //           style: TextStyle(color: Color(0XFF976775)),
    //         ),
    //       ),
    //       trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
    //     ),
    //     ListTile(
    //       onTap: () {},
    //       // leading: Icon(
    //       //   Icons.branding_watermark_outlined,
    //       //   color: Color(0XFF6E3F52),
    //       // ),
    //       title: Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: Text(
    //           'İhale Yoluyla',
    //           style: TextStyle(color: Color(0XFF976775)),
    //         ),
    //       ),
    //
    //       trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
    //     ),
    //     ListTile(
    //       onTap: () {},
    //       // leading: Icon(
    //       //   Icons.branding_watermark_outlined,
    //       //   color: Color(0XFF6E3F52),
    //       // ),
    //       title: Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: Text(
    //           'Satın Alma',
    //           style: TextStyle(color: Color(0XFF976775)),
    //         ),
    //       ),
    //
    //       trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
    //     ),
    //     ListTile(
    //       onTap: () {},
    //       // leading: Icon(
    //       //   Icons.branding_watermark_outlined,
    //       //   color: Color(0XFF6E3F52),
    //       // ),
    //       title: Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: Text(
    //           'Üretim',
    //           style: TextStyle(color: Color(0XFF976775)),
    //         ),
    //       ),
    //
    //       trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
    //     )
    //   ],
    // );
  }
}

class WidgetDepartmanIciHareket extends StatelessWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;
  const WidgetDepartmanIciHareket({Key? key , required this.islemTuru, required this.islemAdi, required this.islemAciklamasi, required this.islemTarihi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [

        ListTile(
          title: Text("Transfer",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));
          },
        ),
        Divider(),
        ListTile(
          title: Text("Zimmet",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
      ],
    );
  }
}

class WidgetCikis extends StatelessWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;
  const WidgetCikis({Key? key , required this.islemTuru, required this.islemAdi, required this.islemAciklamasi, required this.islemTarihi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [

        ListTile(
          title: Text("Devir",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("Hibe",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("Hurda",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
        ListTile(
          title: Text("Tüketim",style: TextStyle(color: Color(0XFF976775))),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  IslemTanim(islemTuru: this.islemTuru, islemAdi: this.islemAdi, islemAciklamasi: this.islemAciklamasi, islemTarihi: this.islemTarihi)));

          },
        ),
        Divider(),
      ],
    );

  }
}