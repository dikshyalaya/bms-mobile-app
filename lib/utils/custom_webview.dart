import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final String title;
  const CustomWebView({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  WebViewController? _webViewController;
  bool isLoading = true;
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingProgress = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            _webViewController!
                .runJavaScriptReturningResult("function toMobile(){"
                    "var meta = document.createElement('meta'); "
                    "meta.setAttribute('name', 'viewport');"
                    " meta.setAttribute('content', 'width=device-width, initial-scale=1'); "
                    "var head= document.getElementsByTagName('head')[0];"
                    "head.appendChild(meta); "
                    "}"
                    "toMobile()")
                .then((_) {
              setState(() {
                isLoading = false;
              });
            });
          },
          onHttpError: (HttpResponseError error) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color(0xff4579FF),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const AppBarLeadingIcon(),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController ?? WebViewController()),
          if (isLoading)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.toDouble(),
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
