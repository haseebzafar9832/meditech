class ProductItem {
  int? count;
  String? next;
  Null? previous;
  List<Results>? results;

  ProductItem({this.count, this.next, this.previous, this.results});

  ProductItem.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? quantity;
  String? title;
  String? description;
  List<Images>? images;
  double? price;
  int? off;
  var brand;
  var store;
  String? createdAt;
  String? updatedAt;
  bool? is_favourite;
  Results({
    this.id,
    this.quantity = 0,
    this.title,
    this.description,
    this.images,
    this.price,
    this.off,
    this.brand,
    this.store,
    this.createdAt,
    this.updatedAt,
    this.is_favourite,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = 0;
    off = 0;
    title = json['title'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    price = double.tryParse(json['price'].toString());
    brand = json['brand'];
    store = json['store'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    is_favourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['brand'] = this.brand;
    data['store'] = this.store;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_favourite'] = this.is_favourite;
    return data;
  }
}

class Images {
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Images({this.imageUrl, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
