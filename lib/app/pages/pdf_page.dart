import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewPdfPage extends StatefulWidget {
  final String pdfUrl;

  const ViewPdfPage(this.pdfUrl);

  @override
  _ViewPdfPageState createState() => _ViewPdfPageState();
}

class _ViewPdfPageState extends State<ViewPdfPage> {
  @override
  void initState() {
    print(widget.pdfUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// class ViewPdfPage extends StatefulWidget {
//   static final String routeName = 'viewPdf';
//   final String pdfUrl;

//   const ViewPdfPage(this.pdfUrl);

//   @override
//   State<StatefulWidget> createState() {
//     return _ViewPdfPageState();
//   }
// }

// class _ViewPdfPageState extends State<ViewPdfPage> {
//   _ViewPdfPageState();

//   // PDFDocument document;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   // bool _isLoading = true;
//   // final _key = UniqueKey();

//   @override
//   void initState() {
//     super.initState();
//     // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//     // loadDocument();
//   }

//   loadDocument() async {
//     // document = await PDFDocument.fromURL(widget.pdfUrl);

//     // setState(() => _isLoading = false);
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16.0),
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Container(
//               // child: _isLoading
//               //     ? Center(child: CircularProgressIndicator())
//               //     : Container(
//               // PDFViewer(
//               //     document: document,
//               //     zoomSteps: 1,
//               //uncomment below line to preload all pages
//               // lazyLoad: false,
//               // uncomment below line to scroll vertically
//               // scrollDirection: Axis.vertical,

//               //uncomment below code to replace bottom navigation with your own
//               /* navigationBuilder:
//                       (context, page, totalPages, jumpToPage, animateToPage) {
//                     return ButtonBar(
//                       alignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(Icons.first_page),
//                           onPressed: () {
//                             jumpToPage()(page: 0);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             animateToPage(page: page - 2);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward),
//                           onPressed: () {
//                             animateToPage(page: page);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.last_page),
//                           onPressed: () {
//                             jumpToPage(page: totalPages - 1);
//                           },
//                         ),
//                       ],
//                     );
//                   }, */
//               ),
//         ),
//       ),
//     );
//   }
// }
