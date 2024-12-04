import 'dart:convert';
import 'package:flutter/foundation.dart';

class OrdersModel {
  final String? id;
  final bool? isActive;
  final String? price;
  final String? company;
  final String? picture;
  final String? buyer;
  final List<String>? tags;
  final String? status;
  final String? registered;
  final DateTime? date;
  final int? count;
  OrdersModel(
      {this.id,
      this.isActive,
      this.price,
      this.company,
      this.picture,
      this.buyer,
      this.tags,
      this.status,
      this.registered,
      this.date,
      this.count});

  OrdersModel copyWith({
    String? id,
    bool? isActive,
    String? price,
    String? company,
    String? picture,
    String? buyer,
    List<String>? tags,
    String? status,
    String? registered,
    DateTime? date,
    int? count,
  }) {
    return OrdersModel(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      price: price ?? this.price,
      company: company ?? this.company,
      picture: picture ?? this.picture,
      buyer: buyer ?? this.buyer,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      registered: registered ?? this.registered,
      date: date ?? this.date,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isActive': isActive,
      'price': price,
      'company': company,
      'picture': picture,
      'buyer': buyer,
      'tags': tags,
      'status': status,
      'registered': registered,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      id: map['id'],
      isActive: map['isActive'],
      price: map['price'],
      company: map['company'],
      picture: map['picture'],
      buyer: map['buyer'],
      tags: map['tags'] != null ? List<String>.from((map['tags'])) : [],
      status: map['status'],
      registered: map['registered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersModel.fromJson(String source) =>
      OrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdersModel(id: $id, isActive: $isActive, price: $price, company: $company, picture: $picture, buyer: $buyer, tags: $tags, status: $status, registered: $registered)';
  }

  @override
  bool operator ==(covariant OrdersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isActive == isActive &&
        other.price == price &&
        other.company == company &&
        other.picture == picture &&
        other.buyer == buyer &&
        listEquals(other.tags, tags) &&
        other.status == status &&
        other.registered == registered;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isActive.hashCode ^
        price.hashCode ^
        company.hashCode ^
        picture.hashCode ^
        buyer.hashCode ^
        tags.hashCode ^
        status.hashCode ^
        registered.hashCode;
  }
}
