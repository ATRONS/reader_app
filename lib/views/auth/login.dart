import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, password;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildLogo(),
            _buildAppName(),
            SizedBox(
              height: 20,
            ),
            _buildTextFields(),
            SizedBox(
              height: 50,
            ),
            _buildButtons(provider),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        backgroundColor: Colors.brown.shade800,
        child: Text(''),
        radius: 70,
      ),
    );
  }

  Widget _buildAppName() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          "ATRONS",
          style: TextStyle(fontSize: 17),
        ));
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey)),
              onChanged: (value) {
                email = value;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey)),
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(UserProvider provider) {
    return Selector<UserProvider, AuthenticationState>(
      builder: (context, data, child) {
        return InkWell(
          onTap: () {
            provider.loginUser(email, password, _doLogin);
          },
          child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).accentColor),
              child: Center(
                child: data == AuthenticationState.authenticating
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.all(5),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
              )),
        );
      },
      selector: (buildContext, usrprovider) => usrprovider.loginStatus,
    );
  }

  void _doLogin() {
    MyRouter.pushPageReplacement(context, HomeScreen());
  }
}
