import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

// void main() {
//      final WebSocketLink _webSocketLink = WebSocketLink(
//       'ws://localhost:8000/graphql/',
//       config: const SocketClientConfig(
//         autoReconnect: true,
//       ),
//     );
//     final wsUrl = Uri.parse('ws://localhost:1234');
//     var channel = WebSocketChannel.connect(wsUrl);

//   channel.stream.listen((message) {
//     channel.sink.add('received!');
//     channel.sink.close(status.goingAway);
//   });
  
//   runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyDemo()));
// }

// class MyDemo extends StatefulWidget {
//   const MyDemo({super.key});

//   @override
//   State<MyDemo> createState() => _MyDemoState();
// }

// class _MyDemoState extends State<MyDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Subscriptions'),
//       ),
//     );
//   }
// }
