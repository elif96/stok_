import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stok_takip_uygulamasi/Islem_bilgileri.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/is_baslat.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/ProductTransationImages.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';

class IslemlerDetay extends StatefulWidget {
  final String islemAdi;

  const IslemlerDetay({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<IslemlerDetay> createState() => _IslemlerDetayState();
}

class _IslemlerDetayState extends State<IslemlerDetay> {
  @override
  initState() {
    super.initState();
  }

  late String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          primary: true,
          backgroundColor: const Color(0xFF976775),
          title: Text(title),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => IsBaslat()));
            },
            icon: Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          )),
      endDrawer: DrawerMenu(),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (this.widget.islemAdi == 'İşlem Taslakları') {
              title = 'İşlem Taslakları';

              return Drafts(islemAdi: 'İşlem Taslakları');
            }
            if (this.widget.islemAdi == 'Onayımı Bekleyen İşlemler') {
              title = 'Onayımı Bekleyen İşlemler';
              return WaitingForMyConfirmations(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Onaya Gönderdiğim İşlemler') {
              title = 'Onaya Gönderdiğim İşlemler';
              return WaitingForConfirmations(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Reddedilen İşlemler') {
              title = 'Reddedilen İşlemler';
              return Rejecteds(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Onayladığım İşlemler') {
              title = 'Onayladığım İşlemler';
              return MyConfirmation(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Reddettiğim İşlemler') {
              title = 'Reddettiğim İşlemler';
              return RejectedsByMe(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == '') {
              return const Text('data');
            }
          }),
    );
  }
}

//region GetAllDrafts
class Drafts extends StatefulWidget {
  final String islemAdi;

  const Drafts({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  var title = 'İşlem Taslakları';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    draftsListeleWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'İşlem Taslakları';
      print('İŞlem taslakları çalıştı');
    });
  }

  late myData<ProductProcess> drafts = myData<ProductProcess>();
  late myData<ProductProcess> draftsList = myData<ProductProcess>();
  int pageNum = 1;

  Future<myData<ProductProcess>> draftsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    drafts = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return drafts;
  }

  Future<myData<ProductProcess>> draftsListeleWithFilter(int Page, int PageSize,
      String Orderby, bool Desc, bool isDeleted) async {
    // drafts.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}&includeParents=true&includeChildren=true'));
    drafts = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    for (int i = 0; i < drafts.data!.length; i++) {
      draftsList.data?.add(drafts.data![i]);
    }

    setState(() {});
    return draftsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    pageNum = pageNum + 1;
    draftsListeleWithFilter(pageNum, 3, 'Id', true, false);
    print(pageNum);
    return true;
  }

  Future<void> removeToProductProcess(String id) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/RemoveToProductProcess/$id'));
    if (res.statusCode == 204 && res.reasonPhrase == 'No Content') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Taslak işlemi başarıyla silindi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> sendForApprovalToProductProcess(String id) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/SendForApprovalToProductProcess/$id'));
    if (res.statusCode == 204 && res.reasonPhrase == 'No Content') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Taslak işlemi başarıyla onaya gönderildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: draftsListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return GestureDetector(
                      onTap: () {
                        // this.islemTuru,
                        // this.islemAdi,
                        // this.islemAciklamasi,
                        // this.anaDepo,
                        // this.hedefDepo,
                        // this.islemTarihi,
                        // this.islemId
                        print(urun?.islemTuru.toString());
                        print(urun?.islemAdi.toString());
                        print(urun?.islemAciklama.toString());
                        print(urun?.anaDepo.toString());
                        print(urun?.anaDepo?.id.toString());
                        print(urun?.anaDepoId.toString());
                        print(urun?.hedefDepoID.toString());
                        print(urun?.islemTarihi.toString());
                        print(urun?.id.toString());
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                IslemBilgileri(
                                    islemTuru: urun?.islemTuru.toString(),
                                    islemAdi: urun?.islemAdi.toString(),
                                    islemAciklamasi: urun?.islemAciklama,
                                    anaDepo: urun?.anaDepoId ?? (urun?.anaDepoId = 0), hedefDepo: urun?.hedefDepoID ?? 0, islemTarihi: urun?.islemTarihi, islemId: urun?.id,)));
                      print(urun?.anaDepoId);
                        },
                      child: Container(
                        child: Card(
                          child: ListTile(
                              title: Text(
                                urun?.islemAdi.toString() == null
                                    ? ''
                                    : urun!.islemAdi.toString(),
                              ),
                              subtitle: Text(
                                "${urun?.islemAciklama.toString() == null
                                    ? ''
                                    : urun!.islemAciklama
                                    .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                    ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                    ?.onayiBeklenenUser}\nAna Depo: ${urun
                                    ?.anaDepo?.ad}\nHedef Depo: ${urun
                                    ?.hedefDepo?.ad}",
                              ),
                              trailing: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //call your onpressed function here
                                      print('Button Pressed');
                                      sendForApprovalToProductProcess(
                                          urun!.id.toString());
                                    },
                                    child: Icon(Icons.check),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //call your onpressed function here
                                      print('Button Pressed');
                                      removeToProductProcess(
                                          urun!.id.toString());
                                    },
                                    child: Icon(Icons.cancel),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // LoadMore(
      //   textBuilder: DefaultLoadMoreTextBuilder.turkish,
      //   isFinish: drafts.data == null,
      //   onLoadMore: _loadMore,
      //   child: ListView.builder(
      //     controller: scrollController,
      //     shrinkWrap: true,
      //     // controller: controller,
      //     itemBuilder: (context, index) {
      //       return Card(
      //           child: Column(
      //         children: [
      //           Text(draftsList.data![index].islemAdi.toString() ?? ''),
      //           Text(draftsList.data![index].islemTuru.toString() ?? ''),
      //           Text(draftsList.data![index].islemTarihi.toString() ?? ''),
      //           Text(draftsList.data![index].islemAciklama.toString() ?? ''),
      //           Text(draftsList.data![index].onayiBeklenenUser.toString() ?? ''),
      //           Text(draftsList.data![index].onayIsteyenUser.toString() ?? ''),
      //           Text(draftsList.data![index].anaDepoId.toString() ?? ''),
      //           Text(draftsList.data![index].hedefDepoID.toString() ?? ''),
      //         ],
      //       ));
      //     },
      //     itemCount: draftsList.data?.length,
      //   ),
      // ),
    );
  }
}
//endregion

