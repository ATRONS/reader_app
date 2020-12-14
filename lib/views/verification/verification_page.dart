import 'package:atrons_mobile/providers/app_provider.dart';
import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String _errorMsg = '';
  String _otp_value = '';
  bool _valid = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  // border: InputBorder,
                  hintText: "Enter verification code",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (String value) {
                  _otp_value = value.trim();
                  _valid = value.trim().length == 6;
                },
              ),
              _buildVerifyButton(),
              _buildResendVerification(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return InkWell(
      onTap: () async {
        print('valid:: $_valid');
        if (!_valid || _loading) return;
        setState(() {
          _loading = true;
          _errorMsg = '';
        });
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final result = await userProvider.verifyUser(_otp_value);

        setState(() {
          _loading = false;
        });

        if (result) {
          final appProvider = Provider.of<AppProvider>(context, listen: false);
          await appProvider.setAppState(AppState.LOGGED_IN);
          MyRouter.pushPageReplacement(context, HomeScreen());
        } else {
          setState(() {
            _errorMsg = 'could not verify email, try again';
          });
        }
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).accentColor),
        child: Center(
          child: _loading
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
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget _buildResendVerification() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            Constants.resendVerification,
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
      ),
    );
  }
}
