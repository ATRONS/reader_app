import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/utils/api.dart';

class MiniMaterial {
  String id, iD, type, title, subtitle, coverImgUrl, coverImgFileUrl;

  MiniMaterial.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        iD = json['iD'],
        type = json['type'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = Api.baseUrl + json['cover_img_url'],
        coverImgFileUrl = json['cover_img_file_url'];
}

class MiniCompanyMaterial {
  String id, about, legalName, displayName, avatarUrl;

  MiniCompanyMaterial.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        about = json['about'],
        legalName = json['legal_name'],
        displayName = json['display_name'],
        avatarUrl = Api.baseUrl + json['avatar_url'];
}

class MaterialDetail {
  String id,
      type,
      title,
      subtitle,
      coverImgUrl,
      displayDate,
      isbn,
      synopsis,
      review;

  int pages, edition;

  Map<String, dynamic> file, provider, price, rating;

  List<Genere> tags;

  MaterialDetail.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        type = json['type'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = Api.baseUrl + json['cover_img_url'],
        displayDate = json['display_date'],
        isbn = json['ISBN'],
        synopsis = json['synopsis'],
        review = json['review'],
        pages = json['pages'],
        edition = json['edition'],
        file = json['file'],
        provider = json['provider'],
        price = json['price'],
        rating = json['rating'],
        tags = List<dynamic>.from(json['tags'])
            .map((each) => Genere.fromJSON(each))
            .toList();

  Map<String, dynamic> toMiniJSON() {
    return {
      '_id': this.id,
      'iD': this.id,
      'type': this.type,
      'title': this.title,
      'subtitle': this.subtitle,
      'cover_img_url': this.coverImgUrl,
    };
  }
}
