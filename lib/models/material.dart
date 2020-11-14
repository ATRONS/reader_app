import 'package:atrons_mobile/utils/api.dart';

class MiniMaterial {
  String id, title, subtitle, coverImgUrl;

  MiniMaterial.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = Api.baseUrl + json['cover_img_url'];
}
