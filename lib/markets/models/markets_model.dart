// To parse this JSON data, do
//
//     final marketsModel = marketsModelFromJson(jsonString);

import 'dart:convert';

MarketsModel marketsModelFromJson(String str) =>
    MarketsModel.fromJson(json.decode(str));

String marketsModelToJson(MarketsModel data) => json.encode(data.toJson());

class MarketsModel {
  MarketsModel({
    this.id,
    this.marketName,
    this.userId,
    this.createdAt,
  });

  String? id;
  String? marketName;
  String? userId;
  dynamic createdAt;

  factory MarketsModel.fromJson(Map<String, dynamic> json) => MarketsModel(
        id: json["id"],
        marketName: json["marketName"],
        userId: json["userId"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marketName": marketName,
        "userId": userId,
        "createdAt": createdAt,
      };
}
