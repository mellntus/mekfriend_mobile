class Post {
  final String id;
  final String name;
  final String date;
  final String imageUrl;
  final String content;
  final int likeCount;
  final int commentCount;

  Post({
    required this.id,
    required this.name,
    required this.date,
    this.imageUrl = "https://avatars.githubusercontent.com/u/57880863?v=4",
    required this.content,
    required this.likeCount,
    required this.commentCount});
}