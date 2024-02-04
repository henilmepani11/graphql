import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mutations_612/client.dart';
import 'package:mutations_612/graphql/__generated__/data.data.gql.dart';
import 'package:mutations_612/graphql/__generated__/data.req.gql.dart';
import 'package:mutations_612/graphql/__generated__/schema.schema.gql.dart';
import 'package:mutations_612/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:mutations_612/graphql/__generated__/data.req.gql.dart';
import 'package:mutations_612/homepage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/status.dart' as status;

Client client = initClient();

void main() {
  initClient();
  final wsUrl = Uri.parse('ws://spacex-production.up.railway.app/');
  var channel = WebSocketChannel.connect(wsUrl);

  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int myOffset = 0;

  bool isMoreLoading = false;

  @override
  void initState() {
    fetchData(limit: 10, offset: myOffset);
    scrollController.addListener(() {
      loadMoreData();
    });
    super.initState();
  }

  fetchData({int? limit, int? offset}) {
    final dataRequest = GfetchDataReq((b) => b
      ..vars.limit = limit
      ..vars.offset = offset);

    client.request(dataRequest).listen((event) {
      dataList = (event.data?.launchesPast?.map((p0) => p0).toList() ?? []);
      isMoreLoading = false;
      setState(() {});
    });
  }

  final ScrollController scrollController = ScrollController();

  loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      setState(() {});
      if (isMoreLoading) {
        myOffset += 10;
        fetchData(limit: 10, offset: myOffset);
      }
      setState(() {});
    }
  }

  List<GfetchDataData_launchesPast?> dataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" "),
      ),
      body: dataList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()));
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(dataList[index]?.mission_name ?? ""),
                            subtitle: Text(dataList[index]?.launch_year ?? ""),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (isMoreLoading == true) ...[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                ]
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
