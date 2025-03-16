import 'package:flutter/material.dart';
import 'listmenu.dart';

class DetailNewsPage extends StatefulWidget {
  final NewsModel news;

  const DetailNewsPage({Key? key, required this.news}) : super(key: key);

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        widget.news.likes++;
      } else {
        widget.news.likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.news.image, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              widget.news.title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.news.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _toggleLike,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 18,
                            color:
                                isLiked
                                    ? Colors.red
                                    : const Color.fromARGB(255, 107, 107, 107),
                          ),
                          SizedBox(width: 8),
                          Text('${widget.news.likes} likes'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
