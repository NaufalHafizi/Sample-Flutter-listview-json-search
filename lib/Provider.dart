import 'package:flutter/material.dart';
import 'package:listview_jsonsearch_provider/model/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:listview_jsonsearch_provider/model/namaNegeri.dart';

class Allscreen with ChangeNotifier{

  List<Location> locations = List<Location>();
  List<Location> destinations = List<Location>();
  List<Location> destinationForDisplay = List<Location>();
  List<Location> locationsForDisplay = List<Location>();

  bool hasitrunDestination = false;

  get getlocationForDisplay => locationsForDisplay;
  set setlocationForDisplay(List<Location> newvalue2){
    locationsForDisplay = newvalue2;
    notifyListeners();
  }

  get getDestinationForDisplay => destinationForDisplay;
  set setDestinationForDisplay(List<Location> newvalue){
    destinationForDisplay = newvalue;
    notifyListeners();
  }

  Future<List<Location>> fetchlocation(BuildContext context) async {

      http.Response response = await http.get(
      Uri.encodeFull('https://api.myjson.com/bins/19p1kr'),//https://api.myjson.com/bins/num9u
      );
    
    var location = List<Location>();
    
    if (response.statusCode == 200) {
      var locationJson = json.decode(response.body);
      for (var noteJson in locationJson) {
        location.add(Location.fromJson(noteJson));
      }
    }


    for (var i = 0; i < location.length; i++){
      location[i].locationName = listNegeri(i, location[i].negeri) + ' - ' + location[i].locationName;
    }
    
    location.sort((a, b) => a.locationName.compareTo(b.locationName));

    locations.addAll(location);
    locationsForDisplay = locations;

    return location;
  }

  Future<List<Location>> fetchDestination(loccode) async {

    http.Response response = await http.get(
      Uri.encodeFull('https://jsonstorage.net/api/items/1e9a7a98-fcad-445e-a8c5-42ad20358e34'),
    );

    Map data = json.decode(response.body);
    var destinationLists = data["Routes"][loccode];

    var destination = List<Location>();

    if (destinationLists == null){
      return [];
    } else {
      for (var i = 0; i < destinationLists.length; i++){
        var namedestination = locations.where((note){
          return note.locationCode==destinationLists[i];
        });
        destination.addAll(namedestination);
      }
    }

    setDestinationForDisplay = destination;

    destinations= destination;
    destinationForDisplay = destinations;

    
    return destination;
  }
}
