class PagingResult<T> {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;
  bool hasNext;
  List<T> items;

  PagingResult({this.currentPage, this.totalPages, this.pageSize, this.totalCount, this.hasNext, this.items});

  factory PagingResult.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    if (json == null) throw Exception("Json paging model cannot null");
    final itemsMap = json['items'].cast<Map<String, dynamic>>();
    int currentPage = json['curr_page'];
    int totalPages = json['total_pages'];
    int pageSize = json['page_size'];
    int totalCount = json['total_count'];
    bool hasNext = json['hasNext'];
    List<T> items = List<T>.from(itemsMap.map((itemsJson) => fromJsonModel(itemsJson)));
    return PagingResult(
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalCount: totalCount,
      hasNext: hasNext,
      items: items
    );
  }
}