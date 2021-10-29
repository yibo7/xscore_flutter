

import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:xscore/eventbus/bus_event.dart';
import 'package:xscore/routers/RMethods.dart';
class QrScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.red,),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          backgroundColor: Colors.black, //primary_button_color
          tooltip: "返回",
          child: Icon(Icons.keyboard_return),
        ),
        body:ScanView(
          scanAreaScale: .7,
          scanLineColor: Colors.green.shade400,
          onCapture: (data) {
            ApplicationEvent.send(QrScanEvent(data));
            RMethods.pop(context);
          },
        )
    );

  }
}
class QrScanEvent {
  String data;
  QrScanEvent(this.data);

}