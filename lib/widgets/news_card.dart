import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/themes/constants.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final Color cardColor;
  final VoidCallback onReadMore;

  const NewsCard({
    super.key,
    required this.news,
    required this.cardColor,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                news.title ?? '',
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Text(
                formatTimestamp(news.timestamp ?? ''),
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              news.images?.thumbnail != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        news.images?.thumbnail ?? '',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  news.snippet ?? '',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onReadMore,
                  child: Text(
                    "Read More",
                    style: TextStyle(
                      color: primaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTimestamp(String timestamp) {
  final int milliseconds = int.tryParse(timestamp) ?? 0;
  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
  final localDateTime = dateTime.toLocal();
  final formatter = DateFormat('dd-MMM-yyyy hh:mm a');
  return formatter.format(localDateTime);
}
