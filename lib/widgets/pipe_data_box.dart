// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class PipeDataWidget extends StatelessWidget {
  final String pipeSize, pipeName;
  // final List<PipeSpecs> pipeSpecs;
  final List<Map<String, dynamic>> fields;

  const PipeDataWidget({
    Key? key,
    required this.pipeName,
    required this.fields,
    required this.pipeSize,
  }) : super(key: key);
  String reduceNumberSize(double numb) {
    var str = numb.toString();
    var digitsBeforeDecimal = str.lastIndexOf(".");
    if (digitsBeforeDecimal == -1) {
      return numb.toStringAsFixed(1);
    } else if (digitsBeforeDecimal <= 1) {
      return numb.toStringAsFixed(2);
    } else if (digitsBeforeDecimal <= 2) {
      return numb.toStringAsFixed(3);
    } else {
      return numb.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<double> totalList;
    //assuming first two columns to always be fixed string type thickness & WeightPerPes., whose sum is never required
    int noOfColumns = 2;
    var _scrollController = ScrollController();
    var screenSize = MediaQuery.of(context).size;
    Widget _cell(
      String content, {
      bool header = false,
      bool footer = false,
      TextAlign align = TextAlign.center,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          content,
          textAlign: align,
          style: TextStyle(
            fontWeight: (header || footer) ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12.3,
          ),
        ),
      );
    }

    List<TableRow> tableRows(List<Map<String, dynamic>> fields) {
      noOfColumns = fields.first.length;

      //assuming first two columns to always be fixed string type thickness & WeightPerPes., whose sum is never required
      totalList = List.filled(noOfColumns - 2, 0.0);
      //list with header row added in first place
      List<TableRow> rows = [];
      List<Widget> headerRow = [];
      for (var title in fields.first.keys) {
        headerRow.add(_cell(title, header: true));
      }
      rows.add(TableRow(children: headerRow));
      //populating rows list with data
      for (var rowMap in fields) {
        var currIndex = 0;
        var rowCells = <Widget>[];
        rowCells.addAll(rowMap.values.map((value) {
          if (currIndex > 1) {
            totalList[currIndex - 2] += double.tryParse(value.toString()) ?? 0;
          }
          currIndex++;
          // continue;
          return _cell(value == 0 ? "" : value.toString());
        }).toList());
        rows.add(TableRow(children: rowCells));
      }
      //adding footer row
      var footerRow = <Widget>[
        _cell(
          transText(context).total,
          footer: true,
        ),
        _cell("", footer: true),
      ];
      footerRow.addAll(totalList
          .map((total) => _cell(reduceNumberSize(total), footer: true))
          .toList());
      rows.add(TableRow(children: footerRow));
      return rows;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
          decoration: const BoxDecoration(
            color: appBlueBg,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$pipeSize $pipeName",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white),
              ),
              //swipe left button
              // TextButton(
              //   onPressed: () {
              //     _scrollController.animateTo(
              //       _scrollController.position.maxScrollExtent,
              //       duration: const Duration(milliseconds: 500),
              //       curve: Curves.decelerate,
              //     );
              //   },
              //   child: const Text(
              //     "swipe left",
              //     style: TextStyle(fontSize: 9.3, color: Colors.white),
              //   ),
              // )
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(screenSize.width * 0.25),
            children: tableRows(fields),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
