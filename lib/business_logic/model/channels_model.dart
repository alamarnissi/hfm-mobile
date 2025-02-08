/// id : "ViaOccitanieMontpellier.fr"
/// name : "ViaOccitanie Montpellier"
/// alt_names : ["ViàOccitanie Montpellier"]
/// network : "ViàOccitanie"
/// owners : ["Groupe La Dépêche du Midi"]
/// country : "FR"
/// subdivision : null
/// city : "Montpellier"
/// broadcast_area : ["c/FR"]
/// languages : ["fra"]
/// categories : ["general"]
/// is_nsfw : false
/// launched : "2007-05-21"
/// closed : null
/// replaced_by : null
/// website : "https://viaoccitanie.tv/"
/// logo : "https://upload.wikimedia.org/wikipedia/commons/4/4b/Viaoccitaniemontpellier.png"

class ChannelsModel {
  ChannelsModel({
      String? id, 
      String? name, 
      List<String>? altNames, 
      String? network, 
      List<String>? owners, 
      String? country, 
      dynamic subdivision, 
      String? city, 
      List<String>? broadcastArea, 
      List<String>? languages, 
      List<String>? categories, 
      bool? isNsfw, 
      String? launched, 
      dynamic closed, 
      dynamic replacedBy, 
      String? website, 
      String? logo,}){
    _id = id;
    _name = name;
    _altNames = altNames;
    _network = network;
    _owners = owners;
    _country = country;
    _subdivision = subdivision;
    _city = city;
    _broadcastArea = broadcastArea;
    _languages = languages;
    _categories = categories;
    _isNsfw = isNsfw;
    _launched = launched;
    _closed = closed;
    _replacedBy = replacedBy;
    _website = website;
    _logo = logo;
}

  ChannelsModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _altNames = json['alt_names'] != null ? json['alt_names'].cast<String>() : [];
    _network = json['network'];
    _owners = json['owners'] != null ? json['owners'].cast<String>() : [];
    _country = json['country'];
    _subdivision = json['subdivision'];
    _city = json['city'];
    _broadcastArea = json['broadcast_area'] != null ? json['broadcast_area'].cast<String>() : [];
    _languages = json['languages'] != null ? json['languages'].cast<String>() : [];
    _categories = json['categories'] != null ? json['categories'].cast<String>() : [];
    _isNsfw = json['is_nsfw'];
    _launched = json['launched'];
    _closed = json['closed'];
    _replacedBy = json['replaced_by'];
    _website = json['website'];
    _logo = json['logo'];
  }
  String? _id;
  String? _name;
  List<String>? _altNames;
  String? _network;
  List<String>? _owners;
  String? _country;
  dynamic _subdivision;
  String? _city;
  List<String>? _broadcastArea;
  List<String>? _languages;
  List<String>? _categories;
  bool? _isNsfw;
  String? _launched;
  dynamic _closed;
  dynamic _replacedBy;
  String? _website;
  String? _logo;
ChannelsModel copyWith({  String? id,
  String? name,
  List<String>? altNames,
  String? network,
  List<String>? owners,
  String? country,
  dynamic subdivision,
  String? city,
  List<String>? broadcastArea,
  List<String>? languages,
  List<String>? categories,
  bool? isNsfw,
  String? launched,
  dynamic closed,
  dynamic replacedBy,
  String? website,
  String? logo,
}) => ChannelsModel(  id: id ?? _id,
  name: name ?? _name,
  altNames: altNames ?? _altNames,
  network: network ?? _network,
  owners: owners ?? _owners,
  country: country ?? _country,
  subdivision: subdivision ?? _subdivision,
  city: city ?? _city,
  broadcastArea: broadcastArea ?? _broadcastArea,
  languages: languages ?? _languages,
  categories: categories ?? _categories,
  isNsfw: isNsfw ?? _isNsfw,
  launched: launched ?? _launched,
  closed: closed ?? _closed,
  replacedBy: replacedBy ?? _replacedBy,
  website: website ?? _website,
  logo: logo ?? _logo,
);
  String? get id => _id;
  String? get name => _name;
  List<String>? get altNames => _altNames;
  String? get network => _network;
  List<String>? get owners => _owners;
  String? get country => _country;
  dynamic get subdivision => _subdivision;
  String? get city => _city;
  List<String>? get broadcastArea => _broadcastArea;
  List<String>? get languages => _languages;
  List<String>? get categories => _categories;
  bool? get isNsfw => _isNsfw;
  String? get launched => _launched;
  dynamic get closed => _closed;
  dynamic get replacedBy => _replacedBy;
  String? get website => _website;
  String? get logo => _logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['alt_names'] = _altNames;
    map['network'] = _network;
    map['owners'] = _owners;
    map['country'] = _country;
    map['subdivision'] = _subdivision;
    map['city'] = _city;
    map['broadcast_area'] = _broadcastArea;
    map['languages'] = _languages;
    map['categories'] = _categories;
    map['is_nsfw'] = _isNsfw;
    map['launched'] = _launched;
    map['closed'] = _closed;
    map['replaced_by'] = _replacedBy;
    map['website'] = _website;
    map['logo'] = _logo;
    return map;
  }

}