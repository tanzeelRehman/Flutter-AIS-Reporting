import 'package:ais_reporting/features/leave/presentation/provider/leave_provider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/globals/globals.dart';

class SingleLeavereasonWidget extends StatelessWidget {
  LeaveProvider leaveProvider = sl();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
            value: leaveProvider.multipleLeaveSelected,
            onChanged: ((value) {
              leaveProvider.toogleMultipleLeaveSelected();
            }))
      ],
    );
  }
}
