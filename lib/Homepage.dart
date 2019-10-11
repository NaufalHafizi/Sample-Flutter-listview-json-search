import 'package:flutter/material.dart';
import 'package:listview_jsonsearch_provider/destinationpage.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class MyHomePage extends StatelessWidget {
  
  static bool hasitrun = false;

  @override
  Widget build(BuildContext context) {
    
    final allscreen = Provider.of<Allscreen>(context);

    final toppadding = MediaQuery.of(context).padding.top; // kalau screen ada notch
    var appbarheight = AppBar().preferredSize.height + toppadding; //amik height bar tambah dengan notch
    final screenheight = (MediaQuery.of(context).size.height-appbarheight) / 100;
    //final screenwidth = MediaQuery.of(context).size.width / 100;


    return Scaffold(
      appBar: new AppBar(title: new Text('Bas Location'),backgroundColor: Colors.red,),
      body: new Container(
        child: Column(
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
                allscreen.setlocationForDisplay = allscreen.locations.where((note){
                  var locationName = note.locationName.toLowerCase();
                  return locationName.contains(text);
                }).toList();
              },
            ),
            SizedBox(height: screenheight * 1.5,),
            FutureBuilder(
                future: hasitrun ? null : allscreen.fetchlocation(context),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    hasitrun = true;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allscreen.getlocationForDisplay.length,
                          itemBuilder: (context, index){
                            return _listitem(context,index);
                          },
                        ),
                      ),
                    );
                  } else {
                    return Expanded(child: new Container(child: new Center(child: new CircularProgressIndicator(),),));
                  }
                },
              ),
          ],
        ),
      ),
      
    );
  }

  _listitem(BuildContext context,int index) {
    final allscreen = Provider.of<Allscreen>(context);
    return InkWell(
      onTap: () {
        allscreen.destinations.clear();
        allscreen.destinationForDisplay.clear();
        allscreen.hasitrunDestination = false;
        Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>DestinationPage(loccode:allscreen.getlocationForDisplay[index].locationCode)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  allscreen.getlocationForDisplay[index].locationName, 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(allscreen.getlocationForDisplay[index].locationCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}