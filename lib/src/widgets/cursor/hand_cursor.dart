import 'dart:html' as html;
import 'package:flutter/material.dart';

class HandCursor extends MouseRegion {
  // Don't forget to put the id 'app-container' on body tag of the index.html file
  static final appContainer = html.window.document.getElementById('app-container');
  HandCursor({Widget child}) : super(
    onHover: (event) {
      appContainer.style.cursor='pointer';
    },
    onExit: (event) {
      appContainer.style.cursor='default';
    },
    child: child
  );
}