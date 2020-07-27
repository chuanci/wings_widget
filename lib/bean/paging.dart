abstract class Paging {
  bool get hasMore;

  bool get isRefresh;

  void reset();

  void next();
}

class PagePaging extends Paging {
  /// 当前是第几页=page=cur_page=current_page=curPageNum：当前是第几页
  /// 一般从0或1开始
  int page;

  /// 从第几页开始，一般从0或1开始
  int _startPage;

  /// 每一页的个数=per_page=numPerPage=每一页的大小=page_size=pageSize
  int size;

  /// 总条数
  int total;

  /// 总页数
  int pages;

  PagePaging({this.page = 1, this.size = 10, this.total, this.pages}) {
    _startPage = this.page;
  }

  @override
  void reset() {
    page = _startPage;
  }

  @override
  bool get hasMore {
    if (total == null && pages == null) {
      return true;
    }
    if (total != null) {
      return ((page - _startPage + 1) * size) < total;
    }
    if (pages != null) {
      return (page - _startPage + 1) < pages;
    }
    return false;
  }

  @override
  void next() {
    if (hasMore) {
      page++;
    }
  }

  @override
  bool get isRefresh => _startPage == page;
}

class OffsetPaging extends Paging {
  /// 偏移量
  int offset;

  int _startOffset;

  /// 个数限制
  int limit;

  ///   /// 总条数
  int total;

  OffsetPaging({this.offset = 0, this.limit = 10, this.total}) {
    _startOffset = this.offset;
  }

  @override
  bool get hasMore {
    if (total == null) {
      return true;
    }
    if (total != null) {
      return offset < total;
    }
    return false;
  }

  @override
  void next() {
    if (hasMore) {
      offset += limit;
    }
  }

  @override
  void reset() {
    offset = 0;
  }

  @override
  bool get isRefresh => _startOffset == offset;
}
