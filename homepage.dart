import 'package:flutter/material.dart';
import 'package:mutations_612/client.dart';
import 'package:mutations_612/graphql/__generated__/data.data.gql.dart';
import 'package:mutations_612/graphql/__generated__/data.req.gql.dart';
import 'package:mutations_612/graphql/__generated__/schema.schema.gql.dart';
import 'package:mutations_612/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nameController = TextEditingController();

  // addData() {
  //   final dataRequest = GaddDataReq(
  //     (b) => b
  //       ..vars.objects = ListBuilder<Gusers_insert_input>(
  //         [
  //           Gusers_insert_input(
  //             (b) {
  //               return b..name = nameController.text;
  //             },
  //           ),
  //         ],
  //       ),
  //   );
  //   print(dataRequest);

  //   final client = initClient("https://spacex-production.up.railway.app/");

  //   var data = client.request(dataRequest).listen((event) {
  //     print(event.data?.insert_users?.returning);
  //     // print(event.graphqlErrors);
  //   });
  // }

  updateData() {
    Gusers_bool_expBuilder builder = Gusers_bool_expBuilder();

    /// comperesion mate ///
    // builder.id = Guuid_comparison_expBuilder()..G_eq = id;

    Gusers_set_inputBuilder gusers_set_inputBuilder = Gusers_set_inputBuilder();
    gusers_set_inputBuilder.name = "Hello";

    final dataRequest = GupdateMyDataReq((b) => b
      ..vars.where = builder
      ..vars.set = gusers_set_inputBuilder);

    client.request(dataRequest).listen((event) {
      print(event.graphqlErrors);
    });
  }

  deleteData() {
    Gusers_bool_expBuilder builder = Gusers_bool_expBuilder();

    /// comperesion mate ///
    // builder.id=Guuid_comparison_expBuilder()..G_eq=id;

    final dataRequest = GdeleteDataReq((b) => b..vars.where = builder);

    client.request(dataRequest).listen((event) {
      print(event.graphqlErrors);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("mutation"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter name",
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                updateData();
              },
              child: const Text("Update")),
          ElevatedButton(
              onPressed: () {
                deleteData();
              },
              child: const Text("Delete"))
        ],
      ),
    );
  }
}
