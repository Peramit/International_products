class Transactions {
  int? keyID;
  final String title;
  final String title1;
  final String title2;
  final String title3;
  final int amount;
  final DateTime date;

  Transactions({
    this.keyID,
    required this.title,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.amount,
    required this.date,
  });
}