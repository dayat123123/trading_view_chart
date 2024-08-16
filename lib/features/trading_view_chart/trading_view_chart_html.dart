import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TradingViewChartHtml extends StatefulWidget {
  const TradingViewChartHtml({super.key});

  @override
  State<TradingViewChartHtml> createState() => _TradingViewChartHtmlState();
}

class _TradingViewChartHtmlState extends State<TradingViewChartHtml> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TradingView Chart')),
      body: InAppWebView(
        onConsoleMessage: (controller, consoleMessage) {
          print("Console Message: ${consoleMessage.message}");
        },
        initialData: InAppWebViewInitialData(
          data: tradingViewHtml,
          mimeType: 'text/html',
          encoding: 'utf-8',
        ),
        onWebViewCreated: (controller) async {
          webViewController = controller;
          // Menambahkan JavaScript Handler
          controller.addJavaScriptHandler(
            handlerName: 'printMessage',
            callback: (args) {
              print("Message from JavaScript: ${args[0]}");
            },
          );
        },
        onLoadStop: (controller, url) async {
          // Memanggil handler dari JavaScript setelah halaman selesai dimuat
          await controller.evaluateJavascript(
            source:
                "window.flutter_inappwebview.callHandler('printMessage', 'Hello from WebView!');",
          );
        },
      ),
    );
  }
}

const String tradingViewHtml = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TradingView Widget with Transparent Background</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      width: 100%;
      overflow: hidden;
    }

    #tradingview_widget {
      height: 100%;
      width: 100%;
      background-color: rgba(255, 255, 255, 0); /* Transparan */
    }

    .tradingview-widget-container {
      height: 100%;
      width: 100%;
      background: rgba(255, 255, 255, 0) !important; /* Transparan */
    }

    .tradingview-widget-container__widget {
      height: 100%;
      width: 100%;
      background: rgba(255, 255, 255, 0) !important; /* Transparan */
    }
  </style>
</head>
<body>
  <div id="tradingview_widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
    function sendMessageToFlutter(symbol) {
      // Pastikan handler JavaScript dipanggil dengan benar
      if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
        console.log('Sending message to Flutter: Symbol changed: ' + symbol);
        window.flutter_inappwebview.callHandler('printMessage', 'Symbol changed: ' + symbol);
      } else {
        console.error('Flutter InAppWebView handler is not defined');
      }
    }

    new TradingView.widget({
      "width": "100%",
      "height": "100%",
      "symbol": "IDX:GOTO",
      "interval": "D",
      "timezone": "Etc/UTC",
      "theme": "light",
      "style": "1",
      "locale": "en",
      "hide_top_toolbar": false,
      "toolbar_bg": "#f1f3f6",
      "enable_publishing": false,
      "withdateranges": true,
      "hide_side_toolbar": true,
      "allow_symbol_change": true,
      "details": true,
      "hotlist": true,
      "calendar": true,
      "withdateranges": false,
      "hide_volume": true,
      "news": ["headlines"],
      "container_id": "tradingview_widget",

      // Callback ketika simbol berubah
      "onSymbolChange": function(symbol) {
        console.log('Symbol changed in TradingView widget: ' + symbol);
        sendMessageToFlutter(symbol);
      }
    });
  </script>
</body>
</html>

''';
