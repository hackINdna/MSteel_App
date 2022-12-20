// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class PipeDataWidget extends StatelessWidget {
  final String pipeSize, pipeName;
  final List<PipeSpecs> pipeSpecs;

  const PipeDataWidget({
    Key? key,
    required this.pipeSize,
    required this.pipeName,
    required this.pipeSpecs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Widget _cell(
      String content, {
      bool header = false,
      bool footer = false,
    }) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight:
                  (header || footer) ? FontWeight.w700 : FontWeight.w500,
              fontSize: 12.3),
        ),
      );
    }

    List<TableRow> _tableRows(List<PipeSpecs> pipeSpecList) {
      double qty1Sum = 0, qty2Sum = 0;
      //list with header row added in first place
      List<TableRow> rows = [
        TableRow(children: [
          _cell(transText(context).thickness, header: true),
          _cell(transText(context).weightPerPes, header: true),
          _cell("32 OD Qty.\n(${transText(context).roundPipe})", header: true),
          _cell("25x25 Qty.\n(${transText(context).squarePipe})", header: true),
        ]),
      ];
      //populating rows list with data at provided index
      for (var pipeSpecs in pipeSpecList) {
        var rowCells = [
          _cell(pipeSpecs.thickness),
          _cell(pipeSpecs.wpp),
          _cell(pipeSpecs.qty1 == null ? "" : pipeSpecs.qty1.toString()),
          _cell(pipeSpecs.qty2 == null ? "" : pipeSpecs.qty2.toString()),
        ];
        rows.add(TableRow(children: rowCells));
        qty1Sum += pipeSpecs.qty1 ?? 0;
        qty2Sum += pipeSpecs.qty2 ?? 0;
      }
      //adding footer row
      rows.add(TableRow(children: [
        _cell(transText(context).total, footer: true),
        _cell(""),
        _cell(qty1Sum.toString(), footer: true),
        _cell(qty2Sum.toString(), footer: true),
      ]));
      return rows;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 17),
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
              TextButton(
                  onPressed: () {
                    print("swipe left");
                  },
                  child: const Text(
                    "swipe left",
                    style: TextStyle(fontSize: 9.3, color: Colors.white),
                  ))
            ],
          ),
        ),
        const SizedBox(height: 17),
        Table(
          defaultColumnWidth: FixedColumnWidth(screenSize.width * 0.24),
          children: _tableRows(pipeSpecs),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
