// To parse this JSON data, do
//
//     final ordersDetial = ordersDetialFromJson(jsonString);

import 'dart:convert';

OrdersDetial ordersDetialFromJson(String str) =>
    OrdersDetial.fromJson(json.decode(str));

String ordersDetialToJson(Item data) => json.encode(data.toJson());

class OrdersDetial {
  OrdersDetial({
    this.id,
    this.orderNumber,
    this.amount,
    this.shippingAmount,
    this.totalAmount,
    this.totalQuantity,
    this.status,
    this.user,
    this.createdAt,
    this.processedDate,
    this.completedDate,
    this.canceledDate,
    this.orderItems,
    this.address,
  });

  final int? id;
  final dynamic orderNumber;
  final String? amount;
  final String? shippingAmount;
  final String? totalAmount;
  final int? totalQuantity;
  final String? status;
  final int? user;
  final DateTime? createdAt;
  final dynamic processedDate;
  final dynamic completedDate;
  final dynamic canceledDate;
  final List<OrderItem>? orderItems;
  final Address? address;

  factory OrdersDetial.fromJson(Map<String, dynamic> json) => OrdersDetial(
        id: json["id"],
        orderNumber: json["order_number"],
        amount: json["amount"],
        shippingAmount: json["shipping_amount"],
        totalAmount: json["total_amount"],
        totalQuantity: json["total_quantity"],
        status: json["status"],
        user: json["user"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        processedDate: json["processed_date"],
        completedDate: json["completed_date"],
        canceledDate: json["canceled_date"],
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "amount": amount,
        "shipping_amount": shippingAmount,
        "total_amount": totalAmount,
        "total_quantity": totalQuantity,
        "status": status,
        "user": user,
        "created_at": createdAt?.toIso8601String(),
        "processed_date": processedDate,
        "completed_date": completedDate,
        "canceled_date": canceledDate,
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "address": address?.toJson(),
      };
}

class Address {
  Address({
    this.id,
    this.phoneNumber,
    this.emailAddress,
    this.address,
    this.postalCode,
    this.primary,
    this.user,
  });

  final int? id;
  final String? phoneNumber;
  final String? emailAddress;
  final String? address;
  final String? postalCode;
  final bool? primary;
  final int? user;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        phoneNumber: json["phone_number"],
        emailAddress: json["email_address"],
        address: json["address"],
        postalCode: json["postal_code"],
        primary: json["primary"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "address": address,
        "postal_code": postalCode,
        "primary": primary,
        "user": user,
      };
}

class OrderItem {
  OrderItem({
    this.item,
    this.order,
    this.totalAmount,
    this.quantity,
  });

  final Item? item;
  final int? order;
  final String? totalAmount;
  final int? quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        order: json["order"],
        totalAmount: json["total_amount"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "item": item?.toJson(),
        "order": order,
        "total_amount": totalAmount,
        "quantity": quantity,
      };
}

class Item {
  Item({
    this.id,
    this.title,
    this.description,
    this.images,
    this.price,
    this.brand,
    this.store,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.isFavourite,
  });

  final int? id;
  final String? title;
  final String? description;
  final List<Image>? images;
  final String? price;
  final dynamic brand;
  final dynamic store;
  final dynamic category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isFavourite;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        price: json["price"],
        brand: json["brand"],
        store: json["store"],
        category: json["category"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "price": price,
        "brand": brand,
        "store": store,
        "category": category,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_favourite": isFavourite,
      };
}

class Image {
  Image({
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
