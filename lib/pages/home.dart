import 'package:flutter/material.dart';
import 'package:mynextread/widgets/streakCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mynextread/widgets/barcode_screen.dart';
import '../widgets/timer_widget.dart';
import 'package:mynextread/model/book.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookFetchResult {
  final Map<String, String>? bookData;
  final String? errorMessage;

  BookFetchResult({this.bookData, this.errorMessage});
}

Future<BookFetchResult> fetchBookInfo(String isbn) async{
  final cleanedIsbn = isbn.replaceAll(RegExp(r'[^0-9Xx]'), '');
  try{
    final url = Uri.parse('https://openlibrary.org/api/books?bibkeys=ISBN:$cleanedIsbn&format=json&jscmd=data');
    final response = await http.get(url);

    print('Open Library status: ${response.statusCode}');
    print('Open Library body: ${response.body}');

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final key = 'ISBN:$cleanedIsbn';

      if (data[key] != null) {
        final book = data[key];

        return BookFetchResult(
          bookData: {
            'title': book['title'] ?? 'Unknown Title',
            'authors': (book['authors'] as List?)
                ?.map((a) => a['name'] as String)
                .join(', ') ??
                'Unknown Authors',
            'thumbnail': 'https://covers.openlibrary.org/b/isbn/$cleanedIsbn-M.jpg',
          },
        );
      }
    }

    return BookFetchResult(
      errorMessage: 'No book details found!'
    );
  } catch(e){
    print('Error fetching book: $e');
    return BookFetchResult(
      errorMessage: 'Error fetching book details',
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Center(
            child: Column(
              children: [
                StreakWidget(),
                const SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to the scanner and wait for the barcode string
                    final String? scannedCode = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
                    );
                    if (scannedCode != null) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (c) => Center(
                            child: CircularProgressIndicator(),
                          )
                      );

                      // fetch data from API
                      final cleanedCode = scannedCode.replaceAll(RegExp(r'[^0-9Xx]'), '');
                      // final bookData = await fetchBookInfo(cleanedCode);
                      final result = await fetchBookInfo(cleanedCode);

                      if (!context.mounted) return;
                      Navigator.pop(context);

                      if(result.bookData != null){
                        final box = Hive.box<Book>('myBooks');

                        final alreadyExists = box.values.any((book) => book.isbn == cleanedCode);
                        if (alreadyExists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Book already exist in you library')),
                          );
                          return;
                        }

                        final newBook = Book(
                            isbn: cleanedCode,
                            title: result.bookData!['title']!,
                            authors: result.bookData!['authors'] ?? 'Unknown Authors',
                            thumbnail: result.bookData!['thumbnail'] ?? '',
                            readingStatus: 'wantToRead',
                            dateAdded: DateTime.now()
                        );

                        await box.add(newBook);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${newBook.title} added successfully!")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.errorMessage ?? "Book details not found!")),
                        );
                      }
                    }
                  },
                  child: const Text('Scan & Add Book'),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Stack(
                      children:[
                        Positioned(
                          top: -30,
                            child: Opacity(
                              opacity:0.1,
                              child: Icon(
                                Icons.format_quote,
                                size: 90,
                              )
                            )
                        ),
                        Text('A book is a gift you can open again and again.',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text('- Garrison Keillor',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      )
                    )
                  ],
                ),
                const SizedBox(height: 40),
                TimerWidget(),
                // ElevatedButton(
                //     onPressed: (){
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => LibraryTabs())
                //       );
                //     },
                //     child: Text('Go to Library')
                // ),
                // ElevatedButton(
                //     onPressed: (){
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => ProfileWidget())
                //       );
                //     },
                //     child: Text('Go to Library')
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget allBooks(){
  //   return ValueListenableBuilder(
  //     valueListenable: Hive.box<Book>('myBooks').listenable(),
  //     builder: (context, Box<Book> box, _){
  //       if(box.isEmpty){
  //         return const Center(
  //           child: Padding(
  //             padding: EdgeInsets.all(20),
  //             child:  Text("No Books added yet"),
  //           )
  //         );
  //       }
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: box.length,
  //         itemBuilder: (context, index){
  //           final book = box.getAt(index);
  //           return ListTile(
  //             leading: Icon(Icons.book),
  //             title: Text(book?.title ?? "Unknown"),
  //             subtitle: Text('ISBN: ${book?.isbn}'),
  //             trailing: IconButton(
  //                 onPressed: (){},
  //                 icon: Icon(Icons.delete)),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
