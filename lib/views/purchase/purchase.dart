import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Purchase extends StatefulWidget {
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  // String _buyRentValue = "buy";

  @override
  Widget build(BuildContext context) {
    final detailProvicer = Provider.of<DetailProvider>(context, listen: false);
    final material = detailProvicer.selectedMaterial;

    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Image.network(
                      material.coverImgUrl,
                      height: 200.0,
                      width: 130.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              material.title,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              material.provider['display_name'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Material(
                            type: MaterialType.transparency,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  Constants.sellingPrice,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  maxLines: 3,
                                ),
                                Text(
                                  '${material.price['selling']} ${Constants.currency}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Text(
            //     "Choose Purchase Option",
            //     style: TextStyle(fontSize: 17),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            //   child: Row(
            //     children: <Widget>[
            //       Radio(
            //         value: "buy",
            //         activeColor: Colors.blue,
            //         groupValue: _buyRentValue,
            //         onChanged: (value) => setState(
            //           () => _buyRentValue = value,
            //         ),
            //       ),
            //       Text(
            //         "Buy",
            //         style: TextStyle(fontWeight: FontWeight.w600),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   child: _buyRentValue == "rent"
            //       ? Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 8.0, vertical: 8.0),
            //           child: Text(
            //             "number of days",
            //             style: TextStyle(
            //                 fontSize: 16.0, color: Colors.grey.shade600),
            //           ),
            //         )
            //       : Container(),
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade200,
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            // ),
            addVerticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Total : "),
                Text(
                  "${material.price['selling']} ETB",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: FlatButton(
                  onPressed: () {
                    MyRouter.pushPage(context, PaymentPage());
                  },
                  child: Text(
                    "Continue to payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
