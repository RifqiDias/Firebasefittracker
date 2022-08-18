import 'package:d_chart/d_chart.dart';
import 'package:firebasefittracker/provider/fire_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chart")),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (context) => FireProvider(),
        child: Consumer<FireProvider>(
          builder: (context, value, child) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: value.users.isNotEmpty
                  ? SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return AspectRatio(
                            aspectRatio: 16 / 9,
                            child: DChartLine(
                              data: [
                                {
                                  'id': 'Line',
                                  'data': [
                                    {'domain': value.users[index].born, 'measure': value.users[index].weight},
                                    {'measure': value.users[index].born, 'domain': value.users[index].weight},
                                  ]
                                },
                              ],
                              lineColor: (lineData, index, id) => Colors.amber,
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
        ),
      ),
    );
  }
}
