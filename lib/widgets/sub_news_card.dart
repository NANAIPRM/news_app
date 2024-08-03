import 'package:flutter/material.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/themes/constants.dart';
import 'package:test_kobkiat/widgets/news_card.dart';

class SubNewsCard extends StatelessWidget {
  final Subnews subNews;
  final Color cardColor;
  final VoidCallback onReadMore;

  const SubNewsCard({
    super.key,
    required this.subNews,
    required this.cardColor,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subNews.title ?? '',
              style: TextStyle(
                color: primaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text(
              formatTimestamp(subNews.timestamp ?? ''),
              style: TextStyle(
                color: primaryTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onReadMore,
                child: Text(
                  "Read More",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
