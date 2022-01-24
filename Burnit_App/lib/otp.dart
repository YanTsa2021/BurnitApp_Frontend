//One Time Password implementation (OTP)

import 'dart:convert';

import 'package:burnit_app/forgotpassword.dart';
import 'package:http/http.dart' as http;
import 'package:burnit_app/setnewpassword.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import 'checkconnectivity.dart';


void main() {
  var key;
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) =>  SendOTP(mail: '',codeVariable: '', key: key,),
    },
  ));
}

class SendOTP extends StatefulWidget {
  final String mail;
  final String codeVariable;

  const SendOTP ({required Key key ,  required this.mail, required this.codeVariable,}): super(key: key);
  @override
  CustomViewState createState() {
    return  CustomViewState();
  }
}

class CustomViewState extends State <SendOTP>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  int _otpCodeLength = 5;
  bool _isLoadingButton = false;
  bool _enableButton = false;

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _userProfile.otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      //_formKey.currentState!.showSnackBar(
      //SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }
  //Fonction to resend OTP number
  Future  ResendOTP() async {
    final response = await http.post( Uri.parse('http://api.burnit.socecepme.com/api/auth/recover'), body: {
      "email": widget.mail,
    });

    if(response.statusCode == 200){
      _userProfile.coderesp = jsonDecode(response.body)['data']['user']['code'];
      print(_userProfile.coderesp.toString());
      Fluttertoast.showToast(msg: "OTP number was sent successfully");

    }
    else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
              child: Container(
                margin: const EdgeInsets.only(top:40.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                height: 45.0,
                width: 350.0,
                alignment:Alignment.centerLeft,
                        child: Container(
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
                                      builder: (context) => ForgotPassWord()));
                                },
                                child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                              )
                          ),
                        ),
                  ),
            preferredSize: const Size.fromHeight(500.0),
          ),
            resizeToAvoidBottomInset: false, // set it to false
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    alignment:Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/ImgBurnit.png'),)),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(1),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.center,
                    child: RichText(
                      text: TextSpan(text: '           Enter OTP',
                        style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nEnter OTP here to continuing with us', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(1),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(10.0),
                    child: TextFieldPin(
                      filled: true,
                      filledColor: Colors.white70,
                      codeLength: _otpCodeLength,
                      boxSize: 53,
                      filledAfterTextChange: false,
                      textStyle: const TextStyle(fontSize: 16),
                      borderStyle: OutlineInputBorder(
                          borderSide: BorderSide( color: Colors.white70,width: 0.5,),
                          borderRadius: BorderRadius.circular(8)),
                      onOtpCallback: (code, isAutofill) =>
                          _onOtpCallBack(code, isAutofill),
                    ),
                  ),
                  Container(
                      width: 350,
                      alignment:Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text.rich(
                        TextSpan(text: 'Resend OTP', style: TextStyle(color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold,),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              ResendOTP();
                            }
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(110),
                    padding: EdgeInsets.all(100),
                  ),
                  Container(
                    height: 44.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: SizedBox(
                      height: 44.0,
                      width: 350.0,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.white,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide( color: Colors.purple,width: 1,)
                        ),
                        child: const Text('verify',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                          onPressed: () {
                            // It returns true if the form is valid, otherwise returns false
                            var key;
                            var result = _enableButton ? _onSubmitOtp : null;
                            child: _setUpButtonChild();
                            print('Verification OTP Code )${_userProfile.otpCode.toString()}  Success');
                            print('CodeVariable )${widget.codeVariable.toString()}  Success');
                            print('Resend Code )${_userProfile.coderesp.toString()}  Success');
                            print('${widget.mail} mail was passed');
                            if ( result != null && _userProfile.otpCode.toString() == _userProfile.coderesp.toString() ) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SetNewPassWord(
                                    otpCode: _userProfile.otpCode.toString(),mail: widget.mail, key: key,)) );
                            }
                            if ( result != null && _userProfile.otpCode.toString() == widget.codeVariable.toString() ) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SetNewPassWord(
                                    otpCode: _userProfile.otpCode.toString(),mail: widget.mail, key: key,)) );
                            }
                            else {
                              Fluttertoast.showToast(msg: "Invalid OTP number");
                            }
                          }
                      ),
                      ),
                    ),
                  ),

                  Container(
                    height: 20.0,
                    width: 350.0,
                    alignment:Alignment.centerRight,
                    child: CheckConnectivity(),
                  ),//
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
