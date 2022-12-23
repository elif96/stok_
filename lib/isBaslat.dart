import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/islemTanim.dart';
import 'package:stok_takip_uygulamasi/model/Warehouse.dart';
import 'package:stok_takip_uygulamasi/stokBul.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class isBaslat extends StatefulWidget {
  const isBaslat({Key? key}) : super(key: key);

  @override
  State<isBaslat> createState() => _isBaslatState();
}

class _isBaslatState extends State<isBaslat> {
  var tfIslemAciklamasi = new TextEditingController();
  TextEditingController tfIslemTarihi = new TextEditingController();
  TextEditingController tfIslemAdi = new TextEditingController();

  @override
  initState() {
    super.initState();
    warehouseListele();
    setState(() {});
  }

  var islemTuru;
  var anaDepo;
  var hedefDepo;

  List<String> list = <String>[
    'Avans Yoluyla',
    'İhale Yoluyla',
    'Satın Alma',
    'Üretim',
    'Transfer',
    'Zimmet',
    'Zimmet İade',
    'Devir',
    'Hibe',
    'Hurda',
    'Tüketim'
  ];

  List<Data> cevap = <Data>[];

  Future<List<Data>> warehouseListele() async {
    http.Response res = await http
        .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Warehouses'));
    cevap = Warehouse.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    // print(cevap[0].ad);
    return cevap;
  }

