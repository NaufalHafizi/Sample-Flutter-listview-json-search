import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class DestinationPage extends StatelessWidget {

  final loccode;
  
  DestinationPage({this.loccode});

  @override
  Widget build(BuildContext context) {
    
    final toppadding = MediaQuery.of(context).padding.top; // kalau screen ada notch
    var appbarheight = AppBar().preferredSize.height + toppadding; //amik height bar tambah dengan notch
    final screenheight = (MediaQuery.of(context).size.height-appbarheight) / 100;

    final allscreen = Provider.of<Allscreen>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Destination"),),
        body: FutureBuilder(
        future: allscreen.hasitrunDestination ? null : allscreen.fetchDestination(loccode),
        builder: (context, snapshot){
          if (snapshot.hasData){
            allscreen.hasitrunDestination = true;
            return Column(
              children: <Widget>[
                SizedBox(height: screenheight * 1.5,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(40))
                ),
                hintText: "Search location"
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                allscreen.setDestinationForDisplay = allscreen.destinations.where((note){
                  var destinationName = note.locationName.toLowerCase();
                  return destinationName.contains(text);
                }).toList();
              },
            ),
            SizedBox(height: screenheight * 1.5,),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allscreen.getDestinationForDisplay.length,
                        itemBuilder: (context, index){
                          return _listitem(context,index);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Scaffold(body: new Container(child: new Center(child: new CircularProgressIndicator(),),));
          }
        },
      ),
    );
  }

  _listitem(BuildContext context,int index) {
    final allscreen = Provider.of<Allscreen>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                allscreen.getDestinationForDisplay[index].locationName, 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(allscreen.getDestinationForDisplay[index].locationCode),
            ],
          ),
        ),
      ),
    );
  }
}