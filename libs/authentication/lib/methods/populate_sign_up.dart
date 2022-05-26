// import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/app_state.dart';
import 'dart:ui';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/link.dart';
import '../widgets/textfield.dart';

class SignUp extends StatelessWidget {
  final Store<AppState> store;
  const SignUp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          
          //*****************Top circle blur**********************
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(top: 2),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          //******************************************************* 
        
          //*****************signup page****************************
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //*****************LOGO*****************************
              //to be fixed in coming days
              //*************************************************
           
              //*****************form****************************
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const <Widget>[
                    //*****************email**********************
                    TextFieldWidget(label: 'email', obscure: false),
                    //********************************************
                    TransparentDividerWidget(),
                    //*****************password**********************
                    TextFieldWidget(label: 'email', obscure: true),
                    //**********************************************
                    TransparentDividerWidget(),
                    //*****************password**********************
                    TextFieldWidget(label: 'email', obscure: true),
                    //**********************************************
                  ],
                 ),
              ),
              //****************************************************

              //*****************login button**********************
              const LongButtonWidget(text: "sign up"),
              //***************************************************

              //*****************"OR" divider"**********************
              SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Expanded(
                       child: DividerWidget(),
                    ),
                    Text("or"),
                    Expanded(
                      child: DividerWidget(),
                    ),
                  ],
                ),
              ),
              //****************************************************** */

              //*****************Sign up Link**********************
             const LinkWidget(text: "Sign In"),
           
              //******************************************************* */
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 15,
                endIndent: 10,
                color: Colors.transparent,
              ),
              //*******************sign in with text************************** */
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                    child: Text(
                      'or sign up with:',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 12,
                        color: Color(0x7df5fffa),
                      ),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
           ],
          ),

          //******************************************************* */

          //*****************Bottom circle blur**********************
          //to be fixed in coming days
          //******************************************************* */
        ],
      ),
    );
  }
}
