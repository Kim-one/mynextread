import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/book.dart';

class StorageService {
  static const String _bookBoxName = 'books';
  static const String _readingStreakKey = 'reading_streak';
  static const String _lastReadDateKey = 'last_read_date';
  static const String _pagesRead = 'daily_goal';
  static const String _timeRead = 'time_read';

  Box<Book> get _bookBox => Hive.box<Book>(_bookBoxName);

  List<Book> getAllBooks(){
    return _bookBox.values.toList();
  }

  Future<void> addBook(Book book) async{
    await _bookBox.add(book);
  }

  Future<int> getReadingStreak() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_readingStreakKey) ?? 0;
  }

  Future<void> setReadingStreak(int streak) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_readingStreakKey, streak);
  }
  Future<String?> getLastReadDay() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastReadDateKey);
  }

  Future<void> setLastReadDay(String date) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastReadDateKey, date);
  }
  Future<int> getDailyGoal() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_pagesRead) ?? 10;
  }

  Future<void> setDailyGoal(int pages) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pagesRead, pages);
  }
  Future<int> getReadingTime() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_timeRead) ?? 30;
  }

  Future<void> setReadingTime(int time) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_timeRead, time);
  }

  String _formatDate(DateTime date){
    return DateTime(date.year, date.month, date.day).toIso8601String();
  }

  Future<void> updateBookStatus(Book book, String newStatus) async {
    book.readingStatus = newStatus;
    await book.save();
  }
}