import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: Image.asset(
                          'assets/images/warandpeace.jpg',
                          height: 200.0,
                          fit: BoxFit.cover,
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(13),
                            child: Text(
                              "Meleyayet Mot New",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )),
                        Text("By Alemayehu Gelagay",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300))
                      ],
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Choose Purchase Option",
                  style: TextStyle(fontSize: 17),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: "buy",
                      activeColor: Colors.blue,
                      onChanged: (val) {},
                    ),
                    Text(
                      "Buy",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: "rent",
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        // setState(() {
                        //   _character = value;
                        // });
                      },
                    ),
                    Text(
                      "Rent",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                )),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Text(
                  "number of days",
                  style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
                ),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("total : "),
                Text(
                  "34 ETB",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Finish Purchase",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
