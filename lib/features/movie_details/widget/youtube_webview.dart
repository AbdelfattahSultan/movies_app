import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebView extends StatefulWidget {
  final String trailerCode;

  const YoutubeWebView({super.key, required this.trailerCode});

  @override
  State<YoutubeWebView> createState() => _YoutubeWebViewState();
}

class _YoutubeWebViewState extends State<YoutubeWebView> {
  late final WebViewController controller;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    final youtubeUrl = "https://www.youtube.com/watch?v=${widget.trailerCode}";

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            setState(() {
              progress = value / 100;
            });
          },
          onPageStarted: (_) {
            setState(() => progress = 0);
          },
        ),
      )
      ..loadRequest(Uri.parse(youtubeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(elevation: 0),

      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: controller),

          // Loading Progress Bar
          if (progress < 1)
            LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              color: Colors.red,
              backgroundColor: Colors.white24,
            ),
        ],
      ),
    );
  }
}
