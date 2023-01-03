import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/IslemlerDetay.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class DrawerMenu extends StatefulWidget {
  late String? islemAdi;
  DrawerMenu({Key? key, this.islemAdi}) : super(key: key);


  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  var List = ["İşlem Taslakları", "Onayımı Bekleyen İşlemler", "Onay Beklediğim İşlemler", "Reddedilen İşlemler", "Onayladığım İşlemler", "Reddettiğim İşlemler"];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: const BoxDecoration(color: Color(0XFF6E3F52)),
            child: Column(
              children: [
                // Image.asset('assets/logo.jpeg'),
                // const SizedBox(
                //   height: 5,
                // ),
                // Text('STOK TAKİP UYGULAMASI',
                //     style: GoogleFonts.notoSansTaiLe(
                //       fontSize: 15,
                //       fontWeight: FontWeight.bold,
                //       color: const Color(0XFF976775),
                //       letterSpacing: 2,
                //     )),
              ],
            )

          ),
          ListTile(
            leading: const Icon(
              Icons.account_tree,
              color: Color(0XFF976775),
            ),
            subtitle: const Text('Yeni tanımlamalar yapın', style: TextStyle(color: Color(0XFFAAA3B4))),
            title: const Text(
              'TANIMLAMALAR',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0XFF976775)),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Tanimlamalar()));
            },
          ),
          ExpansionTile(
            title: const Text("İŞLEMLER", style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0XFF976775)),
            ),
            subtitle: const Text('İşlemlerinizi takip edin', style: TextStyle(color: Color(0XFFAAA3B4)),),
            leading: const Icon(Icons.edit_calendar,  color: Color(0XFF976775),), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: const Icon(
                  Icons.incomplete_circle_sharp,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'İşlem Taslakları',
                  style: TextStyle(  color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'İşlem Taslakları';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock_clock,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'Onayımı Bekleyen İşlemler',
                  style: TextStyle( color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onayımı Bekleyen İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.send_outlined,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'Onaya Gönderdiğim İşlemler',
                  style: TextStyle( color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onaya Gönderdiğim İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.do_not_disturb_on,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'Reddedilen İşlemler',
                  style: TextStyle( color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Reddedilen İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.check,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'Onayladığım İşlemler',
                  style: TextStyle( color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onayladığım İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.close_sharp,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'Reddettiğim İşlemler',
                  style: TextStyle( color: Color(0XFF976775)),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Reddettiğim İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
            ],
          ),

          const Divider(thickness: 2.0,),
          ListTile(
            leading: const Icon(
              Icons.edit_calendar,
              color: Color(0XFF976775),
            ),
            title: const Text(
              'İŞLEM TASLAKLARI',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0XFF976775)),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IsTaslak()));
            },
          ),
          const Divider(thickness: 2.0,),
          ListTile(
            leading: const Icon(
              Icons.fact_check,
              color: Color(0XFF976775),
            ),
            title: const Text(
              'ONAY İŞLEMLERİ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0XFF976775)),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IsTaslak()));
            },
          ),
          const Divider(thickness: 2.0,),
        ],
      ),
    );
  }
}
