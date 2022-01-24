//Upcoming exercise by coach page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/newsfeed.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => UpComingExerciseByCoach(),
    },
  ));
}

class UpComingExerciseByCoach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Container(
                    margin: const EdgeInsets.only(top:2.0),
                    height: 35.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                              width: 35.0,
                              alignment:Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => NewsFeed(userId: '',)));
                                },
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 230.0,
                          alignment:Alignment.center,
                          child: const Text('Exercise',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: 0.2,
            ),
            resizeToAvoidBottomInset: false, // set it to false
            body: Center(
                child: MyCustomForm()
            )
        )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < MyCustomForm>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 172.0,
                  alignment:Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8.0),),
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: const Text('By Coach',style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                      }
                  ),
                ),
                Container(
                  width: 0.0,
                ),
                Container(
                  width: 172.0,
                  alignment:Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(8.0),),
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.grey,
                      color: Colors.white38,
                      child: const Text('All Exercise',style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {

                      }
                  ),
                ),
              ],

            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 40,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: <Widget>[
                            _story.conversations(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                    width: 10.0,
                    alignment:Alignment.center,
                    child: Text.rich(
                      TextSpan(text: ':', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => BasicInfoProfilePicture(userId: '',))
                            );
                          }
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            width: 350,
            height: 200,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: AssetImage('assets/ImgUpcomingExerciseSeven.png'),
                    fit: BoxFit.cover)),

          ),
          Container(
            //padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
            width: 350,
            margin: const EdgeInsets.only(top:5.0),
            alignment:Alignment.centerLeft,
            child: RichText(
              text: TextSpan(text: 'Abdominal Crunches',
                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '       12Reps * 4Sets * 10Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 40,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: <Widget>[
                            _story.conversations(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                    width: 10.0,
                    alignment:Alignment.center,
                    child: Text.rich(
                      TextSpan(text: ':', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => BasicInfoProfilePicture(userId: '',))
                            );
                          }
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            width: 350,
            height: 200,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: AssetImage('assets/ImgUpcomingExerciseTwo.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            //padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
            width: 350,
            margin: const EdgeInsets.only(top:5.0),
            alignment:Alignment.centerLeft,
            child: RichText(
              text: TextSpan(text: 'Push Ups',
                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '                                 15Reps * 8Sets * 15Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}