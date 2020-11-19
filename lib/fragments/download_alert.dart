import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'custom_alert.dart';

class DownloadAlert extends StatefulWidget {
  final MaterialDetail material;
  final String downloadPath;

  DownloadAlert({Key key, @required this.material, @required this.downloadPath})
      : super(key: key);

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {
  final dio = new Dio();

  int received = 0;
  String progress = '0';

  void download() async {
    final fileSize = widget.material.file['size'];
    final fileurl = Api.baseUrl + widget.material.file['url'];

    await dio.download(
      fileurl,
      widget.downloadPath,
      deleteOnError: true,
      onReceiveProgress: (receivedBytes, totalBytes) async {
        setState(() {
          received = receivedBytes;
          progress = (received / fileSize * 100).toStringAsFixed(0);
        });

        //Check if download is complete and close the alert dialog
        if (receivedBytes == fileSize) {
          Navigator.pop(context, '${Helpers.formatBytes(fileSize, 1)}');
        }
      },
    ).catchError((err) => print(err));
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    final fileSize = widget.material.file['size'];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Downloading...',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.0),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: double.parse(progress) / 100.0,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$progress %',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${Helpers.formatBytes(received, 1)} '
                    'of ${Helpers.formatBytes(fileSize, 1)}',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
