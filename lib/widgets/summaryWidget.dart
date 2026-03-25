import 'package:flutter/material.dart';
import 'package:mynextread/services/storage_service.dart';
import 'package:mynextread/widgets/summaryCard.dart';

class SummaryWidget extends StatefulWidget{
  const SummaryWidget({super.key});

  @override
  State<SummaryWidget> createState() => _SummaryWidget();
}
class _SummaryWidget extends State<SummaryWidget> {
  final StorageService storageService = StorageService();
  int pages = 0;
  int readTime = 4;

  @override
  void initState(){
    super.initState();
    loadPages();
  }

  Future<void> loadPages() async{
    final savedPages = await storageService.getDailyGoal();
    final time = await storageService.getReadingTime();

    setState((){
      pages = savedPages;
      readTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical:8.0),
      child: Column(
        children: [
          Text('Summary', 
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Serif',
              fontSize: 32,
              color: Color(0xFF0F172A),
            )
          ),
          Row(
            children: [
              SummaryCard(
                icon: Icons.timer,
                value: '$readTime',
                unit: 'min',
                label: 'Reading Time',
              ),
              SizedBox(width: 20),
              SummaryCard(
                icon: Icons.menu_book,
                value: '$pages',
                unit: 'pages',
                label: 'Pages Read',
              ),
            ],
          ),
        ],
      ),
    );
  }
}