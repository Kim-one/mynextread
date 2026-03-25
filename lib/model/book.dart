import 'package:hive/hive.dart';
part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject{
  @HiveField(0)
  late String isbn;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late DateTime dateAdded;

  @HiveField(3)
  late String authors;

  @HiveField(4)
  late String thumbnail;

  @HiveField(5)
  late String? readingStatus;

  // @HiveField(1)
  // int currentPage;
  //
  // @HiveField(2)
  // int totalPages;


  Book({
    required this.isbn,
    required this.title,
    required this.dateAdded,
    required this.authors,
    required this.thumbnail,
    this.readingStatus,
    // required this.totalPages,
    // this.currentPage = 0,
  });

  // double get progress{
  //   if (totalPages == 0) return 0;
  //   return currentPage/totalPages;
  // }
}
