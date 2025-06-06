import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TMDBWebViewPage extends StatefulWidget {
  final String requestToken;
  static const id = 'TMDB_web_view';

  const TMDBWebViewPage({super.key, required this.requestToken});

  @override
  State<TMDBWebViewPage> createState() => _TMDBWebViewPageState();
}

class _TMDBWebViewPageState extends State<TMDBWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            'https://www.themoviedb.org/authenticate/${widget.requestToken}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
