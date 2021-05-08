import 'dart:io';

import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventWebView extends StatefulWidget {
  final String link;

  EventWebView({this.link});

  @override
  _EventWebViewState createState() => _EventWebViewState();
}

class _EventWebViewState extends State<EventWebView> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData().copyWith(color: Colors.black),
        title: TextComponent(
          title: widget.link,
          fontSize: 16,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: WebView(
          initialUrl: widget.link,
        ),
      ),
    );
  }
}
