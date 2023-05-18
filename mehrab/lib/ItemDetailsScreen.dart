import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ItemDetailsScreen extends StatelessWidget {
final DocumentSnapshot post;

  //to show the Item detail screen for the selected list tile (list item)
  ItemDetailsScreen(this.post);

  // create the location url and retreving the location from the DB 
  _launchURL() async {
    Uri _url = Uri.parse(post['Location']);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
Widget build(BuildContext context) {
return Scaffold(
resizeToAvoidBottomInset: false,
appBar: AppBar(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.vertical(
bottom: Radius.circular(20),
),
),
leading: Container(), 
actions: [
IconButton(
icon: Transform(
alignment: Alignment.center,
transform: Matrix4.rotationY(math.pi),
child: Icon(Icons.arrow_back),
),
onPressed: () {
Navigator.pop(context);
},
),
],
automaticallyImplyLeading: false, // this is used the remove the automatic leading
centerTitle: true,
backgroundColor: Color.fromARGB(255, 20, 5, 87),

//adding the mosque name as a title in the Appbar
title: Text(
post['Name'],
style: TextStyle(fontFamily: 'Elmessiri'),
),
),


      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Column( 
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          width: 450,
                          height: 250,
                          //Adding the images retrived from the DB
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              post['Image'],
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        /*create column of rows , column for التفاصيل text and the rows for the 
                        district name , google maps location and mosque managers names  */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [ Text(
                              'التفاصيل ',
                              style: new TextStyle(
                                fontFamily: 'Elmessiri',
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Color.fromARGB(255, 20, 5, 87),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text('الحي: ${post['District']}',
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                        fontFamily: 'Elmessiri',
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 20, 5, 87),
                                      )),
                                ),
                                Icon(
                                  Icons.location_city_rounded,
                                  color: Color.fromRGBO(212, 175, 55, 1),
                                  size: 40,
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded( //open location with google maps
                                  child: InkWell(
                                    onTap: _launchURL,
                                    child: const Text(
                                      'افتح مع خارطة جوجل',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'Elmessiri',
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 37, 171, 238),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Color.fromRGBO(212, 175, 55, 1),
                                  size: 40,
                                )
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text('الإمام: ${post['Imam name']}',
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                          fontFamily: 'Elmessiri',
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 20, 5, 87))),
                                ),

                                Icon(
                                  Icons.person_2_outlined,
                                  color: Color.fromRGBO(212, 175, 55, 1),
                                  size: 40,
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text('المؤذن: ${post['Muathen name']}',
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                          fontFamily: 'Elmessiri',

                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 20, 5, 87))),
                                ),
                                Icon(
                                  Icons.person_2_outlined,
                                  color: Color.fromRGBO(212, 175, 55, 1),
                                  size: 40,
                                ),
                              ],
                            ),
                          ],
                        ),

                      //create column for the announcements 
                        Column(
                          children: const [
                            Divider(
                              color: Color.fromARGB(255, 166, 165, 167),
                            ),
                            Text(
                              'المستجدات',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 20, 5, 87),
                                fontFamily: 'Elmessiri',
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Text(
                              'لا يوجد مستجدات حالية',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 166, 165, 167),
                                fontFamily: 'Elmessiri',
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                            ),
                           SizedBox(height: 190 ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}