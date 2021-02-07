import 'dart:async';
import 'dart:io';
import 'package:education/ui/navigation_bar/navigationBar.dart';
import 'package:education/ui/navigation_bar/navigationbar_model.dart';
import 'package:education/ui/webview_page/webview_page_services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:education/models/User.dart' as usr;
import 'package:education/models/Student.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  final String title;
  final int bagis;
  final usr.User user;
  final Student student;

  WebviewPage(this.url, this.title, this.bagis, this.student, this.user);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final WebviewPageServices _webviewPageServices = WebviewPageServices();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF25F1AE),
        title: Text(widget.title),
        actions: [
          FlatButton(
              child: Text(
                'Tamamlandı',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var result = await _webviewPageServices.addDonation(
                    widget.user, widget.student, widget.bagis);
                if (result) {
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                  bottomNavBarSelectedIndex = 2;
                }
              })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
