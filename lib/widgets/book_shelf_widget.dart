import 'package:flutter/material.dart';
import 'package:mynextread/pages/generate_random_book.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynextread/model/book.dart';

class MyBookShelf extends StatelessWidget{
  final String? statusFilter;
  const MyBookShelf({super.key, this.statusFilter});

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
        valueListenable: Hive.box<Book>('myBooks').listenable(),
        builder: (context, Box<Book> box, _){
          final allBooks = box.values.toList();
          final books = statusFilter == null ? allBooks : allBooks.where((book) => book.readingStatus == statusFilter).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOP SHELF',
                      style: TextStyle(
                        color: Color(0xFFE5ADAD),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEE7E7),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(
                          '${books.length} BOOKS',
                          style: const TextStyle(color: Color(0xFFE57373), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                if (books.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE7E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'No Books on your shelf yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFE57373),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(books.length, (index){
                        final book = books[index];

                        return _buildingBook(
                            book,
                            _getBookColor(index),
                            200,
                          // width: _getBookWidth(index)
                        );
                      }),
                    ),
                  ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _buildingBook('MOBY DICK', const Color(0xFFF29680), 180),
                //     _buildingBook('THE SECRET HISTORY', const Color(0xFFE57373), 230),
                //     _buildingBook('SAPIENS', const Color(0xFFD45D79), 170),
                //     _buildingBook('JANE EYRE', const Color(0xFFF9E8E8), 190, textColor: Color(0xFFD45D79)),
                //     _buildingBook('DUNE', const Color(0xFF1E293B), 200, width: 75),
                //   ],
                // ),
                const SizedBox(height: 5),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE7E7).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 30),
                // Text('CURRENTLY READING',
                //   style: TextStyle(color: Color(0xFFF29680), letterSpacing: 1.5, fontSize: 14, fontWeight: FontWeight.w900),
                // ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    // MyBookShelf(statusFilter: 'currentlyReading'),
                    // _buildingBook('CIRCLE', const Color(0xFFB8E3D4), 180, width: 70, textColor: Color(0xFF1B1313)),
                    // _buildingBook(, const Color(0xFFE3D8F1), 160, textColor: Color(0xFFAA3939)),
                    // SizedBox(width: 20),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       height: 12,
                    //       width: 128,
                    //       decoration: BoxDecoration(
                    //           color: Color(0xFFE8CACA),
                    //           borderRadius: BorderRadius.circular(10)
                    //       ),
                    //       padding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
                    //       child: FractionallySizedBox(
                    //         alignment: Alignment.centerLeft,
                    //         widthFactor: 0.65,
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: Colors.pink,
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           // margin: EdgeInsets.only(left: 2),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(height: 5),
                    //     Text('65% DONE',
                    //       style: TextStyle(
                    //           color: Color(0xFFE9636E),
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w900,
                    //           letterSpacing: 1.6),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE7E7).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => GenerateRandomBook(),
                        ),
                      );
                    },
                    child: Text('Your Next Read'),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildingBook(Book book, Color color, double height, {double width = 60, Color textColor = Colors.white}){
    return StatefulBuilder(
      builder: (context, setState){
        bool isTapped = false;
        return GestureDetector(
          onTapDown: (_) => setState(() => isTapped = true),
          onTapUp: (_) {
            setState(() => isTapped = false);
            _showBookDetails(context, book);
          },
          onTapCancel: ()=> setState(() => isTapped = false),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 1.0, end: 1.0),
            builder: (context, double scale, child){
              return Transform.scale(
                scale: scale,
                child: Transform.rotate(
                  angle: (scale - 1.0) * 0.1,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    child: Container(width: 6, height: 6, decoration: BoxDecoration(color: textColor.withValues(alpha: 0.3), shape: BoxShape.circle)),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      book.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Color _getBookColor(int index){
    final colors = [
      const Color(0xFFF29680),
      const Color(0xFFE57373),
      const Color(0xFFD45D79),
      const Color(0xFFF9E8E8),
      const Color(0xFF1E293B),
      const Color(0xFFB8E3D4),
      const Color(0xFFE3D8F1),
    ];

    return colors[index % colors.length];
  }

  // int _getBookHeight(int index) {
  //   final heights = [180, 230, 170, 190, 200, 160, 210];
  //   return heights[index % heights.length];
  // }
  //
  // int _getBookWidth(int index) {
  //   final widths = [60, 60, 60, 60, 75, 70, 65];
  //   return widths[index % widths.length];
  // }


}

Future<void> updateBookStatus(Book book, String newStatus) async {
  book.readingStatus = newStatus;
  await book.save();
}

void _showBookDetails(BuildContext context, Book book) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Allow custom shape to show
    builder: (context) {
      return Container(
        // height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              book.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
            ),
            Text(book.authors, style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 20),
            // const Text(
            //   "This is a brief description of the book. It looks wonderful on your shelf! Would you like to start reading it now?",
            //   style: TextStyle(fontSize: 16, height: 1.5),
            // ),
            const Text("Choose where you want to place this book."),
            const Spacer(),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateBookStatus(book, 'wantToRead');
                      if(context.mounted) Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: const Size(double.infinity, 46),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Want to Read", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateBookStatus(book, 'finishedReading');
                      if(context.mounted) Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: const Size(double.infinity, 46),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Finished", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateBookStatus(book, 'currentlyReading');
                      if(context.mounted) Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: const Size(double.infinity, 46),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Currently Reading", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}