import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:stok_takip_uygulamasi/model/Warehouse.dart';

class ProductTransactions{

  // List<Null>? children;
  // List<Null>? productTransactionImages;
  // Product? product;
  // ProductProcess? productProcess;
  // // Department? department;
  // Warehouse? warehouse;
  // // Department? department;
  // // Warehouse? warehouse;
  // Null? parent;
  // int? productId;
  // int? productProcessId;
  // double miktar;
  // int? girisTuru;
  // int? cikisTuru;
  // int? durum;
  // int? departmentId;
  // int? warehouseId;
  // String? hareketAciklamasi;
  // int? parentId;
  // int? id;

  // List<Null>? children;
  List<Null>? productTransactionImages;
  Product? product;
  ProductProcess? productProcess;
  // Null? department;
  Warehouse? warehouse;
  // Null? parent;
  int? productId;
  int? productProcessId;
  double? miktar;
  int? girisTuru;
  int? cikisTuru;
  int? durum;
  int? departmentId;
  int? warehouseId;
  String? hareketAciklamasi;
  int? parentId;
  int? id;


  ProductTransactions(
      {
        // this.children,
        this.productTransactionImages,
        this.product,
        this.productProcess,
        // this.department,
        this.warehouse,
        // this.parent,
        this.productId,
        this.productProcessId,
        required this.miktar,
        this.girisTuru,
        this.cikisTuru,
        this.durum,
        this.departmentId,
        this.warehouseId,
        this.hareketAciklamasi,
        this.parentId,
        this.id});
  factory ProductTransactions.fromJson(Map<String, dynamic> json) {
    return ProductTransactions(
        // children: json['children'],
        // productTransactionImages: json['productTransactionImages'],
        product: json['product'] != null ? Product.fromJson(json['product']) : null,
        productProcess: json['productProcess'] != null ? ProductProcess.fromJson(json['productProcess']) : null,
        // department: json['department'],
        warehouse:  json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null,
        // parent: json['parent'],
        productId: json['productId'],
        productProcessId: json['productProcessId'],
        miktar: json['miktar'],
        girisTuru: json['girisTuru'],
        cikisTuru: json['cikisTuru'],
        durum: json['durum'],
        departmentId: json['departmentId'],
        warehouseId: json['warehouseId'],
        hareketAciklamasi: json['hareketAciklamasi'],
        parentId: json['parentId'],

        id: json['id']);
  }

  static ProductTransactions fromJsonModel(Map<String, dynamic> json) =>
      ProductTransactions.fromJson(json);
}
