import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_detail_screen.dart';
import 'news_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch news when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias MINERD'),
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsProvider.newsList.length,
              itemBuilder: (context, index) {
                final news = newsProvider.newsList[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading:
                        const Icon(Icons.article, color: Colors.blue, size: 40),
                    title: Text(news.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Toca para leer más',
                        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
                    trailing:
                        const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 230, 230, 230)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(news: news),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
