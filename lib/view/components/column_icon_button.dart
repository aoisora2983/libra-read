import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';

// Iconの下にテキストが来るボタン
class ColumnIconButton extends StatelessWidget {
  const ColumnIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.callback,
    this.sortStatus,
  });

  final IconData icon;
  final String label;
  final dynamic callback;
  final int? sortStatus;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowList = [];
    rowList.add(Icon(size: 20, icon));
    if (sortStatus != null) {
      rowList.add(renderSortIcon());
    }

    List<Widget> columnList = [];
    columnList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowList,
      ),
    );
    if (label != '') {
      columnList.add(
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      );
    }

    return SizedBox(
      width: 60,
      height: 55,
      child: IconButton(
        onPressed: () {
          callback();
        },
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: columnList,
        ),
      ),
    );
  }

  Icon renderSortIcon() {
    Icon icon;
    switch (sortStatus) {
      case SortStatus.asc:
        icon = const Icon(size: 15, Icons.arrow_upward);
        break;
      case SortStatus.desc:
        icon = const Icon(size: 15, Icons.arrow_downward);
        break;
      case SortStatus.none:
      default:
        icon = const Icon(size: 15, Icons.import_export);
        break;
    }
    return icon;
  }
}
