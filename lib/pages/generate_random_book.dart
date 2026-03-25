import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynextread/MainScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';

import 'package:mynextread/model/book.dart';

class GenerateRandomBook extends StatefulWidget{
  const GenerateRandomBook({super.key});

  @override
  State<GenerateRandomBook> createState() => _GenerateRandomBook();
}

class _GenerateRandomBook extends State<GenerateRandomBook>{
  Book? _selectedBook;

  void _spin(Box<Book> box){
    setState(() {
      var bookBox = Hive.box<Book>('myBooks');

      List<Book> wishlist = bookBox.values.where((book) => book.readingStatus == 'wantToRead').toList();

      if(wishlist.isNotEmpty){
        setState(() {
          _selectedBook = wishlist[Random().nextInt(wishlist.length)];
        });
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your TBR list is empty'))
        );
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 500,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    )
                  );
                },
                icon: Icon(Icons.arrow_back)
            ),
            Text('Pick Next Book'),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.settings)
            )
          ],
        ),
      ),
      body:
        ValueListenableBuilder(
          valueListenable: Hive.box<Book>('myBooks').listenable(),
          builder: (context, Box<Book> box, _){
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: Color(0xFFF1C6D6),
              ),
              child: Column(
                children: [
                  Text("What's your next adventure?",
                    style: TextStyle(
                      fontSize: 36,
                      color: Color.fromRGBO(17, 25, 37, 1),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text("Can't decide? Let us decide for you.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  DottedBorder(
                    color: Colors.red.withValues(alpha: 0.65),
                    strokeWidth: 2,
                    dashPattern: [6,3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(30),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      width: 350,
                      height: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.pink.shade50.withValues(alpha: 0.5),
                            Colors.white,
                            Colors.pink.shade50.withValues(alpha: 0.3)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.pink.shade100.withValues(alpha: 0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10)
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.menu_book,
                              size: 50,
                              color: Color(0xFFE9666E),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Mystery Book',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A233E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Tap below to reveal a random treasure from your "To Be Read" list.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5E6A81),
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Column(
                            children: [
                              if (_selectedBook != null) ...[
                                // Image.network(_selectedBook!.thumbnail),
                                Text(_selectedBook!.title, style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)
                                )
                              ] else
                                const Text("Ready to pick a random read?")
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => _spin(box),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEE6D78),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                              shadowColor: const Color(0xFFEE6D78).withValues(alpha: 0.5),
                            ),
                            child: Text(_selectedBook == null ?
                              'Pick for me' :  'Spin Again',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 40),
                ],
              ),
            );
          }
        )
    );
  }
}