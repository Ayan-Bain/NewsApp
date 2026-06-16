import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;
  final VoidCallback onBack;

  const DetailScreen({
    super.key,
    required this.article,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final String relativeTime = article.publishedAt != null
        ? timeago.format(article.publishedAt!)
        : 'Unknown time';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'NewsApp',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 32.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: onBack,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: article.urlToImage != null && article.urlToImage!.isNotEmpty
                                ? Image.network(
                                    article.urlToImage!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[100],
                                        child: const Center(
                                          child: Icon(
                                            Icons.broken_image_outlined,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[100],
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        
                        Positioned(
                          top: 12.0,
                          left: 12.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              article.source.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        Positioned(
                          top: 12.0,
                          right: 12.0,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    
                    Text(
                      article.description ?? article.content ?? 'No content available.',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.6,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (article.content != null && article.description != null) ...[
                      Text(
                        article.content!,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24.0),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            article.author != null && article.author!.isNotEmpty
                                ? article.author!
                                : 'Unknown Author',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        Text(
                          relativeTime,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
