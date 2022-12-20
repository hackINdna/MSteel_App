import 'package:flutter/material.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/pipe_data_box.dart';
import 'package:m_steel/widgets/search_box.dart';

class StockStatementScreen extends StatefulWidget {
  const StockStatementScreen({super.key});
  static const routeName = "/stockStatements";

  @override
  State<StockStatementScreen> createState() => _StockStatementScreenState();
}

class _StockStatementScreenState extends State<StockStatementScreen> {
  var pipeDetailsList = getpipeDetails();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var searchController = TextEditingController();
    return RootColumn(
      screenPadding: const EdgeInsets.symmetric(vertical: 20),
      heading: transText(context).stockStatements,
      children: [
        SearchTextField(onChanged: (p0) {}, controller: searchController),
        const SizedBox(height: 60),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => PipeDataWidget(
            pipeSize: pipeDetailsList[index].pipeSize,
            pipeName: pipeDetailsList[index].pipeName,
            pipeSpecs: pipeDetailsList[index].specs,
          ),
          itemCount: pipeDetailsList.length,
        )
      ],
    );
  }
}
