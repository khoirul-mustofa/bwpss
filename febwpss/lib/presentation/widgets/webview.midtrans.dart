// import 'package:flutter/material.dart';

// import 'package:midtrans_sdk/midtrans_sdk.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// class WebViewMidtrans extends StatefulWidget {
//   const WebViewMidtrans({super.key});

//   @override
//   _WebViewMidtransState createState() => _WebViewMidtransState();
// }

// class _WebViewMidtransState extends State<WebViewMidtrans> {
//   MidtransSDK? _midtrans;

//   @override
//   void initState() {
//     super.initState();
//     initSDK();
//   }

//   void initSDK() async {
//     _midtrans = await MidtransSDK.init(
//       config: MidtransConfig(
//         clientKey: DotEnv.DotEnv().env['MIDTRANS_CLIENT_KEY'] ?? "",
//         merchantBaseUrl:
//             DotEnv.DotEnv().env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
//         colorTheme: ColorTheme(
//           colorPrimary: Theme.of(context).colorScheme.secondary,
//           colorPrimaryDark: Theme.of(context).colorScheme.secondary,
//           colorSecondary: Theme.of(context).colorScheme.secondary,
//         ),
//       ),
//     );
//     _midtrans?.setUIKitCustomSetting(
//       skipCustomerDetailsPages: true,
//     );
//     _midtrans!.setTransactionFinishedCallback((result) {
//       print(result.toJson());
//     });
//   }

//   @override
//   void dispose() {
//     _midtrans?.removeTransactionFinishedCallback();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             child: const Text("Pay Now"),
//             onPressed: () async {
//               _midtrans?.startPaymentUiFlow(
//                 token: DotEnv.DotEnv().env['SNAP_TOKEN'],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
