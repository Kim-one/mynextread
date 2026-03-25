import 'package:flutter/material.dart';
import 'package:mynextread/widgets/summaryWidget.dart';

class ProfileWidget extends StatelessWidget{
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Center(
          child: SummaryWidget()
    );
  }

}