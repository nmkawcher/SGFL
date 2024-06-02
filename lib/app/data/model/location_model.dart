class LocationModel{

  int? locationId;
  String? locationName;

  LocationModel({this.locationId, this.locationName});

  static List<LocationModel> locationList = [
    LocationModel(locationId: 1, locationName: 'Dhaka'),
    LocationModel(locationId: 2, locationName: 'Chattogram'),
    LocationModel(locationId: 3, locationName: 'Khulna'),
    LocationModel(locationId: 4, locationName: 'Rajshahi'),
    LocationModel(locationId: 5, locationName: 'Barishal'),
    LocationModel(locationId: 6, locationName: 'Sylhet'),
    LocationModel(locationId: 7, locationName: 'Rangpur'),
    LocationModel(locationId: 8, locationName: 'Mymensingh'),
  ];



}