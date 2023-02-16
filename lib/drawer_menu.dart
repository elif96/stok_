import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/IslemlerDetay.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/kategori_tanim.dart';
import 'package:stok_takip_uygulamasi/marka_tanim.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
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
            decoration: BoxDecoration(color: myColors.topColor),
            child: Column(
              children: const [
                // Image.asset('assets/logo.jpeg'),
                // const SizedBox(
                //   height: 5,
                // ),
                // Text('STOK TAKİP UYGULAMASI',
                //     style: GoogleFonts.raleway(
                //       fontSize: 15,
                //       fontWeight: FontWeight.bold,
                //       color: const Color(0XFF976775),
                //       letterSpacing: 2,
                //     )),
              ],
            )

          ),
          ListTile(
            leading: Icon(
              Icons.account_tree,
              color: myColors.baslikColor,
            ),
            subtitle: Text('Yeni tanımlamalar yapın', style: TextStyle(color: myColors.topColor)),
            title: Text(
              'TANIMLAMALAR',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Tanimlamalar()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: myColors.baslikColor,
            ),
            subtitle: Text('Yeni tanımlamalar yapın', style: TextStyle(color: myColors.topColor)),
            title: Text(
              'KATEGORİ TANIM',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KategoriTanim()));
            },
          ),

          // const Divider(thickness: 2.0,),
          ExpansionTile(
            title: Text("İŞLEMLER", style: TextStyle(
                fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            subtitle: Text('İşlemlerinizi takip edin', style: TextStyle(color: myColors.topColor),),
            leading: Icon(Icons.branding_watermark_outlined,  color: myColors.baslikColor), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: Icon(
                  Icons.incomplete_circle_sharp,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'İşlem Taslakları',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'İşlem Taslakları';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.lock_clock,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Onayımı Bekleyen İşlemler',
                  style: TextStyle( color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onayımı Bekleyen İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.send_outlined,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Onaya Gönderdiğim İşlemler',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onaya Gönderdiğim İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.do_not_disturb_on,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Reddedilen İşlemler',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Reddedilen İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Onayladığım İşlemler',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Onayladığım İşlemler';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.close_sharp,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Reddettiğim İşlemler',
                  style: TextStyle(color: myColors.baslikColor),
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
          ExpansionTile(
            title: Text("MARKA İŞLEMLERİ", style: TextStyle(
                fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            subtitle: Text('İşlem yapın', style: TextStyle(color: myColors.topColor),),
            leading: Icon(Icons.branding_watermark_outlined,  color: myColors.baslikColor), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: Icon(
                  Icons.add,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Marka Ekle',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Marka Ekle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MarkaTanim()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.border_color_outlined,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Marka Güncelle',
                  style: TextStyle( color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Marka Güncelle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.minimize,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Marka Sil',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Marka Sil';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),

            ],
          ),
          ExpansionTile(
            title: Text("MODEL İŞLEMLERİ", style: TextStyle(
                fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            subtitle: Text('İşlem yapın', style: TextStyle(color: myColors.topColor),),
            leading: Icon(Icons.model_training,  color: myColors.baslikColor), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: Icon(
                  Icons.add,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Model Ekle',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Model Ekle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.border_color_outlined,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Model Güncelle',
                  style: TextStyle( color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Model Güncelle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.minimize,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Model Sil',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Model Sil';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),

            ],
          ),
          ExpansionTile(
            title: Text("VARYANT İŞLEMLERİ", style: TextStyle(
                fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            subtitle: Text('İşlem yapın', style: TextStyle(color: myColors.topColor),),
            leading: Icon(Icons.view_in_ar,  color: myColors.baslikColor), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: Icon(
                  Icons.add,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Ekle',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Ekle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.border_color_outlined,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Güncelle',
                  style: TextStyle( color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Güncelle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.minimize,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Sil',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Sil';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),

            ],
          ),
          ExpansionTile(
            title: Text("VARYANT ELEMAN İŞLEMLERİ", style: TextStyle(
                fontWeight: FontWeight.bold, color: myColors.baslikColor),
            ),
            subtitle: Text('İşlem yapın', style: TextStyle(color: myColors.topColor),),
            leading: Icon(Icons.fitbit,  color: myColors.baslikColor), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children: [

              ListTile(
                leading: Icon(
                  Icons.add,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Eleman Ekle',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Eleman Ekle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.border_color_outlined,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Eleman Güncelle',
                  style: TextStyle( color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Eleman Güncelle';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.minimize,
                  color: myColors.baslikColor,
                ),
                title: Text(
                  'Varyant Eleman Sil',
                  style: TextStyle(color: myColors.baslikColor),
                ),
                onTap: () {
                  this.widget.islemAdi = 'Varyant Eleman Sil';
                  print("İşlem adı: ${this.widget.islemAdi.toString()}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IslemlerDetay(islemAdi: this.widget.islemAdi.toString())));
                },
              ),

            ],
          ),
          // const Divider(thickness: 2.0,),


        ],
      ),
    );
  }
}
