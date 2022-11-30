import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/islemTurDetay.dart';
import 'package:stok_takip_uygulamasi/stokBul.dart';
import 'package:intl/intl.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class isBaslat extends StatefulWidget {
  const isBaslat({Key? key}) : super(key: key);

  @override
  State<isBaslat> createState() => _isBaslatState();
}

class _isBaslatState extends State<isBaslat> {
  // var tfIslemAdi = new TextEditingController();
  var tfIslemAciklamasi = new TextEditingController();
  TextEditingController tfIslemTarihi = new TextEditingController();
  TextEditingController tfIslemAdi = new TextEditingController();



  var islemTuru;
  List<String> list = <String>[
    'Giriş İşlemleri',
    'Departman İçi Hareket',
    'Çıkış İşlemleri'
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Color(0xFF976775),
        title: Text('STOK İŞLEMLERİ',
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  width: 2.0, color: Color(0XFF976775))),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        'Lütfen işlem başlatmadan önce işlem bilgilerini girin.',
                                        style: GoogleFonts.notoSansTaiLe(
                                          fontSize: 15,
                                          color: Color(0XFF976775),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: tfIslemAdi,
                                      decoration: InputDecoration(
                                        hintText: 'İşlem Adı',
                                        hintStyle:
                                            TextStyle(color: Color(0XFF976775)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0XFF463848)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: tfIslemAciklamasi,
                                      decoration: InputDecoration(
                                        hintText: 'İşlem Açıklaması',
                                        hintStyle:
                                            TextStyle(color: Color(0XFF976775)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0XFF463848)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: tfIslemTarihi,
                                      decoration: InputDecoration(
                                        hintText: 'İşlem Tarihi',
                                        hintStyle:
                                            TextStyle(color: Color(0XFF976775)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0XFF463848)),
                                        ),
                                      ),
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: Color(0xFF976775),
                                                    // header background color
                                                    onPrimary:
                                                        Color(0XFF463848),
                                                    // header text color
                                                    onSurface: Color(
                                                        0XFF463848), // body text color
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Color(
                                                          0XFF463848), // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                            useRootNavigator: false,
                                            cancelText: "Kapat",
                                            confirmText: "Seç",
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101));
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate);
                                          // print(formattedDate);
                                          setState(() {
                                            tfIslemTarihi.text = formattedDate;
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Color(0XFF976775)),
                                          hintText: "İşlem Türü",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0XFF6E3F52),
                                                  width: 3))),
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  color: Color(0XFF976775))),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          islemTuru = newVal;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    AnimatedButton(
                                        color: Color(0XFF463848),
                                        text: 'Başlat',
                                        pressEvent: () {
                                          print(tfIslemAdi.text);
                                          if (tfIslemAdi.text == "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: const Text(
                                                  'İşlem adını boş bırakamazsınız.'),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          } else if (tfIslemAciklamasi.text ==
                                              "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: const Text(
                                                  'İşlem açıklamasını boş bırakamazsınız.'),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          } else if (tfIslemAciklamasi.text ==
                                              "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: const Text(
                                                  'İşlem tarihini boş bırakamazsınız.'),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          } else {

                                            String islemAdi = tfIslemAdi.text;
                                            String islemTarihi = tfIslemTarihi.text;
                                            String islemAciklamasi = tfIslemAciklamasi.text;
                                            print("*");
                                            print(islemAdi);
                                            print(islemTarihi);
                                            print("*");

                                            tfIslemAdi.clear();
                                            tfIslemAciklamasi.clear();
                                            tfIslemTarihi.clear();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IslemTurDetay(
                                                            islemTuru:
                                                                islemTuru,
                                                            islemAdi:
                                                                islemAdi,
                                                            islemAciklamasi:
                                                                islemAciklamasi,
                                                            islemTarihi:
                                                                islemTarihi)));
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
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'İŞLEM BAŞLAT ',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF976775),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Icon(
                                Icons.play_circle,
                                color: Color(0XFF976775),
                              ),
                            ],
                          ))),
                  SizedBox(height: 25),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  width: 2.0, color: Color(0XFF976775))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => stokBul()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'STOK BUL ',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF976775),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Icon(
                                Icons.search_outlined,
                                color: Color(0XFF976775),
                              ),
                            ],
                          ))),
                  SizedBox(height: 25),
                  Card(
                    color: Color(0XFFDBDCE8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,

                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kayıtlı Envanter Sayısı',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //declare your widget here
                    ),
                  ),
                  Card(
                    color: Color(0XFFDBDCE8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,

                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kayıtlı Envanter Çeşidi',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //declare your widget here
                    ),
                  ),
                  Card(
                    color: Color(0XFFDBDCE8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,

                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kayıtlı Marka Sayısı',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //declare your widget here
                    ),
                  ),
                  Card(
                    color: Color(0XFFDBDCE8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,

                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kayıtlı Depo Sayısı',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //declare your widget here
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
