import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_detail_screen.dart';
import 'news_model.dart';
import 'news_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> _newsList = [];
  bool _isLoading = false;

  List<News> get newsList => _newsList;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await NewsService().fetchNews();
      print(data);

      setState(() {
        _newsList = data;
      });
    } catch (error) {
      // Handle error
      _newsList = [];
      print("Error: " + error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    //final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias MINERD'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
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