//region GetAllWaitingForMyConfirmations
class WaitingForMyConfirmations extends StatefulWidget {
  final String islemAdi;

  const WaitingForMyConfirmations({Key? key, required this.islemAdi})
      : super(key: key);

  @override
  State<WaitingForMyConfirmations> createState() =>
      _WaitingForMyConfirmationsState();
}

class _WaitingForMyConfirmationsState extends State<WaitingForMyConfirmations> {
  var title = 'WaitingForMyConfirmations';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    // WaitingForMyConfirmationsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'WaitingForMyConfirmations';
      print('WaitingForMyConfirmations çalıştı');
    });
  }

  late myData<ProductProcess> WaitingForMyConfirmations =
  myData<ProductProcess>();
  late myData<ProductProcess> WaitingForMyConfirmationsList =
  myData<ProductProcess>();
  int pageNumWaitingForMyConfirmations = 1;

  Future<myData<ProductProcess>> WaitingForMyConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    WaitingForMyConfirmations = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return WaitingForMyConfirmations;
  }

  Future<myData<ProductProcess>> WaitingForMyConfirmationsWithFilter(int Page,
      int PageSize, String Orderby, bool Desc, bool isDeleted) async {
    WaitingForMyConfirmations.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}&includeParents=true&includeChildren=true'));
    WaitingForMyConfirmations = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);
    print(res.body);

    for (int i = 0; i < WaitingForMyConfirmations.data!.length; i++) {
      WaitingForMyConfirmationsList.data!
          .add(WaitingForMyConfirmations.data![i]);
    }

    setState(() {});
    return WaitingForMyConfirmationsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));

    pageNumWaitingForMyConfirmations = pageNumWaitingForMyConfirmations + 1;
    WaitingForMyConfirmationsWithFilter(
        pageNumWaitingForMyConfirmations, 3, 'Id', false, false);
    print(pageNumWaitingForMyConfirmations);
    return true;
  }

  Future<void> approvalToProductProcess(String id) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/ApprovaToProductProcess/$id'));
    print(res.body);
    if (res.statusCode == 204 && res.reasonPhrase == 'No Content') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Onayınızı bekleyen işlem başarıyla onaylandı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }

  var tfAciklama = new TextEditingController();

  Future<void> rejectToProductProcess(String id, String aciklama) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/RejectToProductProcess/$id/$aciklama'));
    if (res.statusCode == 204 && res.reasonPhrase == 'No Content') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Onayınızı bekleyen işlem başarıyla reddedildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }

  late myData<ProductProcess> ProductsBelongsToProcess = myData<ProductProcess>();

  Future<myData<ProductProcess>> productsBelongsToProcess(String processId) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=$processId&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    WaitingForMyConfirmations = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    // getProductTransactionImages(WaitingForMyConfirmations.data?[0].productTransactions?[0].id);
    setState(() {});
    return WaitingForMyConfirmations;
  }

  //https://stok.bahcelievler.bel.tr/api/ProductProcesses/376
  late myData<ProductTransactionImages> productTransactionImages = myData<ProductTransactionImages>();

  // Future<myData<ProductTransactionImages>> getProductTransactionImages(int? productTransactionId) async {
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/ProductTransactionImages/GetAll?ProductTransactionIdFilter=$productTransactionId&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=true&includeParents=true&includeChildren=true'));
  //   productTransactionImages = myData<ProductTransactionImages>.fromJson(
  //       json.decode(res.body), ProductTransactionImages.fromJsonModel);
  //
  //   print(productTransactionImages.data?.length);
  //   setState(() {});
  //   return productTransactionImages;
  // }

  File? _image;
  XFile? _pickedFile;
  final _picker = ImagePicker();



  Future pickImage(String id) async {
    _pickedFile=
    await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
        postImage(id, _image!);
      });
    }
    print(_image?.path);


    // try {
    //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if(image == null) return;
    //   print("urunid: ${urun.id}");
    //   postImage(id, image);
    // } on PlatformException catch(e) {
    //   print('Failed to pick image: $e');
    // }
  }


  Future takePhoto(String id) async {
    _pickedFile=
    await _picker.pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
        postImage(id, _image!);
      });
    }
    // try {
    //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
    //   if(image == null) return;
    //   // print("urunid: ${urun.id}");
    //   // print(image);
    //   postImage(id, _image!);
    //
    // } on PlatformException catch(e) {
    //   print('Failed to pick image: $e');
    // }
  }
  Future<void> postImage(String productTransactionId, File image) async {
    // var url =
    // Uri.parse('https://stok.bahcelievler.bel.tr/api/ProductTransactionImages?productTransactionId=$productTransactionId');
    // print("1 kere çalıştım.");
    //
    // http.Response response = await http.post(url,
    //     headers: {'Accept': '*/*', 'Content-Type': 'multipart/form-data'},
    //     body: json.encoder.convert({
    //       "productTransactionId": productTransactionId,
    //       "imageFile": image,
    //     }));
    // print(response.body);

      final String url =
          'https://stok.bahcelievler.bel.tr/api/ProductTransactionImages?productTransactionId=$productTransactionId';
      print("1 kere çalıştım.");

      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({"accept": "*/*", "content-type": "multipart/form-data"});

      // request.files.add(await http.MultipartFile.fromPath("imageFile", "/Users/eozturk/Desktop/bahcelievler.png", contentType: MediaType("image","jpg")));

      // request.files.add(http.MultipartFile('image',
      //     File(image.path).readAsBytes().asStream(), File(image.path).lengthSync(),
      //     filename: image.path.split("/").last, contentType: MediaType("image","jpg")),);

      if(image.path.contains("jpg")){
        request.files.add(
          await http.MultipartFile.fromPath(
              "imageFile",
              image.path,
              filename: image.path.split("/").last,contentType: MediaType("image",'jpg')
          ),
        );
      }
      else if(image.path.contains("png")){
        request.files.add(
          await http.MultipartFile.fromPath(
              "imageFile",
              image.path,
              filename: image.path.split("/").last,contentType: MediaType("image",'png')
          ),
        );
      }
      else if(image.path.contains("jpeg")){
        request.files.add(
          await http.MultipartFile.fromPath(
              "imageFile",
              image.path,
              filename: image.path.split("/").last,contentType: MediaType("image",'jpeg')
          ),
        );
      }
      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     "imageFile",
      //     image.path,
      //     filename: image.path.split("/").last,contentType: MediaType("image",'jpg')
      //   ),
      // );

      print(File(image.path).lengthSync());
      print(image);
      var response = await request.send();

      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);
      print(response.statusCode);
      print(responseData);
      print(response.statusCode);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Görsel başarıyla eklendi."),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
        Navigator.pop(context);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Görsel eklenme sırasında bir hata oluştu."),
          backgroundColor: Colors.red,
        ));
        Navigator.pop(context);
        Navigator.pop(context);
      }


  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: WaitingForMyConfirmationsListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return Container(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            urun?.islemAdi.toString() == null
                                ? ''
                                : urun!.islemAdi.toString(),
                          ),
                          subtitle: Text(
                            "${urun?.islemAciklama.toString() == null
                                ? ''
                                : urun!.islemAciklama
                                .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                ?.onayiBeklenenUser}\nAna Depo: ${urun?.anaDepo
                                ?.ad}\nHedef Depo: ${urun?.hedefDepo?.ad}",
                          ),
                          trailing: Column(
                            children: [
                              // Expanded(
                              //   child: InkWell(
                              //     onTap: () {
                              //       //call your onpressed function here
                              //       print('Button Pressed');
                              //       // showModalBottomSheet<void>(
                              //       //   context: context,
                              //       //   builder: (BuildContext context) {
                              //       //     return SizedBox(
                              //       //       height:
                              //       //       MediaQuery
                              //       //           .of(context)
                              //       //           .size
                              //       //           .height /
                              //       //           5,
                              //       //       child: Center(
                              //       //         child: Column(
                              //       //           mainAxisAlignment:
                              //       //           MainAxisAlignment.center,
                              //       //           children: <Widget>[
                              //       //
                              //       //             ListView(
                              //       //         shrinkWrap: true,
                              //       //               children: [
                              //       //
                              //       //
                              //       //               ListTile(
                              //       //
                              //       //                 title: Text('Fotoğraf Çek'),
                              //       //                 onTap: (){
                              //       //                   takePhoto(urun!.id.toString());
                              //       //                 },
                              //       //               ),
                              //       //               Divider(thickness: 3,),
                              //       //               ListTile(
                              //       //                 title: Text('Galeriden Seç'),
                              //       //                 onTap: (){
                              //       //                   pickImage();
                              //       //                 },
                              //       //               ),
                              //       //
                              //       //
                              //       //               ]
                              //       //             ),
                              //       //
                              //       //           ],
                              //       //         ),
                              //       //       ),
                              //       //     );
                              //       //   },
                              //       // );
                              //       showModalBottomSheet(context: context, builder: (BuildContext context){
                              //         return  FutureBuilder<myData<ProductProcess>>(
                              //           future: productsBelongsToProcess(urun!.id.toString()),
                              //           builder: (context, snapshot) {
                              //             if (snapshot.hasData) {
                              //               var productListesi = snapshot.data?.data;
                              //
                              //               return SingleChildScrollView(
                              //                 child: ListView.builder(
                              //                   physics: NeverScrollableScrollPhysics(),
                              //                   shrinkWrap: true,
                              //                   itemCount: productListesi?[0].productTransactions?.length,
                              //                   itemBuilder: (context, index) {
                              //                     var product = WaitingForMyConfirmations.data?[0];
                              //
                              //                     return Container(
                              //                       child: Card(
                              //                         child: ListTile(
                              //                           title: Text(
                              //
                              //                               product?.productTransactions?[index].product?.productName.toString() == null
                              //                                   ? ''
                              //                                   : product!.productTransactions![index].product!.productName.toString()
                              //
                              //                           ),
                              //                           trailing: InkWell(
                              //                             onTap: () {
                              //                               //call your onpressed function here
                              //                               print('Button Pressed');
                              //                               showModalBottomSheet<void>(
                              //                                 context: context,
                              //                                 builder: (BuildContext context) {
                              //                                   return SizedBox(
                              //                                     height:
                              //                                     MediaQuery
                              //                                         .of(context)
                              //                                         .size
                              //                                         .height /
                              //                                         5,
                              //                                     child: Center(
                              //                                       child: Column(
                              //                                         mainAxisAlignment:
                              //                                         MainAxisAlignment.center,
                              //                                         children: <Widget>[
                              //
                              //                                           ListView(
                              //                                       shrinkWrap: true,
                              //                                             children: [
                              //
                              //
                              //                                             ListTile(
                              //
                              //                                               title: Text('Fotoğraf Çek'),
                              //                                               onTap: (){
                              //                                                 takePhoto(product!.productTransactions![index].id.toString());
                              //                                               },
                              //                                             ),
                              //                                             Divider(thickness: 3,),
                              //                                             ListTile(
                              //                                               title: Text('Galeriden Seç'),
                              //                                               onTap: (){
                              //                                                 pickImage(product!.productTransactions![index].id.toString());
                              //                                               },
                              //                                             ),
                              //
                              //
                              //                                             ]
                              //                                           ),
                              //
                              //                                         ],
                              //                                       ),
                              //                                     ),
                              //                                   );
                              //                                 },
                              //                               );
                              //                               // showModalBottomSheet<void>(
                              //                               //   context: context,
                              //                               //   builder: (BuildContext context) {
                              //                               //     return SizedBox(
                              //                               //       height:
                              //                               //       MediaQuery
                              //                               //           .of(context)
                              //                               //           .size
                              //                               //           .height /
                              //                               //           5,
                              //                               //       child: Center(
                              //                               //         child: Column(
                              //                               //           mainAxisAlignment:
                              //                               //           MainAxisAlignment.center,
                              //                               //           children: <Widget>[
                              //                               //
                              //                               //             ListView(
                              //                               //                 shrinkWrap: true,
                              //                               //                 children: [
                              //                               //
                              //                               //
                              //                               //                   ListTile(
                              //                               //
                              //                               //                     title: Text('Fotoğraf Çek'),
                              //                               //                     onTap: (){
                              //                               //                       takePhoto(product!.productTransactions![index].product!.id.toString());
                              //                               //                     },
                              //                               //                   ),
                              //                               //                   Divider(thickness: 3,),
                              //                               //                   ListTile(
                              //                               //                     title: Text('Galeriden Seç'),
                              //                               //                     onTap: (){
                              //                               //                       pickImage(product!.productTransactions![index].product!.id.toString());
                              //                               //                     },
                              //                               //                   ),
                              //                               //
                              //                               //
                              //                               //                 ]
                              //                               //             ),
                              //                               //
                              //                               //           ],
                              //                               //         ),
                              //                               //       ),
                              //                               //     );
                              //                               //   },
                              //                               // );
                              //                               },
                              //                             child: Icon(Icons.photo_camera),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   },
                              //                 ),
                              //               );
                              //             } else {
                              //               return Center();
                              //             }
                              //           },
                              //         );
                              //       });
                              //       },
                              //     child: Icon(Icons.photo_camera),
                              //   ),
                              // ),
                              // SizedBox(height: 10,),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    //call your onpressed function here
                                    print('Button Pressed');
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          // title: const Text('AlertDialog Title'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text('İşlemi onaylamadan önce ürünlere fotoğraf eklemek isterseniz misiniz ?', style: TextStyle(color: Color(0xFFAAA3B4), fontWeight: FontWeight.bold)),

                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Fotoğraf Ekle', style: TextStyle(color: Color(0xFF6E3F52), fontWeight: FontWeight.bold)),
                                              onPressed: () {
                                                showModalBottomSheet(context: context, builder: (BuildContext context){
                                                  return  FutureBuilder<myData<ProductProcess>>(
                                                    future: productsBelongsToProcess(urun!.id.toString()),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var productListesi = snapshot.data?.data;

                                                        return SingleChildScrollView(
                                                          child: ListView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: productListesi?[0].productTransactions?.length,
                                                            itemBuilder: (context, index) {
                                                              var product = WaitingForMyConfirmations.data?[0];

                                                              return Container(
                                                                child: Card(
                                                                  child: ListTile(
                                                                    title: Row(
                                                                      children: [
                                                                        Text(

                                                                            product?.productTransactions?[index].product?.productName.toString() == null
                                                                                ? ''
                                                                                : product!.productTransactions![index].product!.productName.toString()

                                                                        ),
Text((product?.productTransactions?[index].productTransactionImages?[index].imageFileName).toString()),

                                                                        Image.file(
                                                                          File((product?.productTransactions?[index].productTransactionImages?[index].imageFileName).toString()),
                                                                          width: 5,
                                                                          height: 5,
                                                                        )
                                                                        // Text((product?.productTransactions?[0].productTransactionImages?[index].imageFileName).toString())
                                                                      ],
                                                                    ),
                                                                    trailing: InkWell(
                                                                      onTap: () {
                                                                        //call your onpressed function here
                                                                        print(WaitingForMyConfirmations.data?[0].productTransactions?[0].id);
                                                                        // getProductTransactionImages(WaitingForMyConfirmations.data?[0].productTransactions?[index].id);
                                                                        print('Button Pressed');
                                                                        showModalBottomSheet<void>(
                                                                          context: context,
                                                                          builder: (BuildContext context) {
                                                                            return SizedBox(
                                                                              height:
                                                                              MediaQuery
                                                                                  .of(context)
                                                                                  .size
                                                                                  .height /
                                                                                  5,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                                  children: <Widget>[

                                                                                    ListView(
                                                                                        shrinkWrap: true,
                                                                                        children: [


                                                                                          ListTile(

                                                                                            title: Text('Fotoğraf Çek'),
                                                                                            onTap: (){
                                                                                              takePhoto(product!.productTransactions![index].id.toString());
                                                                                            },
                                                                                          ),
                                                                                          Divider(thickness: 3,),
                                                                                          ListTile(
                                                                                            title: Text('Galeriden Seç'),
                                                                                            onTap: (){
                                                                                              pickImage(product!.productTransactions![index].id.toString());
                                                                                            },
                                                                                          ),


                                                                                        ]
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                        // showModalBottomSheet<void>(
                                                                        //   context: context,
                                                                        //   builder: (BuildContext context) {
                                                                        //     return SizedBox(
                                                                        //       height:
                                                                        //       MediaQuery
                                                                        //           .of(context)
                                                                        //           .size
                                                                        //           .height /
                                                                        //           5,
                                                                        //       child: Center(
                                                                        //         child: Column(
                                                                        //           mainAxisAlignment:
                                                                        //           MainAxisAlignment.center,
                                                                        //           children: <Widget>[
                                                                        //
                                                                        //             ListView(
                                                                        //                 shrinkWrap: true,
                                                                        //                 children: [
                                                                        //
                                                                        //
                                                                        //                   ListTile(
                                                                        //
                                                                        //                     title: Text('Fotoğraf Çek'),
                                                                        //                     onTap: (){
                                                                        //                       takePhoto(product!.productTransactions![index].product!.id.toString());
                                                                        //                     },
                                                                        //                   ),
                                                                        //                   Divider(thickness: 3,),
                                                                        //                   ListTile(
                                                                        //                     title: Text('Galeriden Seç'),
                                                                        //                     onTap: (){
                                                                        //                       pickImage(product!.productTransactions![index].product!.id.toString());
                                                                        //                     },
                                                                        //                   ),
                                                                        //
                                                                        //
                                                                        //                 ]
                                                                        //             ),
                                                                        //
                                                                        //           ],
                                                                        //         ),
                                                                        //       ),
                                                                        //     );
                                                                        //   },
                                                                        // );
                                                                      },
                                                                      child: Icon(Icons.photo_camera),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      } else {
                                                        return Center();
                                                      }
                                                    },
                                                  );
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Onaya Gönder', style: TextStyle(color: Color(0xFF6E3F52), fontWeight: FontWeight.bold)),
                                              onPressed: () {
                                                approvalToProductProcess(urun!.id.toString());
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Vazgeç', style: TextStyle(color: Color(0xFF6E3F52), fontWeight: FontWeight.bold)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    // approvalToProductProcess(urun!.id.toString());
                                  },
                                  child: Icon(Icons.check),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    //call your onpressed function here
                                    print('Button Pressed');
                                    showModalBottomSheet<void>(
                                      // context and builder are
                                      // required properties in this widget
                                      context: context,
                                      builder: (BuildContext context) {
                                        // we set up a container inside which
                                        // we create center column and display text

                                        // Returning SizedBox instead of a Container
                                        return SizedBox(
                                          height:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              3,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    maxLines: 5,
                                                    controller: tfAciklama,
                                                    decoration: InputDecoration(
                                                      hintText: 'Açıklama',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: AnimatedButton(
                                                      color:
                                                      const Color(0XFF463848),
                                                      text: 'Gönder',
                                                      pressEvent: () {
                                                        rejectToProductProcess(
                                                            urun!.id.toString(),
                                                            tfAciklama.text);
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.cancel),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
//endregion

//region WaitingForConfirmations
class WaitingForConfirmations extends StatefulWidget {
  final String islemAdi;

  const WaitingForConfirmations({Key? key, required this.islemAdi})
      : super(key: key);

  @override
  State<WaitingForConfirmations> createState() =>
      _WaitingForConfirmationsState();
}

class _WaitingForConfirmationsState extends State<WaitingForConfirmations> {
  var title = 'WaitingForConfirmations';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // WaitingForConfirmationsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'WaitingForConfirmations';
      print('WaitingForConfirmations çalıştı');
    });
  }

  late myData<ProductProcess> WaitingForConfirmations =
  myData<ProductProcess>();
  late myData<ProductProcess> WaitingForConfirmationsList =
  myData<ProductProcess>();
  int pageNumWaitingForConfirmations = 1;

  Future<myData<ProductProcess>> WaitingForConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    WaitingForConfirmations = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return WaitingForConfirmations;
  }

  Future<myData<ProductProcess>> WaitingForConfirmationsWithFilter(int Page,
      int PageSize, String Orderby, bool Desc, bool isDeleted) async {
    WaitingForConfirmations.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    WaitingForConfirmations = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    for (int i = 0; i < WaitingForConfirmations.data!.length; i++) {
      WaitingForConfirmationsList.data!.add(WaitingForConfirmations.data![i]);
    }

    setState(() {});
    return WaitingForConfirmationsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));

    pageNumWaitingForConfirmations = pageNumWaitingForConfirmations + 1;
    WaitingForConfirmationsWithFilter(
        pageNumWaitingForConfirmations, 3, 'Id', false, false);
    print(pageNumWaitingForConfirmations);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: WaitingForConfirmationsListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return Container(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            urun?.islemAdi.toString() == null
                                ? ''
                                : urun!.islemAdi.toString(),
                          ),
                          subtitle: Text(
                            "${urun?.islemAciklama.toString() == null
                                ? ''
                                : urun!.islemAciklama
                                .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                ?.onayiBeklenenUser}\nAna Depo: ${urun?.anaDepo
                                ?.ad}\nHedef Depo: ${urun?.hedefDepo?.ad}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
//endregion

//region Rejecteds
class Rejecteds extends StatefulWidget {
  final String islemAdi;

  const Rejecteds({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<Rejecteds> createState() => _RejectedsState();
}

class _RejectedsState extends State<Rejecteds> {
  var title = 'Rejecteds';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    RejectedsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'Rejecteds';
      print('Rejecteds çalıştı');
    });
  }

  late myData<ProductProcess> Rejecteds = myData<ProductProcess>();
  late myData<ProductProcess> RejectedsList = myData<ProductProcess>();
  int pageNumRejecteds = 1;

  Future<myData<ProductProcess>> RejectedsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    Rejecteds = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return Rejecteds;
  }

  Future<myData<ProductProcess>> RejectedsWithFilter(int Page, int PageSize,
      String Orderby, bool Desc, bool isDeleted) async {
    // Rejecteds.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    Rejecteds = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    for (int i = 0; i < Rejecteds.data!.length; i++) {
      RejectedsList.data?.add(Rejecteds.data![i]);
    }

    setState(() {});
    return RejectedsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));

    pageNumRejecteds = pageNumRejecteds + 1;
    RejectedsWithFilter(pageNumRejecteds, 3, 'Id', false, false);
    print(pageNumRejecteds);
    return true;
  }

  Future<void> setDraftToProductProcess(String id) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/SetDraftToProductProcess/$id'));
    if (res.statusCode == 204 && res.reasonPhrase == 'No Content') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Reddedilen işlem başarıyla taslağa çekildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İşlem sırasında bir hata oluştu."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: RejectedsListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return Container(
                      child: Card(
                        child: ListTile(
                            title: Text(
                              urun?.islemAdi.toString() == null
                                  ? ''
                                  : urun!.islemAdi.toString(),
                            ),
                            subtitle: Text(
                              "${urun?.islemAciklama.toString() == null
                                  ? ''
                                  : urun!.islemAciklama
                                  .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                  ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                  ?.onayiBeklenenUser}\nAna Depo: ${urun
                                  ?.anaDepo?.ad}\nHedef Depo: ${urun?.hedefDepo
                                  ?.ad}",
                            ),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    //call your onpressed function here
                                    print('Button Pressed');
                                    setDraftToProductProcess(
                                        urun!.id.toString());
                                  },
                                  child: Text('Taslağa Çek'),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     //call your onpressed function here
                                //     print('Button Pressed');
                                //     removeToProductProcess(urun!.id.toString());
                                //   },
                                //   child: Icon(Icons.cancel),
                                // ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
//endregion

//region MyConfirmation
class MyConfirmation extends StatefulWidget {
  final String islemAdi;

  const MyConfirmation({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<MyConfirmation> createState() => _MyConfirmationState();
}

class _MyConfirmationState extends State<MyConfirmation> {
  var title = 'MyConfirmation';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    // MyConfirmationWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'MyConfirmation';
      print('MyConfirmation çalıştı');
    });
  }

  myData<ProductProcess> MyConfirmation = myData<ProductProcess>();
  myData<ProductProcess> MyConfirmationList = myData<ProductProcess>();
  int pageNumMyConfirmation = 1;

  Future<myData<ProductProcess>> MyConfirmationListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    MyConfirmation = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return MyConfirmation;
  }

  Future<myData<ProductProcess>> MyConfirmationWithFilter(int Page,
      int PageSize, String Orderby, bool Desc, bool isDeleted) async {
    MyConfirmation.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}&includeParents=true&includeChildren=true'));
    MyConfirmation = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    for (int i = 0; i < MyConfirmation.data!.length; i++) {
      MyConfirmationList.data!.add(MyConfirmation.data![i]);
    }

    setState(() {});
    return MyConfirmationList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));

    pageNumMyConfirmation = pageNumMyConfirmation + 1;
    MyConfirmationWithFilter(pageNumMyConfirmation, 3, 'Id', false, false);
    print(pageNumMyConfirmation);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: MyConfirmationListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return Container(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            urun?.islemAdi.toString() == null
                                ? ''
                                : urun!.islemAdi.toString(),
                          ),
                          subtitle: Text(
                            "${urun?.islemAciklama.toString() == null
                                ? ''
                                : urun!.islemAciklama
                                .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                ?.onayiBeklenenUser}\nAna Depo: ${urun?.anaDepo
                                ?.ad}\nHedef Depo: ${urun?.hedefDepo?.ad}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
//endregion

//region RejectedsByMe
class RejectedsByMe extends StatefulWidget {
  final String islemAdi;

  const RejectedsByMe({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<RejectedsByMe> createState() => _RejectedsByMeState();
}

class _RejectedsByMeState extends State<RejectedsByMe> {
  var title = 'RejectedsByMe';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    // RejectedsByMeWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()
      ..addListener(_loadMore);

    setState(() {
      title = 'RejectedsByMe';
      print('RejectedsByMe çalıştı');
    });
  }

  late myData<ProductProcess> RejectedsByMe = myData<ProductProcess>();
  late myData<ProductProcess> RejectedsByMeList = myData<ProductProcess>();
  int pageNumRejectedsByMe = 1;

  Future<myData<ProductProcess>> RejectedsByMeListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=true&isDeleted=false&includeParents=true&includeChildren=true'));
    RejectedsByMe = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return RejectedsByMe;
  }

  Future<myData<ProductProcess>> RejectedsByMeWithFilter(int Page, int PageSize,
      String Orderby, bool Desc, bool isDeleted) async {
    RejectedsByMe.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    RejectedsByMe = myData<ProductProcess>.fromJson(
        json.decode(res.body), ProductProcess.fromJsonModel);

    for (int i = 0; i < RejectedsByMe.data!.length; i++) {
      RejectedsByMeList.data!.add(RejectedsByMe.data![i]);
    }

    setState(() {});
    return RejectedsByMeList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));

    pageNumRejectedsByMe = pageNumRejectedsByMe + 1;
    RejectedsByMeWithFilter(pageNumRejectedsByMe, 3, 'Id', false, false);
    print(pageNumRejectedsByMe);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<myData<ProductProcess>>(
        future: RejectedsByMeListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urunlerlistesi = snapshot.data?.data;

            return Container(
              child: Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urunlerlistesi?.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerlistesi?[index];

                    return Container(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            urun?.islemAdi.toString() == null
                                ? ''
                                : urun!.islemAdi.toString(),
                          ),
                          subtitle: Text(
                            "${urun?.islemAciklama.toString() == null
                                ? ''
                                : urun!.islemAciklama
                                .toString()}\nOnay İsteyen Kullanıcı: ${urun
                                ?.onayIsteyenUser}\nOnayı Beklenen Kullanıcı: ${urun
                                ?.onayiBeklenenUser}\nAna Depo: ${urun?.anaDepo
                                ?.ad}\nHedef Depo: ${urun?.hedefDepo?.ad}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
//endregion
