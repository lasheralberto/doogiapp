// ignore_for_file: unnecessary_getters_setters

class photoBay {
  int? _total;
  int? _totalHits;
  List<Hits>? _hits;

  photoBay({int? total, int? totalHits, List<Hits>? hits}) {
    if (total != null) {
      this._total = total;
    }
    if (totalHits != null) {
      this._totalHits = totalHits;
    }
    if (hits != null) {
      this._hits = hits;
    }
  }

  int? get total => _total;
  set total(int? total) => _total = total;
  int? get totalHits => _totalHits;
  set totalHits(int? totalHits) => _totalHits = totalHits;
  List<Hits>? get hits => _hits;
  set hits(List<Hits>? hits) => _hits = hits;

  factory photoBay.fromJson(Map<String, dynamic> json) {
    return photoBay(total: json['total'], totalHits: json['totalHits']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this._total;
    data['totalHits'] = this._totalHits;
    if (this._hits != null) {
      data['hits'] = this._hits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hits {
  int? _id;
  String? _pageURL;
  String? _type;
  String? _tags;
  String? _previewURL;
  int? _previewWidth;
  int? _previewHeight;
  String? _webformatURL;
  int? _webformatWidth;
  int? _webformatHeight;
  String? _largeImageURL;
  int? _imageWidth;
  int? _imageHeight;
  int? _imageSize;
  int? _views;
  int? _downloads;
  int? _collections;
  int? _likes;
  int? _comments;
  int? _userId;
  String? _user;
  String? _userImageURL;

  Hits(
      {int? id,
      String? pageURL,
      String? type,
      String? tags,
      String? previewURL,
      int? previewWidth,
      int? previewHeight,
      String? webformatURL,
      int? webformatWidth,
      int? webformatHeight,
      String? largeImageURL,
      int? imageWidth,
      int? imageHeight,
      int? imageSize,
      int? views,
      int? downloads,
      int? collections,
      int? likes,
      int? comments,
      int? userId,
      String? user,
      String? userImageURL}) {
    if (id != null) {
      this._id = id;
    }
    if (pageURL != null) {
      this._pageURL = pageURL;
    }
    if (type != null) {
      this._type = type;
    }
    if (tags != null) {
      this._tags = tags;
    }
    if (previewURL != null) {
      this._previewURL = previewURL;
    }
    if (previewWidth != null) {
      this._previewWidth = previewWidth;
    }
    if (previewHeight != null) {
      this._previewHeight = previewHeight;
    }
    if (webformatURL != null) {
      this._webformatURL = webformatURL;
    }
    if (webformatWidth != null) {
      this._webformatWidth = webformatWidth;
    }
    if (webformatHeight != null) {
      this._webformatHeight = webformatHeight;
    }
    if (largeImageURL != null) {
      this._largeImageURL = largeImageURL;
    }
    if (imageWidth != null) {
      this._imageWidth = imageWidth;
    }
    if (imageHeight != null) {
      this._imageHeight = imageHeight;
    }
    if (imageSize != null) {
      this._imageSize = imageSize;
    }
    if (views != null) {
      this._views = views;
    }
    if (downloads != null) {
      this._downloads = downloads;
    }
    if (collections != null) {
      this._collections = collections;
    }
    if (likes != null) {
      this._likes = likes;
    }
    if (comments != null) {
      this._comments = comments;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (user != null) {
      this._user = user;
    }
    if (userImageURL != null) {
      this._userImageURL = userImageURL;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get pageURL => _pageURL;
  set pageURL(String? pageURL) => _pageURL = pageURL;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get tags => _tags;
  set tags(String? tags) => _tags = tags;
  String? get previewURL => _previewURL;
  set previewURL(String? previewURL) => _previewURL = previewURL;
  int? get previewWidth => _previewWidth;
  set previewWidth(int? previewWidth) => _previewWidth = previewWidth;
  int? get previewHeight => _previewHeight;
  set previewHeight(int? previewHeight) => _previewHeight = previewHeight;
  String? get webformatURL => _webformatURL;
  set webformatURL(String? webformatURL) => _webformatURL = webformatURL;
  int? get webformatWidth => _webformatWidth;
  set webformatWidth(int? webformatWidth) => _webformatWidth = webformatWidth;
  int? get webformatHeight => _webformatHeight;
  set webformatHeight(int? webformatHeight) =>
      _webformatHeight = webformatHeight;
  String? get largeImageURL => _largeImageURL;
  set largeImageURL(String? largeImageURL) => _largeImageURL = largeImageURL;
  int? get imageWidth => _imageWidth;
  set imageWidth(int? imageWidth) => _imageWidth = imageWidth;
  int? get imageHeight => _imageHeight;
  set imageHeight(int? imageHeight) => _imageHeight = imageHeight;
  int? get imageSize => _imageSize;
  set imageSize(int? imageSize) => _imageSize = imageSize;
  int? get views => _views;
  set views(int? views) => _views = views;
  int? get downloads => _downloads;
  set downloads(int? downloads) => _downloads = downloads;
  int? get collections => _collections;
  set collections(int? collections) => _collections = collections;
  int? get likes => _likes;
  set likes(int? likes) => _likes = likes;
  int? get comments => _comments;
  set comments(int? comments) => _comments = comments;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get user => _user;
  set user(String? user) => _user = user;
  String? get userImageURL => _userImageURL;
  set userImageURL(String? userImageURL) => _userImageURL = userImageURL;

  factory Hits.fromJson(Map<String, dynamic> json) {
    return Hits(
        pageURL: json['pageURL'],
        previewURL: json['previewURL'],
        largeImageURL: json['largeImageURL'],
        userImageURL: json['userImageURL']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['pageURL'] = this._pageURL;
    data['type'] = this._type;
    data['tags'] = this._tags;
    data['previewURL'] = this._previewURL;
    data['previewWidth'] = this._previewWidth;
    data['previewHeight'] = this._previewHeight;
    data['webformatURL'] = this._webformatURL;
    data['webformatWidth'] = this._webformatWidth;
    data['webformatHeight'] = this._webformatHeight;
    data['largeImageURL'] = this._largeImageURL;
    data['imageWidth'] = this._imageWidth;
    data['imageHeight'] = this._imageHeight;
    data['imageSize'] = this._imageSize;
    data['views'] = this._views;
    data['downloads'] = this._downloads;
    data['collections'] = this._collections;
    data['likes'] = this._likes;
    data['comments'] = this._comments;
    data['user_id'] = this._userId;
    data['user'] = this._user;
    data['userImageURL'] = this._userImageURL;
    return data;
  }
}
