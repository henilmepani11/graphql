import 'package:ferry/ferry.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Client initClient() {
  final httpLink = HttpLink("https://spacex-production.up.railway.app/");

  final WebSocketLink webSocketLink = WebSocketLink(
    'ws://spacex-production.up.railway.app/',
    config: const SocketClientConfig(
      autoReconnect: true,
    ),
  );

  final myClientLink =
      Link.split((request) => request.isSubscription, webSocketLink, httpLink);

  final client = Client(link: myClientLink);

  return client;
}
