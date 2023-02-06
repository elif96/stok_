import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/Islem_bilgileri.dart';
import 'package:stok_takip_uygulamasi/model/ProductCategory.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcessDto.dart';
import 'package:stok_takip_uygulamasi/model/Warehouse.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/model/myDataSingle.dart';
import 'package:stok_takip_uygulamasi/model/myWareHouse.dart';
import 'package:stok_takip_uygulamasi/stokBul.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class IsBaslat extends StatefulWidget {
  const IsBaslat({Key? key}) : super(key: key);

  @override
  State<IsBaslat> createState() => _IsBaslatState();
}

class _IsBaslatState extends State<IsBaslat> {
  var tfIslemAciklamasi = TextEditingController();
  TextEditingController tfIslemTarihi = TextEditingController();
  TextEditingController tfIslemAdi = TextEditingController();

  @override
  initState() {
    super.initState();
    // warehouseListele();
    setState(() {});
    // hedefWarehouseListele("");

  }
  var islemTuru;
  var anaDepo;
  var hedefDepo;

  final List<String> liste = [
    "Avans Yoluyla", //Giriş
    "İhale Yoluyla", //Giriş
    "Satınalma", //Giriş
    "Üretim", //Giriş
    "Transfer", //Departman İçi Hareket
    "Zimmet", //Departman İçi Hareket
    "Zimmet İade", //Departman İçi Hareket
    "Devir", //Departman İçi Hareket
    "Hibe", //Çıkış
    "Hurdaya Ayırma", //Çıkış
    "Tüketim", //Çıkış
  ];

  List user = [
    {"name": "Avans Yoluyla", "id": "1"},
    {"name": "İhale Yoluyla", "id": "2"},
    {"name": "Satınalma", "id": "3"},
    {"name": "Üretim", "id": "4"},
    {"name": "Transfer", "id": "5"},
    {"name": "Zimmet", "id": "6"},
    {"name": "Zimmet İade", "id": "7"},
    {"name": "Devir", "id": "8"},
    {"name": "Hibe", "id": "9"},
    {"name": "Hurdaya Ayırma", "id": "10"},
    {"name": "Tüketim", "id": "11"},
  ];

//Giriş İşlemleri
//   [Display(Name = "Avans Yoluyla")]
//   AVANS = 1,
//   [Display(Name = "İhale Yoluyla")]
//   IHALE = 2,
//   [Display(Name = "Satınalma")]
//   SATINALMA = 3,
//   [Display(Name = "Üretim")]
//   URETIM = 4,
//
//   //Departman İçi Hareket
//   [Display(Name = "Transfer")]
//   TRANSFER = 5,
//   [Display(Name = "Zimmet")]
//   ZIMMET = 6,
//   [Display(Name = "Zimmet İade")]
//   ZIMMETIADE = 7,
//   [Display(Name = "Devir")]
//   DEVIR = 8,
//
//   //Çıkış İşlemleri
//   [Display(Name = "Hibe")]
//   HIBE = 9,
//   [Display(Name = "Hurdaya Ayırma")]
//   HURDA = 10,
//   [Display(Name = "Tüketim")]
//   TUKETIM = 11,

  myData<myWareHouse> cevaps = myData<myWareHouse>();

