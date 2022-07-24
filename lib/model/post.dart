class Post {
  final String id;
  final String uid;
  final String name;
  final String date;
  final String imageUrl;
  final String content;
  final String likeCount;
  final String commentCount;

  Post({
    required this.id,
    required this.uid,
    required this.name,
    required this.date,
    required this.imageUrl,
    required this.content,
    required this.likeCount,
    required this.commentCount
  });
}