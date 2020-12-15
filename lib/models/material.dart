import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/review.dart';
import 'package:atrons_mobile/utils/api.dart';

class MiniMaterial {
  String id,
      iD,
      type,
      title,
      subtitle,
      coverImgUrl,
      coverImgFileUrl,
      publishedDate;
  Map<String, dynamic> provider;
  int edition;

  MiniMaterial.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        iD = json['iD'],
        type = json['type'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = Api.baseUrl + json['cover_img_url'],
        coverImgFileUrl = json['cover_img_file_url'],
        edition = json['edition'],
        publishedDate = json['published_date'],
        provider = json['provider'];
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
      publishedDate;

  int pages, edition;

  bool owned;

  Map<String, dynamic> file, provider, price, rating, readersLastRating;

  List<Genere> tags;
  List<Review> reviews;
  List<MiniMaterial> moreFromAuthor;

  MaterialDetail.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        type = json['type'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = Api.baseUrl + json['cover_img_url'],
        displayDate = json['display_date'],
        isbn = json['ISBN'],
        synopsis = json['synopsis'],
        // review = json['review'],
        pages = json['pages'],
        edition = json['edition'],
        file = json['file'],
        provider = json['provider'],
        publishedDate = json['published_date'],
        price = json['price'],
        rating = json['rating'],
        owned = json['owned'],
        tags = List<dynamic>.from(json['tags'])
            .map((each) => Genere.fromJSON(each))
            .toList(),
        reviews = List<dynamic>.from(json['material_ratings']['ratings'])
            .map((review) => Review.fromJSON(review))
            .toList(),
        moreFromAuthor =
            List<dynamic>.from(json['more_from_provider']['materials'])
                .map((morematerial) => MiniMaterial.fromJSON(morematerial))
                .toList(),
        readersLastRating = json['readers_last_rating'];

  Map<String, dynamic> toMiniJSON() {
    return {
      '_id': this.id,
      'iD': this.id,
      'type': this.type,
      'title': this.title,
      'subtitle': this.subtitle,
      'cover_img_url': this.coverImgUrl,
      'edition': this.edition,
      'provider': this.provider,
      'published_date': this.publishedDate
    };
  }
}
