import 'package:flutter/material.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class StockStatementScreen extends StatefulWidget {
  const StockStatementScreen({super.key});
  static const routeName = "/stockStatements";

  @override
  State<StockStatementScreen> createState() => _StockStatementScreenState();
}

class _StockStatementScreenState extends State<StockStatementScreen> {
  @override
  Widget build(BuildContext context) {
    return RootColumn(
      heading: transText(context).stockStatements,
      children: [],
    );
  }
}
