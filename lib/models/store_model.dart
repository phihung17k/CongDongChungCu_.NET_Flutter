import 'dart:convert';

import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class StoreModel {
  final int curPage;
  final int totalPage;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;

  final List<StoreDTO> listStore;

  StoreModel(
      {this.curPage, this.totalPage, this.pageSize, this.totalCount, this.hasPrevious, this.hasNext, this.listStore});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json building model cannot null");
    int curPage = json['curr_page'];
    int totalPage = json['total_pages'];
    int pageSize = json['page_size'];
    int totalCount = json['total_count'];
    bool hasPrevious = json['hasPrevious'];
    bool hasNext = json['hasNext'];
    List<StoreDTO> listStore = <StoreDTO>[];

    List<dynamic> items = json['items'] as List<dynamic>;
    for (dynamic temp in items) {
      Map<String, dynamic> item = temp as Map<String, dynamic>;
      var dto = StoreDTO(
          storeId: item['store_id'],
          address: item['address'],
          closingTime: DateTime.parse(item['closing_time']),
          name: item['name'],
          openingTime: DateTime.parse(item['opening_time']),
          ownerStore: item['owner_store'],
          phone: item['phone'],
          status: item['status']
      );

      listStore.add(dto);
    }
    return StoreModel(
      curPage: curPage,
      totalPage: totalPage,
      pageSize: pageSize,
      totalCount: totalCount,
      hasPrevious: hasPrevious,
      hasNext: hasNext,
      listStore: listStore
    );
  }
}
