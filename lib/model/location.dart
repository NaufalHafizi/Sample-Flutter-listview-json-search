 class Location {
  String locationName;
  String locationCode;
  String negeri;
  
  Location(this.locationName, this.locationCode, this.negeri);

  Location.fromJson(Map<String, dynamic> json) {
    locationName = json['LocationName'];
    locationCode = json['LocationCode'];
    negeri = json['StatesName'];
  }
}