  int _currentStep = 0;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  Future<void> isBaslat(String islemAdi, String islemAciklama, int islemTuru,
      int anaDepoId, int hedefDepoId, String islemTarihi) async {
    // "islemAdi": "test",
    // "islemAciklama": "test açıklaması",
    // "islemTuru": 1,
    // "anaDepoId": 5,
    // "hedefDepoID": 6,
    var url =
        Uri.parse('https://stok.bahcelievler.bel.tr/api/ProductProcesses');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "islemAdi": tfIslemAdi.text,
          "islemAciklama": tfIslemAciklamasi.text,
          "islemTuru": islemTuru,
          "anaDepoId": int.parse(anaDepo),
          "hedefDepoID": int.parse(hedefDepo),
          "islemTarihi": tfIslemTarihi.text
        }));
    // tfIslemAdi.text = "";
    // tfIslemAciklamasi.text = "";

    print(tfIslemAdi.text);
    print(tfIslemAciklamasi.text);
    print(islemTuru);
    print(anaDepo);
    print(hedefDepo);
    print(tfIslemTarihi.text);

    print(response.body);
    print(response.statusCode);
    print(response.reasonPhrase);

    // if(tfVaryantAdi.text ==""){
    //   //silinecek marka bulunamadı
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Lütfen varyant adı girin."),
    //     backgroundColor: Colors.red,
    //   ));
    //   tfVaryantAdi.clear();
    //   setState(() {});
    // }
    // else if(response.reasonPhrase == 'Bad Request'){
    //   //model olduğu için marka silinemedi
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Eklemek istediğiniz varyant zaten var."),
    //     backgroundColor: Colors.red,
    //   ));
    //   tfVaryantAdi.clear();
    //   setState(() {});
    // }
    // else if(response.reasonPhrase == 'Created'){
    //   // başarılı
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Varyant ekleme işlemi başarıyla gerçekleştirildi."),
    //     backgroundColor: Colors.green,
    //   ));
    //   tfVaryantAdi.clear();
    //   setState(() {});
    // }
  }

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
      endDrawer: DrawerMenu(),
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      actions: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          child: SingleChildScrollView(
                                            child: Theme(
                                              data: ThemeData(
                                                colorScheme: Theme.of(context)
                                                    .colorScheme
                                                    .copyWith(
                                                      primary:
                                                          Color(0xFF976775),
                                                      background: Colors.red,
                                                      secondary: Colors.red,
                                                    ),
                                              ),
                                              child: Stepper(
                                                controlsBuilder: (BuildContext
                                                        context,
                                                    ControlsDetails details) {
                                                  return Row(
                                                    children: <Widget>[],
                                                  );
                                                },
                                                physics: ScrollPhysics(),
                                                currentStep: _currentStep,
                                                onStepTapped: (step) =>
                                                    tapped(step),
                                                steps: <Step>[
                                                  Step(
                                                    title: Text(
                                                        'Lütfen işlem başlatmadan önce işlem bilgilerini girin.',
                                                        style: GoogleFonts
                                                            .notoSansTaiLe(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0XFF976775),
                                                        )),
                                                    content: Column(
                                                      children: <Widget>[
                                                        TextField(
                                                          controller:
                                                              tfIslemAdi,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'İşlem Adı',
                                                            hintStyle: TextStyle(
                                                                color: Color(
                                                                    0XFF976775)),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0XFF463848)),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              tfIslemAciklamasi,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'İşlem Açıklaması',
                                                            hintStyle: TextStyle(
                                                                color: Color(
                                                                    0XFF976775)),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0XFF463848)),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              tfIslemTarihi,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'İşlem Tarihi',
                                                            hintStyle: TextStyle(
                                                                color: Color(
                                                                    0XFF976775)),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0XFF463848)),
                                                            ),
                                                          ),
                                                          readOnly: true,
                                                          onTap: () async {
                                                            DateTime? pickedDate =
                                                                await showDatePicker(
                                                                    locale: const Locale(
                                                                        "tr",
                                                                        "TR"),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return Theme(
                                                                        data: Theme.of(context)
                                                                            .copyWith(
                                                                          colorScheme:
                                                                              ColorScheme.light(
                                                                            primary:
                                                                                Color(0xFF976775),
                                                                            // header background color
                                                                            onPrimary:
                                                                                Color(0XFF463848),
                                                                            // header text color
                                                                            onSurface:
                                                                                Color(0XFF463848), // body text color
                                                                          ),
                                                                          textButtonTheme:
                                                                              TextButtonThemeData(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Color(0XFF463848), // button text color
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                    useRootNavigator:
                                                                        false,
                                                                    cancelText:
                                                                        "Kapat",
                                                                    confirmText:
                                                                        "Seç",
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2000),
                                                                    //DateTime.now() - not to allow to choose before today.
                                                                    lastDate:
                                                                        DateTime(
                                                                            2101));
                                                            if (pickedDate !=
                                                                null) {
                                                              String
                                                                  formattedDate =
                                                                  DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(
                                                                          pickedDate);
                                                              // print(formattedDate);
                                                              setState(() {
                                                                tfIslemTarihi
                                                                        .text =
                                                                    formattedDate;
                                                              });
                                                            } else {
                                                              print(
                                                                  "Date is not selected");
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {
                                                                  _currentStep >
                                                                          0
                                                                      ? setState(() =>
                                                                          _currentStep -=
                                                                              1)
                                                                      : null;
                                                                },
                                                                child: Text(
                                                                    "Geri",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {
                                                                  _currentStep <
                                                                          2
                                                                      ? setState(() =>
                                                                          _currentStep +=
                                                                              1)
                                                                      : null;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                    "İleri",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    isActive: _currentStep >= 0,
                                                    state: _currentStep >= 0
                                                        ? StepState.complete
                                                        : StepState.disabled,
                                                  ),
                                                  Step(
                                                    title: new Text(
                                                        'İşlem Türü seçiniz.',
                                                        style: GoogleFonts
                                                            .notoSansTaiLe(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0XFF976775),
                                                        )),
                                                    content: Column(
                                                      children: <Widget>[
                                                        DropdownButtonFormField(
                                                          decoration: InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                      0XFF976775)),
                                                              hintText:
                                                                  "İşlem Türü",
                                                              border: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF6E3F52),
                                                                      width:
                                                                          3))),
                                                          items: list.map<
                                                              DropdownMenuItem>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(value,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFF976775))),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            print(islemTuru.hashCode);
                                                            setState(() {
                                                              islemTuru =
                                                                  newVal;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {
                                                                  _currentStep >
                                                                          0
                                                                      ? setState(() =>
                                                                          _currentStep -=
                                                                              1)
                                                                      : null;
                                                                },
                                                                child: Text(
                                                                    "Geri",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {
                                                                  _currentStep <
                                                                          2
                                                                      ? setState(() =>
                                                                          _currentStep +=
                                                                              1)
                                                                      : null;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                    "İleri",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    isActive: _currentStep >= 0,
                                                    state: _currentStep >= 1
                                                        ? StepState.complete
                                                        : StepState.disabled,
                                                  ),
                                                  Step(
                                                    title: Text(
                                                        'Ana ve Hedef Nokta seçiniz.',
                                                        style: GoogleFonts
                                                            .notoSansTaiLe(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0XFF976775),
                                                        )),
                                                    content: Column(
                                                      children: <Widget>[
                                                        DropdownButtonFormField(
                                                          decoration: const InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                      0XFF976775)),
                                                              hintText:
                                                                  "Ana Nokta",
                                                              border: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF6E3F52),
                                                                      width:
                                                                          3))),
                                                          items: cevap.map(
                                                              (Data value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value.id
                                                                  .toString(),
                                                              child: Text(
                                                                  value.ad
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFF976775))),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            setState(() {
                                                              anaDepo =
                                                                  newVal;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        DropdownButtonFormField(
                                                          decoration: InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                      0XFF976775)),
                                                              hintText:
                                                                  "Hedef Nokta",
                                                              border: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF6E3F52),
                                                                      width:
                                                                          3))),
                                                          items: cevap.map(
                                                              (Data value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value.id
                                                                  .toString(),
                                                              child: Text(
                                                                  value.ad
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFF976775))),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            setState(() {
                                                              hedefDepo =
                                                                  newVal;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {
                                                                  _currentStep >
                                                                          0
                                                                      ? setState(() =>
                                                                          _currentStep -=
                                                                              1)
                                                                      : null;
                                                                },
                                                                child: Text(
                                                                    "Geri",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF463848),
                                                                  side: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Color(
                                                                          0XFF463848)),
                                                                ),
                                                                onPressed: () {

                                                                  if (tfIslemAdi
                                                                          .text ==
                                                                      "") {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'İşlem adını boş bırakamazsınız.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (tfIslemAciklamasi
                                                                          .text ==
                                                                      "") {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'İşlem açıklamasını boş bırakamazsınız.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (tfIslemTarihi
                                                                          .text ==
                                                                      "") {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'İşlem tarihini boş bırakamazsınız.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (islemTuru ==
                                                                          "" ||
                                                                      islemTuru ==
                                                                          null) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'İşlem türü seçmelisiniz.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (cevap ==
                                                                          "" ||
                                                                      cevap ==
                                                                          null) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'Ana nokta seçmelisiniz.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (cevap ==
                                                                          "" ||
                                                                      cevap ==
                                                                          null) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content:
                                                                          const Text(
                                                                              'Hedef nokta seçmelisiniz.'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else {
                                                                    String
                                                                        islemAdi =
                                                                        tfIslemAdi
                                                                            .text;
                                                                    String
                                                                        islemTarihi =
                                                                        tfIslemTarihi
                                                                            .text;
                                                                    String
                                                                        islemAciklamasi =
                                                                        tfIslemAciklamasi
                                                                            .text;
                                                                    // print("*");
                                                                    // print(
                                                                    //     islemAdi);
                                                                    // print(
                                                                    //     islemTarihi);
                                                                    // print("*");

                                                                    tfIslemAdi
                                                                        .clear();
                                                                    tfIslemAciklamasi
                                                                        .clear();
                                                                    tfIslemTarihi
                                                                        .clear();
                                                                    print("Ana Depo: ${anaDepo}");
                                                                    print("Hedef Depo: ${hedefDepo}");
                                                                    print(tfIslemAdi.text.runtimeType);
                                                                    print(tfIslemAciklamasi.text.runtimeType);
                                                                    print(islemTuru.runtimeType);
                                                                    print(islemTuru);
                                                                    print(int.parse(anaDepo).runtimeType);
                                                                    print(int.parse(hedefDepo).runtimeType);
                                                                    print(tfIslemTarihi.text.runtimeType);

                                                                    isBaslat(tfIslemAdi.text, tfIslemAciklamasi.text, islemTuru,
                                                                        int.parse(anaDepo), int.parse(hedefDepo), tfIslemTarihi.text);
                                                                    // Navigator.push(
                                                                    //     context,
                                                                    //     MaterialPageRoute(
                                                                    //         builder: (context) => IslemTanim(
                                                                    //             islemTuru: islemTuru,
                                                                    //             islemAdi: tfIslemAdi.text,
                                                                    //             islemAciklamasi: tfIslemAciklamasi.text,
                                                                    //             islemTarihi: tfIslemTarihi.text)));
                                                                  }

                                                                  // print(
                                                                  //     'object');
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                    "Başlat",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFFDBDCE8),
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            2.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    isActive: _currentStep >= 0,
                                                    state: _currentStep >= 2
                                                        ? StepState.complete
                                                        : StepState.disabled,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            );

                            // AwesomeDialog(
                            //   context: context,
                            //   body: StatefulBuilder(
                            //       builder: (BuildContext context, StateSetter setState) {
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       // child: Column(
                            //       //   children: [
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     Text(
                            //       //         'Lütfen işlem başlatmadan önce işlem bilgilerini girin.',
                            //       //         style: GoogleFonts.notoSansTaiLe(
                            //       //           fontSize: 15,
                            //       //           color: Color(0XFF976775),
                            //       //         )),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     TextField(
                            //       //       controller: tfIslemAdi,
                            //       //       decoration: InputDecoration(
                            //       //         hintText: 'İşlem Adı',
                            //       //         hintStyle:
                            //       //             TextStyle(color: Color(0XFF976775)),
                            //       //         enabledBorder: OutlineInputBorder(
                            //       //           borderSide: BorderSide(
                            //       //               width: 1,
                            //       //               color: Color(0XFF463848)),
                            //       //         ),
                            //       //       ),
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     TextField(
                            //       //       controller: tfIslemAciklamasi,
                            //       //       decoration: InputDecoration(
                            //       //         hintText: 'İşlem Açıklaması',
                            //       //         hintStyle:
                            //       //             TextStyle(color: Color(0XFF976775)),
                            //       //         enabledBorder: OutlineInputBorder(
                            //       //           borderSide: BorderSide(
                            //       //               width: 1,
                            //       //               color: Color(0XFF463848)),
                            //       //         ),
                            //       //       ),
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     TextField(
                            //       //       controller: tfIslemTarihi,
                            //       //       decoration: InputDecoration(
                            //       //         hintText: 'İşlem Tarihi',
                            //       //         hintStyle:
                            //       //             TextStyle(color: Color(0XFF976775)),
                            //       //         enabledBorder: OutlineInputBorder(
                            //       //           borderSide: BorderSide(
                            //       //               width: 1,
                            //       //               color: Color(0XFF463848)),
                            //       //         ),
                            //       //       ),
                            //       //       readOnly: true,
                            //       //       //set it true, so that user will not able to edit text
                            //       //       onTap: () async {
                            //       //         DateTime? pickedDate = await showDatePicker(
                            //       //             builder: (context, child) {
                            //       //               return Theme(
                            //       //                 data:
                            //       //                     Theme.of(context).copyWith(
                            //       //                   colorScheme:
                            //       //                       ColorScheme.light(
                            //       //                     primary: Color(0xFF976775),
                            //       //                     // header background color
                            //       //                     onPrimary:
                            //       //                         Color(0XFF463848),
                            //       //                     // header text color
                            //       //                     onSurface: Color(
                            //       //                         0XFF463848), // body text color
                            //       //                   ),
                            //       //                   textButtonTheme:
                            //       //                       TextButtonThemeData(
                            //       //                     style: TextButton.styleFrom(
                            //       //                       primary: Color(
                            //       //                           0XFF463848), // button text color
                            //       //                     ),
                            //       //                   ),
                            //       //                 ),
                            //       //                 child: child!,
                            //       //               );
                            //       //             },
                            //       //             useRootNavigator: false,
                            //       //             cancelText: "Kapat",
                            //       //             confirmText: "Seç",
                            //       //             context: context,
                            //       //             initialDate: DateTime.now(),
                            //       //             firstDate: DateTime(2000),
                            //       //             //DateTime.now() - not to allow to choose before today.
                            //       //             lastDate: DateTime(2101));
                            //       //         if (pickedDate != null) {
                            //       //           String formattedDate =
                            //       //               DateFormat('dd-MM-yyyy')
                            //       //                   .format(pickedDate);
                            //       //           // print(formattedDate);
                            //       //           setState(() {
                            //       //             tfIslemTarihi.text = formattedDate;
                            //       //           });
                            //       //         } else {
                            //       //           print("Date is not selected");
                            //       //         }
                            //       //       },
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     // CustomSearchableDropDown(
                            //       //     //   decoration: BoxDecoration(
                            //       //     //       border: Border.all(
                            //       //     //           // color: Color(0XFF976775)
                            //       //     //       )
                            //       //     //   ),
                            //       //     //   dropdownHintText: 'Ana Nokta',
                            //       //     //   dropdownItemStyle: const TextStyle(color: Color(0XFF976775)),
                            //       //     //   menuMode: true,
                            //       //     //   items: cevap.map((item) {
                            //       //     //     return DropdownMenuItem(
                            //       //     //       value: item.id.toString(),
                            //       //     //       child: Text(item.ad.toString()),
                            //       //     //
                            //       //     //     );
                            //       //     //   }).toList(),
                            //       //     //   onChanged: (newVal) {
                            //       //     //     // dropdownvalue = newVal;
                            //       //     //
                            //       //     //   },
                            //       //     //   label: 'Ana Nokta Seçin',
                            //       //     //   labelStyle: const TextStyle(color: Colors.red),
                            //       //     //   dropDownMenuItems: cevap.map((item) {
                            //       //     //
                            //       //     //     // print(item.markaAdi);
                            //       //     //     return item.ad;
                            //       //     //   }).toList() ??
                            //       //     //       [],
                            //       //     // ),
                            //       //     DropdownButtonFormField(
                            //       //       decoration: InputDecoration(
                            //       //           hintStyle: TextStyle(
                            //       //               color: Color(0XFF976775)),
                            //       //           hintText: "İşlem Türü",
                            //       //           border: OutlineInputBorder(
                            //       //               borderSide: BorderSide(
                            //       //                   color: Color(0XFF6E3F52),
                            //       //                   width: 3))),
                            //       //       items: list.map<DropdownMenuItem<String>>(
                            //       //           (String value) {
                            //       //         return DropdownMenuItem<String>(
                            //       //           value: value,
                            //       //           child: Text(value,
                            //       //               style: TextStyle(
                            //       //                   color: Color(0XFF976775))),
                            //       //         );
                            //       //       }).toList(),
                            //       //       onChanged: (newVal) {
                            //       //         setState(() {
                            //       //           islemTuru = newVal;
                            //       //         });
                            //       //       },
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     DropdownButtonFormField(
                            //       //       decoration: InputDecoration(
                            //       //           hintStyle: TextStyle(
                            //       //               color: Color(0XFF976775)),
                            //       //           hintText: "Ana Nokta",
                            //       //           border: OutlineInputBorder(
                            //       //               borderSide: BorderSide(
                            //       //                   color: Color(0XFF6E3F52),
                            //       //                   width: 3))),
                            //       //       items: cevap.map(
                            //       //               (Data value) {
                            //       //             return DropdownMenuItem<String>(
                            //       //               value: value.id.toString(),
                            //       //               child: Text(value.ad.toString(),
                            //       //                   style: TextStyle(
                            //       //                       color: Color(0XFF976775))),
                            //       //             );
                            //       //           }).toList(),
                            //       //       onChanged: (newVal) {
                            //       //         setState(() {
                            //       //           islemTuru = newVal;
                            //       //         });
                            //       //       },
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //
                            //       //     DropdownButtonFormField(
                            //       //       decoration: InputDecoration(
                            //       //           hintStyle: TextStyle(
                            //       //               color: Color(0XFF976775)),
                            //       //           hintText: "Hedef Nokta",
                            //       //           border: OutlineInputBorder(
                            //       //               borderSide: BorderSide(
                            //       //                   color: Color(0XFF6E3F52),
                            //       //                   width: 3))),
                            //       //       items: list.map<DropdownMenuItem<String>>(
                            //       //               (String value) {
                            //       //             return DropdownMenuItem<String>(
                            //       //               value: value,
                            //       //               child: Text(value,
                            //       //                   style: TextStyle(
                            //       //                       color: Color(0XFF976775))),
                            //       //             );
                            //       //           }).toList(),
                            //       //       onChanged: (newVal) {
                            //       //         setState(() {
                            //       //           islemTuru = newVal;
                            //       //         });
                            //       //       },
                            //       //     ),
                            //       //     SizedBox(
                            //       //       height: 15,
                            //       //     ),
                            //       //     AnimatedButton(
                            //       //         color: Color(0XFF463848),
                            //       //         text: 'Başlat',
                            //       //         pressEvent: () {
                            //       //           print(tfIslemAdi.text);
                            //       //           if (tfIslemAdi.text == "") {
                            //       //             ScaffoldMessenger.of(context)
                            //       //                 .showSnackBar(SnackBar(
                            //       //               backgroundColor: Colors.red,
                            //       //               content: const Text(
                            //       //                   'İşlem adını boş bırakamazsınız.'),
                            //       //               duration:
                            //       //                   const Duration(seconds: 2),
                            //       //             ));
                            //       //           } else if (tfIslemAciklamasi.text ==
                            //       //               "") {
                            //       //             ScaffoldMessenger.of(context)
                            //       //                 .showSnackBar(SnackBar(
                            //       //               backgroundColor: Colors.red,
                            //       //               content: const Text(
                            //       //                   'İşlem açıklamasını boş bırakamazsınız.'),
                            //       //               duration:
                            //       //                   const Duration(seconds: 2),
                            //       //             ));
                            //       //           } else if (tfIslemAciklamasi.text ==
                            //       //               "") {
                            //       //             ScaffoldMessenger.of(context)
                            //       //                 .showSnackBar(SnackBar(
                            //       //               backgroundColor: Colors.red,
                            //       //               content: const Text(
                            //       //                   'İşlem tarihini boş bırakamazsınız.'),
                            //       //               duration:
                            //       //                   const Duration(seconds: 2),
                            //       //             ));
                            //       //           } else {
                            //       //
                            //       //             String islemAdi = tfIslemAdi.text;
                            //       //             String islemTarihi = tfIslemTarihi.text;
                            //       //             String islemAciklamasi = tfIslemAciklamasi.text;
                            //       //             print("*");
                            //       //             print(islemAdi);
                            //       //             print(islemTarihi);
                            //       //             print("*");
                            //       //
                            //       //             tfIslemAdi.clear();
                            //       //             tfIslemAciklamasi.clear();
                            //       //             tfIslemTarihi.clear();
                            //       //             Navigator.push(
                            //       //                 context,
                            //       //                 MaterialPageRoute(
                            //       //                     builder: (context) =>
                            //       //                         IslemTurDetay(
                            //       //                             islemTuru:
                            //       //                                 islemTuru,
                            //       //                             islemAdi:
                            //       //                                 islemAdi,
                            //       //                             islemAciklamasi:
                            //       //                                 islemAciklamasi,
                            //       //                             islemTarihi:
                            //       //                                 islemTarihi)));
                            //       //           }
                            //       //         })
                            //       //   ],
                            //       // ),
                            //       child: Stepper(
                            //         type: stepperType,
                            //         physics: ScrollPhysics(),
                            //         currentStep: _currentStep,
                            //         onStepTapped: (step) => tapped(step),
                            //         onStepContinue:  continued,
                            //         onStepCancel: cancel,
                            //         steps: <Step>[
                            //           Step(
                            //             title: new Text('Account'),
                            //             content: Column(
                            //               children: <Widget>[
                            //                 TextFormField(
                            //                   decoration: InputDecoration(labelText: 'Email Address'),
                            //                 ),
                            //                 TextFormField(
                            //                   decoration: InputDecoration(labelText: 'Password'),
                            //                 ),
                            //               ],
                            //             ),
                            //             isActive: _currentStep >= 0,
                            //             state: _currentStep >= 0 ?
                            //             StepState.complete : StepState.disabled,
                            //           ),
                            //           Step(
                            //             title: new Text('Address'),
                            //             content: Column(
                            //               children: <Widget>[
                            //                 TextFormField(
                            //                   decoration: InputDecoration(labelText: 'Home Address'),
                            //                 ),
                            //                 TextFormField(
                            //                   decoration: InputDecoration(labelText: 'Postcode'),
                            //                 ),
                            //               ],
                            //             ),
                            //             isActive: _currentStep >= 0,
                            //             state: _currentStep >= 1 ?
                            //             StepState.complete : StepState.disabled,
                            //           ),
                            //           Step(
                            //             title: new Text('Mobile Number'),
                            //             content: Column(
                            //               children: <Widget>[
                            //                 TextFormField(
                            //                   decoration: InputDecoration(labelText: 'Mobile Number'),
                            //                 ),
                            //               ],
                            //             ),
                            //             isActive:_currentStep >= 0,
                            //             state: _currentStep >= 2 ?
                            //             StepState.complete : StepState.disabled,
                            //           ),
                            //         ],
                            //       ),
                            //     );}
                            //   ),
                            //   dialogType: DialogType.noHeader,
                            //   borderSide: const BorderSide(
                            //     color: Color(0XFF6E3F52),
                            //     width: 2,
                            //   ),
                            //   width: MediaQuery.of(context).size.width,
                            //   buttonsBorderRadius: const BorderRadius.all(
                            //     Radius.circular(2),
                            //   ),
                            //   dismissOnTouchOutside: true,
                            //   dismissOnBackKeyPress: false,
                            //   headerAnimationLoop: false,
                            //   animType: AnimType.bottomSlide,
                            //   showCloseIcon: true,
                            // ).show();
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
