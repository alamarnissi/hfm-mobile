/// title : ""
/// group : ""
/// logo : ""
/// url : ""

class TvChannelEntity {
  TvChannelEntity({
      String? title, 
      String? group, 
      String? logo, 
      String? url,}){
    _title = title;
    _group = group;
    _logo = logo;
    _url = url;
}

  TvChannelEntity.fromJson(dynamic json) {
    _title = json['title'];
    _group = json['group'];
    _logo = json['logo'];
    _url = json['url'];
  }
  String? _title;
  String? _group;
  String? _logo;
  String? _url;
TvChannelEntity copyWith({  String? title,
  String? group,
  String? logo,
  String? url,
}) => TvChannelEntity(  title: title ?? _title,
  group: group ?? _group,
  logo: logo ?? _logo,
  url: url ?? _url,
);
  String? get title => _title;
  String? get group => _group;
  String get logo => _logo!=null && !_logo!.contains('file:///') ?_logo!:'https://placehold.co/400x600.png';
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['group'] = _group;
    map['logo'] = _logo;
    map['url'] = _url;
    return map;
  }

}