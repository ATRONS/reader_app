class MiniMaterial {
  String id, title, subtitle, coverImgUrl;

  MiniMaterial.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        subtitle = json['subtitle'],
        coverImgUrl = json['cover_img_url'];
}