  Future<myData<myWareHouse>> warehouseListele(String islemTuru) async {
    print(islemTuru);
    if (islemTuru == "1" ||
        islemTuru == "2" ||
        islemTuru == "3" ||
        islemTuru == "4") {
      anaDepo = "0";
      cevaps = myData<myWareHouse>();
      hedefWarehouseListele(islemTuru);
    } else if (islemTuru == "5") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));
      cevaps = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    } else if (islemTuru == "7") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=2&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));
      cevaps = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    } else if (islemTuru == "8") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));
      cevaps = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    } else {
      http.Response res = await http
          .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Warehouses'));
      // print(res.body);
      cevaps = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    }
    print(cevaps);
    // print(cevaps.data![0].ad);
    return cevaps;
  }

  myData<myWareHouse> cevapHedef = myData<myWareHouse>();

  Future<myData<myWareHouse>> hedefWarehouseListele(String islemTuru) async {
    print(islemTuru);
    if (islemTuru == "1" ||
        islemTuru == "2" ||
        islemTuru == "3" ||
        islemTuru == "4") {
      anaDepo = "0";
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));

      cevapHedef = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);

    }
    else if (islemTuru == "9" || islemTuru == "10" || islemTuru == "11") {
      hedefDepo ="0";
      cevapHedef = myData<myWareHouse>();
      warehouseListele(islemTuru);
    } else if (islemTuru == "6") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=2&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));

      cevapHedef = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    }else if (islemTuru == "5") {
      hedefDepo ="0";
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));
      cevaps = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    }  else if (islemTuru == "7") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));

      cevapHedef = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    }  else if (islemTuru == "8") {
      http.Response res = await http.get(Uri.parse(
          'https://stok.bahcelievler.bel.tr/api/Warehouses/GetAll?CinsFilter=1&DepartmentIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=false&includeChildren=false'));

      cevapHedef = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    } else {
      http.Response res = await http
          .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Warehouses'));
      // print(res.body);
      cevapHedef = myData<myWareHouse>.fromJson(
          json.decode(res.body), myWareHouse.fromJsonModel);
    }
    print(cevapHedef);
    // print(cevaps.data![0].ad);
    return cevapHedef;
  }

  List<Data> cevap = <Data>[];

  // Future<List<Data>> warehouseListele() async {
  //   http.Response res = await http
  //       .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Warehouses'));
  //   cevap = Warehouse.fromJson(json.decode(res.body)).data.toList();
  //   print(cevap);
  //   print(cevap[0].ad);
  //   return cevap;
  // }

  int _currentStep = 0;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  // late myDataSingle<ProductProcessDto> islemid = myDataSingle<ProductProcessDto>();
  //
  // Future<myDataSingle<ProductProcessDto>> productP() async {
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/ProductProcesses/181'));
  //   islemid = myDataSingle<ProductProcessDto>.fromJson(
  //       json.decode(res.body), ProductProcessDto.fromJsonModel);
  //
  //   // print(islemid.data![0].id);
  //
  //   setState(() {});
  //   return islemid;
  // }

  myDataSingle<ProductProcess> islemBilgileri = myDataSingle<ProductProcess>();

  Future<void> isBaslat(String islemAdi, String islemAciklama, int islemTuru,
      int? anaDepoId, int? hedefDepoId, String islemTarihi) async {
    var url =
        Uri.parse('https://stok.bahcelievler.bel.tr/api/ProductProcesses');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "islemAdi": tfIslemAdi.text,
          "islemAciklama": tfIslemAciklamasi.text,
          "islemTuru": islemTuru,
          "anaDepoId": anaDepo,
          "hedefDepoID": hedefDepo,
          "islemTarihi": tfIslemTarihi.text
        }));
    print('object');
    print(response.body);

    islemBilgileri = myDataSingle<ProductProcess>.fromJson(
        json.decode(response.body), ProductProcess.fromJsonModel);

    // islemId = myData<ProductProcess>.fromJson(
    //     json.decode(response.body), ProductProcess.fromJsonModel);
    // // islemId = myData<ProductProcess>.fromJson(jsonDecode(response.body), ProductProcess.fromJsonModel);
    // // islemId = myData<ProductProcess>.fromJson(
    // //     json.decode(response.body), ProductProcess.fromJsonModel);
    // print(islemId);

    if (response.reasonPhrase == 'Bad Request') {
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bir sorun oluştu."),
        backgroundColor: Colors.red,
      ));
      // tfIslemAdi.clear();
      setState(() {});
    } else if (response.reasonPhrase == 'Created') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İş başlatma işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));

      // tfIslemAdi.clear();
      // print(islemBilgileri.data!.id);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IslemBilgileri(
                  islemTuru: islemTuru.toString(),
                  anaDepo: anaDepo == null ? 0 : int.parse(anaDepo),
                  hedefDepo: hedefDepo == null ? 0 : int.parse(hedefDepo),
                  islemAdi: tfIslemAdi.text,
                  islemAciklamasi: tfIslemAciklamasi.text,
                  islemTarihi: tfIslemTarihi.text,
                  islemId: islemBilgileri.data!.id)));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        primary: true,
        backgroundColor: const Color(0xFF976775),
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
                              side: const BorderSide(
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
                                                      primary: const Color(
                                                          0xFF976775),
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
                                                physics: const ScrollPhysics(),
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
                                                          color: const Color(
                                                              0XFF976775),
                                                        )),
                                                    content: Column(
                                                      children: <Widget>[
                                                        TextField(
                                                          controller:
                                                              tfIslemAdi,
                                                          decoration:
                                                              const InputDecoration(
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
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              tfIslemAciklamasi,
                                                          decoration:
                                                              const InputDecoration(
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
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              tfIslemTarihi,
                                                          decoration:
                                                              const InputDecoration(
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
                                                                              const ColorScheme.light(
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
                                                                              foregroundColor: const Color(0XFF463848), // button text color
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
                                                                          'yyyy-MM-dd')
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
                                                        const SizedBox(
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
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                child: const Text(
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
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                child: const Text(
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
                                                    title: Text(
                                                        'İşlem Türü seçiniz.',
                                                        style: GoogleFonts
                                                            .notoSansTaiLe(
                                                          fontSize: 15,
                                                          color: const Color(
                                                              0XFF976775),
                                                        )),
                                                    content: Column(
                                                      children: <Widget>[
                                                        DropdownButtonFormField(
                                                          decoration: const InputDecoration(
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
                                                          items:
                                                              user.map((value) {
                                                            return DropdownMenuItem(
                                                              value:
                                                                  value['id'],
                                                              child: Text(
                                                                  value['name'],
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0XFF976775))),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            setState(() {
                                                              islemTuru =
                                                                  newVal;
                                                            });
                                                            warehouseListele(
                                                                islemTuru);
                                                            hedefWarehouseListele(
                                                                islemTuru);
                                                            print(islemTuru);
                                                          },
                                                        ),
                                                        const SizedBox(
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
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                child: const Text(
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
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                child: const Text(
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
                                                          color: const Color(
                                                              0XFF976775),
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
                                                          items: cevaps.data ==
                                                                  null
                                                              ? []
                                                              : cevaps.data?.map(
                                                                  (myWareHouse
                                                                      value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: value
                                                                        .id
                                                                        .toString(),
                                                                    child: Text(
                                                                        value.ad
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0XFF976775))),
                                                                  );
                                                                }).toList(),

                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  anaDepo =
                                                                      value),

                                                          // setState(() {
                                                          //   anaDepo = newVal;
                                                          // });
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        DropdownButtonFormField(
                                                          decoration: const InputDecoration(
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
                                                          items: cevapHedef.data
                                                              ?.map((myWareHouse
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value.id
                                                                  .toString(),
                                                              child: Text(
                                                                  value.ad
                                                                      .toString(),
                                                                  style: const TextStyle(
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
                                                        const SizedBox(
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
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                child: const Text(
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
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0XFF463848),
                                                                  side: const BorderSide(
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
                                                                            const SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'İşlem adını boş bırakamazsınız.'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (tfIslemAciklamasi
                                                                          .text ==
                                                                      "") {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'İşlem açıklamasını boş bırakamazsınız.'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  } else if (tfIslemTarihi
                                                                          .text ==
                                                                      "") {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'İşlem tarihini boş bırakamazsınız.'),
                                                                      duration: Duration(
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
                                                                            const SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'İşlem türü seçmelisiniz.'),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                    ));
                                                                  }
                                                                  // else if (anaDepo ==
                                                                  //         "" ||
                                                                  //     anaDepo ==
                                                                  //         null) {
                                                                  //   ScaffoldMessenger.of(
                                                                  //           context)
                                                                  //       .showSnackBar(
                                                                  //           const SnackBar(
                                                                  //     backgroundColor:
                                                                  //         Colors
                                                                  //             .red,
                                                                  //     content: Text(
                                                                  //         'Ana nokta seçmelisiniz.'),
                                                                  //     duration: Duration(
                                                                  //         seconds:
                                                                  //             2),
                                                                  //   ));
                                                                  // } else if (hedefDepo ==
                                                                  //         "" ||
                                                                  //     hedefDepo ==
                                                                  //         null) {
                                                                  //   ScaffoldMessenger.of(
                                                                  //           context)
                                                                  //       .showSnackBar(
                                                                  //           const SnackBar(
                                                                  //     backgroundColor:
                                                                  //         Colors
                                                                  //             .red,
                                                                  //     content: Text(
                                                                  //         'Hedef nokta seçmelisiniz.'),
                                                                  //     duration: Duration(
                                                                  //         seconds:
                                                                  //             2),
                                                                  //   ));
                                                                  // }
                                                                  else {
                                                                    // String
                                                                    //     islemAdi =
                                                                    //     tfIslemAdi
                                                                    //         .text;
                                                                    // String
                                                                    //     islemTarihi =
                                                                    //     tfIslemTarihi
                                                                    //         .text;
                                                                    // String
                                                                    //     islemAciklamasi =
                                                                    //     tfIslemAciklamasi
                                                                    //         .text;
                                                                    //
                                                                    // tfIslemAdi
                                                                    //     .clear();
                                                                    // tfIslemAciklamasi
                                                                    //     .clear();
                                                                    // tfIslemTarihi
                                                                    //     .clear();
                                                                    print(
                                                                        "Ana Depo: ${anaDepo}");
                                                                    print(
                                                                        "Hedef Depo: ${hedefDepo}");

                                                                    isBaslat(
                                                                        tfIslemAdi
                                                                            .text,
                                                                        tfIslemAciklamasi
                                                                            .text,
                                                                        int.parse(
                                                                            islemTuru),

                                                                            anaDepo == null ? 0 : int.parse(
                                                                            anaDepo),
                                                                        hedefDepo == null ? 0 : int.parse(
                                                                            hedefDepo),
                                                                        tfIslemTarihi
                                                                            .text);
                                                                  }

                                                                  // print(
                                                                  //     'object');
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: const Text(
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
                                  color: const Color(0XFF976775),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Icon(
                                Icons.play_circle,
                                color: Color(0XFF976775),
                              ),
                            ],
                          ))),
                  const SizedBox(height: 25),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 2.0, color: Color(0XFF976775))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const stokBul()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'STOK BUL ',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: const Color(0XFF976775),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Icon(
                                Icons.search_outlined,
                                color: Color(0XFF976775),
                              ),
                            ],
                          ))),
                  const SizedBox(height: 25),
                  Card(
                    color: const Color(0XFFDBDCE8),
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
                                  color: const Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: const Color(0XFF6E3F52),
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
                    color: const Color(0XFFDBDCE8),
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
                                  color: const Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: const Color(0XFF6E3F52),
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
                    color: const Color(0XFFDBDCE8),
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
                                  color: const Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: const Color(0XFF6E3F52),
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
                    color: const Color(0XFFDBDCE8),
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
                                  color: const Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                '7689',
                                style: GoogleFonts.notoSansTaiLe(
                                  fontSize: 18,
                                  color: const Color(0XFF6E3F52),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
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

  Widget Gir(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SingleChildScrollView(
                child: Theme(
                  data: ThemeData(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: const Color(0xFF976775),
                          background: Colors.red,
                          secondary: Colors.red,
                        ),
                  ),
                  child: Stepper(
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Row(
                        children: <Widget>[],
                      );
                    },
                    physics: const ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    steps: <Step>[
                      Step(
                        title: Text(
                            'Lütfen işlem başlatmadan önce işlem bilgilerini girin.',
                            style: GoogleFonts.notoSansTaiLe(
                              fontSize: 15,
                              color: const Color(0XFF976775),
                            )),
                        content: Column(
                          children: <Widget>[
                            TextField(
                              controller: tfIslemAdi,
                              decoration: const InputDecoration(
                                hintText: 'İşlem Adı',
                                hintStyle: TextStyle(color: Color(0XFF976775)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0XFF463848)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: tfIslemAciklamasi,
                              decoration: const InputDecoration(
                                hintText: 'İşlem Açıklaması',
                                hintStyle: TextStyle(color: Color(0XFF976775)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0XFF463848)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: tfIslemTarihi,
                              decoration: const InputDecoration(
                                hintText: 'İşlem Tarihi',
                                hintStyle: TextStyle(color: Color(0XFF976775)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0XFF463848)),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    locale: const Locale("tr", "TR"),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(0xFF976775),
                                            // header background color
                                            onPrimary: Color(0XFF463848),
                                            // header text color
                                            onSurface: Color(
                                                0XFF463848), // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: const Color(
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
                                      DateFormat('yyyy-MM-dd')
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
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      _currentStep > 0
                                          ? setState(() => _currentStep -= 1)
                                          : null;
                                    },
                                    child: const Text("Geri",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      _currentStep < 2
                                          ? setState(() => _currentStep += 1)
                                          : null;
                                      setState(() {});
                                    },
                                    child: const Text("İleri",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
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
                        title: Text('İşlem Türü seçiniz.',
                            style: GoogleFonts.notoSansTaiLe(
                              fontSize: 15,
                              color: const Color(0XFF976775),
                            )),
                        content: Column(
                          children: <Widget>[
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Color(0XFF976775)),
                                  hintText: "İşlem Türü",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0XFF6E3F52), width: 3))),
                              items: liste.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          color: Color(0XFF976775))),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  islemTuru = newVal;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      _currentStep > 0
                                          ? setState(() => _currentStep -= 1)
                                          : null;
                                    },
                                    child: const Text("Geri",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      _currentStep < 2
                                          ? setState(() => _currentStep += 1)
                                          : null;
                                      setState(() {});
                                    },
                                    child: const Text("İleri",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
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
                        title: Text('Ana ve Hedef Nokta seçiniz.',
                            style: GoogleFonts.notoSansTaiLe(
                              fontSize: 15,
                              color: const Color(0XFF976775),
                            )),
                        content: Column(
                          children: <Widget>[
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Color(0XFF976775)),
                                  hintText: "Ana Nokta",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0XFF6E3F52), width: 3))),
                              items: cevaps.data == null
                                  ? []
                                  : cevaps.data?.map((myWareHouse value) {
                                      return DropdownMenuItem<String>(
                                        value: value.id.toString(),
                                        child: Text(value.ad.toString(),
                                            style: const TextStyle(
                                                color: Color(0XFF976775))),
                                      );
                                    }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  anaDepo = newVal;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Color(0XFF976775)),
                                  hintText: "Hedef Nokta",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0XFF6E3F52), width: 3))),
                              items: cevaps.data?.map((myWareHouse value) {
                                return DropdownMenuItem<String>(
                                  value: value.id.toString(),
                                  child: Text(value.ad.toString(),
                                      style: const TextStyle(
                                          color: Color(0XFF976775))),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  hedefDepo = newVal;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      _currentStep > 0
                                          ? setState(() => _currentStep -= 1)
                                          : null;
                                    },
                                    child: const Text("Geri",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0XFF463848),
                                      side: const BorderSide(
                                          width: 1.0, color: Color(0XFF463848)),
                                    ),
                                    onPressed: () {
                                      if (tfIslemAdi.text == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'İşlem adını boş bırakamazsınız.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else if (tfIslemAciklamasi.text == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'İşlem açıklamasını boş bırakamazsınız.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else if (tfIslemTarihi.text == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'İşlem tarihini boş bırakamazsınız.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else if (islemTuru == "" ||
                                          islemTuru == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('İşlem türü seçmelisiniz.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else if (anaDepo == "" ||
                                          anaDepo == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('Ana nokta seçmelisiniz.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else if (hedefDepo == "" ||
                                          hedefDepo == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('Hedef nokta seçmelisiniz.'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else {
                                        // String
                                        //     islemAdi =
                                        //     tfIslemAdi
                                        //         .text;
                                        // String
                                        //     islemTarihi =
                                        //     tfIslemTarihi
                                        //         .text;
                                        // String
                                        //     islemAciklamasi =
                                        //     tfIslemAciklamasi
                                        //         .text;
                                        //
                                        // tfIslemAdi
                                        //     .clear();
                                        // tfIslemAciklamasi
                                        //     .clear();
                                        // tfIslemTarihi
                                        //     .clear();
                                        print("Ana Depo: ${anaDepo}");
                                        print("Hedef Depo: ${hedefDepo}");

                                        isBaslat(
                                            tfIslemAdi.text,
                                            tfIslemAciklamasi.text,
                                            int.parse(islemTuru),
                                            int.parse(anaDepo),
                                            int.parse(hedefDepo),
                                            tfIslemTarihi.text);
                                      }

                                      // print(
                                      //     'object');
                                      setState(() {});
                                    },
                                    child: const Text("Başlat",
                                        style: TextStyle(
                                            color: Color(0XFFDBDCE8),
                                            fontSize: 15,
                                            letterSpacing: 2.0)),
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
  }
}

// class WidgetGiris extends StatefulWidget {
//   const WidgetGiris({Key? key}) : super(key: key);
//
//   @override
//   State<WidgetGiris> createState() => _WidgetGirisState();
// }
//
// class _WidgetGirisState extends State<WidgetGiris> {
//   var islemTuru;
//   var islemAdi;
//   var islemAciklamasi;
//   var islemTarihi;
//   var anaDepo;
//   var hedefDepo;
//   var tfIslemAciklamasi = TextEditingController();
//   TextEditingController tfIslemTarihi = TextEditingController();
//   TextEditingController tfIslemAdi = TextEditingController();
//   int _currentStep = 0;
//   myData<myWareHouse> cevaps = myData<myWareHouse>();
//
//   Future<myData<myWareHouse>> warehouseListele() async {
//     http.Response res = await http
//         .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Warehouses'));
//     // print(res.body);
//
//     cevaps = myData<myWareHouse>.fromJson(
//         json.decode(res.body), myWareHouse.fromJsonModel);
//
//     print(cevaps);
//     print(cevaps.data![0].ad);
//     return cevaps;
//   }
//
//   List<String> liste = [ "Avans Yoluyla", //Giriş
//     "İhale Yoluyla", //Giriş
//     "Satınalma", //Giriş
//     "Üretim", //Giriş
//     "Transfer", //Departman İçi Hareket
//     "Zimmet",  //Departman İçi Hareket
//     "Zimmet İade" , //Departman İçi Hareket
//     "Devir" , //Departman İçi Hareket
//     "Hibe",  //Çıkış
//     "Hurdaya Ayırma" , //Çıkış
//     "Tüketim", //Çıkış
//   ];
//
//   myDataSingle<ProductProcess> islemBilgileri = myDataSingle<ProductProcess>();
//
//   Future<void> isBaslat(String islemAdi, String islemAciklama, int islemTuru,
//       int anaDepoId, int hedefDepoId, String islemTarihi) async {
//     var url =
//     Uri.parse('https://stok.bahcelievler.bel.tr/api/ProductProcesses');
//     http.Response response = await http.post(url,
//         headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
//         body: json.encoder.convert({
//           "islemAdi": tfIslemAdi.text,
//           "islemAciklama": tfIslemAciklamasi.text,
//           "islemTuru": islemTuru,
//           "anaDepoId": int.parse(anaDepo),
//           "hedefDepoID": int.parse(hedefDepo),
//           "islemTarihi": tfIslemTarihi.text
//         }));
//     print('object');
//     print(response.body);
//
//     islemBilgileri = myDataSingle<ProductProcess>.fromJson(
//         json.decode(response.body), ProductProcess.fromJsonModel);
//
//     // islemId = myData<ProductProcess>.fromJson(
//     //     json.decode(response.body), ProductProcess.fromJsonModel);
//     // // islemId = myData<ProductProcess>.fromJson(jsonDecode(response.body), ProductProcess.fromJsonModel);
//     // // islemId = myData<ProductProcess>.fromJson(
//     // //     json.decode(response.body), ProductProcess.fromJsonModel);
//     // print(islemId);
//
//     if (response.reasonPhrase == 'Bad Request') {
//       //model olduğu için marka silinemedi
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Bir sorun oluştu."),
//         backgroundColor: Colors.red,
//       ));
//       // tfIslemAdi.clear();
//       setState(() {});
//     } else if (response.reasonPhrase == 'Created') {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("İş başlatma işlemi başarıyla gerçekleştirildi."),
//         backgroundColor: Colors.green,
//       ));
//
//       // tfIslemAdi.clear();
//       // print(islemBilgileri.data!.id);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => IslemBilgileri(
//                   islemTuru: islemTuru.toString(),
//                   anaDepo: int.parse(anaDepo),
//                   hedefDepo: int.parse(hedefDepo),
//                   islemAdi: tfIslemAdi.text,
//                   islemAciklamasi: tfIslemAciklamasi.text,
//                   islemTarihi: tfIslemTarihi.text,
//                   islemId: islemBilgileri.data!.id)));
//       setState(() {});
//     }
//   }
//
//   tapped(int step) {
//     setState(() => _currentStep = step);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return AlertDialog(
//           actions: <Widget>[
//             Container(
//               width:
//               MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context)
//                   .size
//                   .height /
//                   2,
//               child: SingleChildScrollView(
//                 child: Theme(
//                   data: ThemeData(
//                     colorScheme: Theme.of(context)
//                         .colorScheme
//                         .copyWith(
//                       primary: const Color(
//                           0xFF976775),
//                       background: Colors.red,
//                       secondary: Colors.red,
//                     ),
//                   ),
//                   child: Stepper(
//                     controlsBuilder: (BuildContext
//                     context,
//                         ControlsDetails details) {
//                       return Row(
//                         children: <Widget>[],
//                       );
//                     },
//                     physics: const ScrollPhysics(),
//                     currentStep: _currentStep,
//                     onStepTapped: (step) =>
//                         tapped(step),
//                     steps: <Step>[
//                       Step(
//                         title: Text(
//                             'Lütfen işlem başlatmadan önce işlem bilgilerini girin.',
//                             style: GoogleFonts
//                                 .notoSansTaiLe(
//                               fontSize: 15,
//                               color: const Color(
//                                   0XFF976775),
//                             )),
//                         content: Column(
//                           children: <Widget>[
//                             TextField(
//                               controller:
//                               tfIslemAdi,
//                               decoration:
//                               const InputDecoration(
//                                 hintText:
//                                 'İşlem Adı',
//                                 hintStyle: TextStyle(
//                                     color: Color(
//                                         0XFF976775)),
//                                 enabledBorder:
//                                 OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1,
//                                       color: Color(
//                                           0XFF463848)),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             TextField(
//                               controller:
//                               tfIslemAciklamasi,
//                               decoration:
//                               const InputDecoration(
//                                 hintText:
//                                 'İşlem Açıklaması',
//                                 hintStyle: TextStyle(
//                                     color: Color(
//                                         0XFF976775)),
//                                 enabledBorder:
//                                 OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1,
//                                       color: Color(
//                                           0XFF463848)),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             TextField(
//                               controller:
//                               tfIslemTarihi,
//                               decoration:
//                               const InputDecoration(
//                                 hintText:
//                                 'İşlem Tarihi',
//                                 hintStyle: TextStyle(
//                                     color: Color(
//                                         0XFF976775)),
//                                 enabledBorder:
//                                 OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1,
//                                       color: Color(
//                                           0XFF463848)),
//                                 ),
//                               ),
//                               readOnly: true,
//                               onTap: () async {
//                                 DateTime? pickedDate =
//                                 await showDatePicker(
//                                     locale: const Locale(
//                                         "tr",
//                                         "TR"),
//                                     builder:
//                                         (context,
//                                         child) {
//                                       return Theme(
//                                         data: Theme.of(context)
//                                             .copyWith(
//                                           colorScheme:
//                                           const ColorScheme.light(
//                                             primary:
//                                             Color(0xFF976775),
//                                             // header background color
//                                             onPrimary:
//                                             Color(0XFF463848),
//                                             // header text color
//                                             onSurface:
//                                             Color(0XFF463848), // body text color
//                                           ),
//                                           textButtonTheme:
//                                           TextButtonThemeData(
//                                             style:
//                                             TextButton.styleFrom(
//                                               foregroundColor: const Color(0XFF463848), // button text color
//                                             ),
//                                           ),
//                                         ),
//                                         child:
//                                         child!,
//                                       );
//                                     },
//                                     useRootNavigator:
//                                     false,
//                                     cancelText:
//                                     "Kapat",
//                                     confirmText:
//                                     "Seç",
//                                     context:
//                                     context,
//                                     initialDate:
//                                     DateTime
//                                         .now(),
//                                     firstDate:
//                                     DateTime(
//                                         2000),
//                                     //DateTime.now() - not to allow to choose before today.
//                                     lastDate:
//                                     DateTime(
//                                         2101));
//                                 if (pickedDate !=
//                                     null) {
//                                   String
//                                   formattedDate =
//                                   DateFormat(
//                                       'yyyy-MM-dd')
//                                       .format(
//                                       pickedDate);
//                                   // print(formattedDate);
//                                   setState(() {
//                                     tfIslemTarihi
//                                         .text =
//                                         formattedDate;
//                                   });
//                                 } else {
//                                   print(
//                                       "Date is not selected");
//                                 }
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       _currentStep >
//                                           0
//                                           ? setState(() =>
//                                       _currentStep -=
//                                       1)
//                                           : null;
//                                     },
//                                     child: const Text(
//                                         "Geri",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       _currentStep <
//                                           2
//                                           ? setState(() =>
//                                       _currentStep +=
//                                       1)
//                                           : null;
//                                       setState(
//                                               () {});
//                                     },
//                                     child: const Text(
//                                         "İleri",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 0
//                             ? StepState.complete
//                             : StepState.disabled,
//                       ),
//                       Step(
//                         title: Text(
//                             'İşlem Türü seçiniz.',
//                             style: GoogleFonts
//                                 .notoSansTaiLe(
//                               fontSize: 15,
//                               color: const Color(
//                                   0XFF976775),
//                             )),
//                         content: Column(
//                           children: <Widget>[
//                             DropdownButtonFormField(
//                               decoration: const InputDecoration(
//                                   hintStyle: TextStyle(
//                                       color: Color(
//                                           0XFF976775)),
//                                   hintText:
//                                   "İşlem Türü",
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Color(
//                                               0XFF6E3F52),
//                                           width:
//                                           3))),
//                               items: liste.map(
//                                       (String value) {
//                                     return DropdownMenuItem<
//                                         String>(
//                                       value: value,
//                                       child: Text(value,
//                                           style: const TextStyle(
//                                               color: Color(
//                                                   0XFF976775))),
//                                     );
//                                   }).toList(),
//                               onChanged: (newVal) {
//                                 setState(() {
//                                   islemTuru =
//                                       newVal;
//                                 });
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       _currentStep >
//                                           0
//                                           ? setState(() =>
//                                       _currentStep -=
//                                       1)
//                                           : null;
//                                     },
//                                     child: const Text(
//                                         "Geri",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       _currentStep <
//                                           2
//                                           ? setState(() =>
//                                       _currentStep +=
//                                       1)
//                                           : null;
//                                       setState(
//                                               () {});
//                                     },
//                                     child: const Text(
//                                         "İleri",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 1
//                             ? StepState.complete
//                             : StepState.disabled,
//                       ),
//                       Step(
//                         title: Text(
//                             'Ana ve Hedef Nokta seçiniz.',
//                             style: GoogleFonts
//                                 .notoSansTaiLe(
//                               fontSize: 15,
//                               color: const Color(
//                                   0XFF976775),
//                             )),
//                         content: Column(
//                           children: <Widget>[
//                             DropdownButtonFormField(
//                               decoration: const InputDecoration(
//                                   hintStyle: TextStyle(
//                                       color: Color(
//                                           0XFF976775)),
//                                   hintText:
//                                   "Ana Nokta",
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Color(
//                                               0XFF6E3F52),
//                                           width:
//                                           3))),
//                               items: cevaps.data ==
//                                   null
//                                   ? []
//                                   : cevaps.data?.map(
//                                       (myWareHouse
//                                   value) {
//                                     return DropdownMenuItem<
//                                         String>(
//                                       value: value
//                                           .id
//                                           .toString(),
//                                       child: Text(
//                                           value.ad
//                                               .toString(),
//                                           style: const TextStyle(
//                                               color:
//                                               Color(0XFF976775))),
//                                     );
//                                   }).toList(),
//                               onChanged: (newVal) {
//                                 setState(() {
//                                   anaDepo = newVal;
//                                 });
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             DropdownButtonFormField(
//                               decoration: const InputDecoration(
//                                   hintStyle: TextStyle(
//                                       color: Color(
//                                           0XFF976775)),
//                                   hintText:
//                                   "Hedef Nokta",
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Color(
//                                               0XFF6E3F52),
//                                           width:
//                                           3))),
//                               items: cevaps.data
//                                   ?.map((myWareHouse
//                               value) {
//                                 return DropdownMenuItem<
//                                     String>(
//                                   value: value.id
//                                       .toString(),
//                                   child: Text(
//                                       value.ad
//                                           .toString(),
//                                       style: const TextStyle(
//                                           color: Color(
//                                               0XFF976775))),
//                                 );
//                               }).toList(),
//                               onChanged: (newVal) {
//                                 setState(() {
//                                   hedefDepo =
//                                       newVal;
//                                 });
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       _currentStep >
//                                           0
//                                           ? setState(() =>
//                                       _currentStep -=
//                                       1)
//                                           : null;
//                                     },
//                                     child: const Text(
//                                         "Geri",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Expanded(
//                                   child:
//                                   OutlinedButton(
//                                     style: OutlinedButton
//                                         .styleFrom(
//                                       backgroundColor:
//                                       const Color(
//                                           0XFF463848),
//                                       side: const BorderSide(
//                                           width:
//                                           1.0,
//                                           color: Color(
//                                               0XFF463848)),
//                                     ),
//                                     onPressed: () {
//                                       if (tfIslemAdi
//                                           .text ==
//                                           "") {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'İşlem adını boş bırakamazsınız.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else if (tfIslemAciklamasi
//                                           .text ==
//                                           "") {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'İşlem açıklamasını boş bırakamazsınız.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else if (tfIslemTarihi
//                                           .text ==
//                                           "") {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'İşlem tarihini boş bırakamazsınız.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else if (islemTuru ==
//                                           "" ||
//                                           islemTuru ==
//                                               null) {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'İşlem türü seçmelisiniz.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else if (anaDepo ==
//                                           "" ||
//                                           anaDepo ==
//                                               null) {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'Ana nokta seçmelisiniz.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else if (hedefDepo ==
//                                           "" ||
//                                           hedefDepo ==
//                                               null) {
//                                         ScaffoldMessenger.of(
//                                             context)
//                                             .showSnackBar(
//                                             const SnackBar(
//                                               backgroundColor:
//                                               Colors
//                                                   .red,
//                                               content: Text(
//                                                   'Hedef nokta seçmelisiniz.'),
//                                               duration: Duration(
//                                                   seconds:
//                                                   2),
//                                             ));
//                                       } else {
//                                         // String
//                                         //     islemAdi =
//                                         //     tfIslemAdi
//                                         //         .text;
//                                         // String
//                                         //     islemTarihi =
//                                         //     tfIslemTarihi
//                                         //         .text;
//                                         // String
//                                         //     islemAciklamasi =
//                                         //     tfIslemAciklamasi
//                                         //         .text;
//                                         //
//                                         // tfIslemAdi
//                                         //     .clear();
//                                         // tfIslemAciklamasi
//                                         //     .clear();
//                                         // tfIslemTarihi
//                                         //     .clear();
//                                         print(
//                                             "Ana Depo: ${anaDepo}");
//                                         print(
//                                             "Hedef Depo: ${hedefDepo}");
//
//                                         isBaslat(
//                                             tfIslemAdi
//                                                 .text,
//                                             tfIslemAciklamasi
//                                                 .text,
//                                             int.parse(
//                                                 islemTuru),
//                                             int.parse(
//                                                 anaDepo),
//                                             int.parse(
//                                                 hedefDepo),
//                                             tfIslemTarihi
//                                                 .text);
//                                       }
//
//                                       // print(
//                                       //     'object');
//                                       setState(
//                                               () {});
//                                     },
//                                     child: const Text(
//                                         "Başlat",
//                                         style: TextStyle(
//                                             color: Color(
//                                                 0XFFDBDCE8),
//                                             fontSize:
//                                             15,
//                                             letterSpacing:
//                                             2.0)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 2
//                             ? StepState.complete
//                             : StepState.disabled,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
//
