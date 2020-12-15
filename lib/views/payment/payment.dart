import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentIndex;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment"),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            1,
            (index) {
              return Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPaymentIndex = index;
                    });
                    _showPhoneDialog(context);
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      'assets/images/hellocash.jpg',
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: index == _selectedPaymentIndex
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        )),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _showPhoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(),
                ),
              ),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Enter Phone Number",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 3.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 3.0),
                            ),
                            hintText: 'phone'),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          if (isValidPhoneNumber(phoneNumber)) {
                            final materialSelected =
                                Provider.of<DetailProvider>(context,
                                        listen: false)
                                    .selectedMaterial;

                            final materialProvider =
                                Provider.of<MaterialProvider>(context,
                                    listen: false);
                            final paymentmade =
                                await materialProvider.purchaseMaterial(
                                    materialSelected.id, phoneNumber);

                            print(paymentmade);
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).accentColor),
                              child: Center(
                                  child:
                                      Selector<MaterialProvider, LoadingState>(
                                          selector: (context, model) =>
                                              model.purchaseLoadingState,
                                          builder: (context, state, child) {
                                            if (state == LoadingState.loading) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                              //     Text(
                                              //   "Submit",
                                              //   style: TextStyle(color: Colors.white),
                                              // ),
                                            }
                                          })),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
