import 'package:web/web.dart' as web;
import 'dart:js_interop';

void downloadFile(String content, String fileName) {
  final blob = web.Blob([content.toJS].toJS);
  final url = web.URL.createObjectURL(blob);
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = fileName;
  anchor.click();
  web.URL.revokeObjectURL(url);
}
