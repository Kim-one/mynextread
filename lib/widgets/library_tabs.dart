import 'package:flutter/material.dart';
import 'package:mynextread/widgets/book_shelf_widget.dart';

class LibraryTabs extends StatelessWidget{
  const LibraryTabs({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color: Color(0xFFFFFFFF),
        child: DefaultTabController(
            length: 3,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('My Cozy Library', style: TextStyle(fontSize: 32),),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                          color: const Color(0xFFE57373),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xFF5E6A81),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      tabs: const [
                        Tab(
                          text: ('My Shelf'),
                        ),
                        Tab(
                          text: ('Wishlist'),
                        ),
                        Tab(
                          text: ('Finished'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                    child: TabBarView(
                      children: [
                        MyBookShelf(),
                        MyBookShelf(statusFilter: 'wantToRead'),
                        MyBookShelf(statusFilter: 'finishedReading')
                      ],
                    )
                )
              ],
            )
        ),
    );
  }
}