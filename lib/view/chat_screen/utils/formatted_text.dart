import 'dart:developer';

import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormattedText {
  static bool isEmoji(String text) {
    return emojiRegex().hasMatch(text);
  }

  static Widget build(String message, Color color) {
    final patterns = {
      RegExp(r'(?<!\S)_(.+?)_'): (String text) => TextSpan(
            text: text,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: color,
              fontSize: 17,
            ),
          ),
      RegExp(r'(?<!\S)\*([^*]+)\*'): (String text) => TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 17,
            ),
          ),
      RegExp(r'(?<!\S)~(.+?)~'): (String text) => TextSpan(
            text: text,
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: color,
              fontSize: 17,
            ),
          ),
      RegExp(r'(https?:\/\/[^\s]+)'): (String text) => TextSpan(
            text: text,
            style: TextStyle(
              color: color == Colors.white ? Colors.yellow : Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri.parse(text);
                log("Attempting to launch: $uri");
                try {
                  //if (await canLaunchUrl(uri)) {
                  log("Launching URL: $uri");
                  await launchUrl(uri,
                      mode: LaunchMode.externalApplication); // External launch
                  //} else {
                  //log("Cannot launch URL: $uri");
                  //}
                } catch (e) {
                  log("Error launching URL: $e");
                }
              },
          ),
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'):
          (String text) => TextSpan(
                text: text,
                style: TextStyle(
                  color: color == Colors.white ? Colors.yellow : Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final uri = Uri.parse(text);
                    log("Attempting to launch: $uri");
                    try {
                      final uri = Uri(scheme: 'mailto', path: text);
                      try {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } catch (e) {
                        log('Error launching URL: $e');
                      }
                    } catch (e) {
                      log("Error launching URL: $e");
                    }
                  },
              ),
      RegExp(r'\b(\d{10})\b'): (String text) => TextSpan(
            text: text,
            style: TextStyle(
              color: color == Colors.white ? Colors.yellow : Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri(scheme: 'tel', path: text);
                try {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    log('Could not launch $uri');
                  }
                } catch (e) {
                  log('Error launching URL: $e');
                }
              },
          ),
    };

    final List<InlineSpan> spans = [];
    int startIndex = 0;

    while (startIndex < message.length) {
      bool matched = false;

      for (final pattern in patterns.keys) {
        final match = pattern.matchAsPrefix(message.substring(startIndex));

        if (match != null) {
          final matchedGroup = /*(match.input.startsWith('_') &&
                      match.input.endsWith('_')) ||
                  (match.input.startsWith('*') && match.input.endsWith('*')) ||
                  (match.input.startsWith('~') && match.input.endsWith('~'))
              ? match.group(1)
              : match.group(0); */
              match.group(1) ?? match.group(0);
          // Access the matched group
          if (matchedGroup != null) {
            StringBuffer nonEmojiBuffer = StringBuffer();
            StringBuffer emojiBuffer = StringBuffer();
            List<TextSpan> tempSpans = [];

            for (var char in matchedGroup.characters) {
              if (isEmoji(char)) {
                if (nonEmojiBuffer.isNotEmpty) {
                  tempSpans.add(TextSpan(
                      text: nonEmojiBuffer.toString(),
                      style: patterns[pattern]!(nonEmojiBuffer.toString())
                          .style /*?? TextStyle(color: color, fontSize: 17)*/));
                  nonEmojiBuffer.clear();
                }
                emojiBuffer.write(char);
              } else {
                if (emojiBuffer.isNotEmpty) {
                  tempSpans.add(TextSpan(
                    text: emojiBuffer.toString(),
                    style: TextStyle(
                      color: color,
                      fontFamily: 'NotoColorEmoji',
                      fontSize: 20,
                    ),
                  ));
                  emojiBuffer.clear();
                }
                nonEmojiBuffer.write(char);
              }
            }
            if (emojiBuffer.isNotEmpty) {
              tempSpans.add(TextSpan(
                text: emojiBuffer.toString(),
                style: TextStyle(
                  color: color,
                  fontFamily: 'NotoColorEmoji',
                  fontSize: 20,
                ),
              ));
            }

            if (nonEmojiBuffer.isNotEmpty) {
              tempSpans.add(TextSpan(
                text: nonEmojiBuffer.toString(),
                style: patterns[pattern]!(nonEmojiBuffer.toString()).style,
              ));
            }

            spans.addAll(tempSpans);

            startIndex += match.group(0)!.length; // Move startIndex
            matched = true;
            break;
          }
        }
      }

      // If no match, add plain text
      if (!matched) {
        final wordMatch = RegExp(
                r"[a-zA-Z0-9'’\ud835\udc2c\ud835\udc28\ud835\udc26\ud835\udc1e\u0020\ud835\udc2d\ud835\udc1e\ud835\udc31\ud835\udc2d]+" +
                    emojiRegex().pattern)
            .matchAsPrefix(message.substring(startIndex));
        if (wordMatch != null) {
          final unmatchedText = wordMatch.group(0)!;
          if (isEmoji(unmatchedText)) {
            spans.add(TextSpan(
              text: unmatchedText,
              style: TextStyle(
                  color: color, fontFamily: 'NotoColorEmoji', fontSize: 20),
            ));
          } else {
            spans.add(TextSpan(
              text: unmatchedText,
              style: TextStyle(color: color, fontSize: 17),
            ));
          }
          startIndex += unmatchedText.length;
        } else {
          // Handle any remaining single characters (e.g., spaces or punctuation)

          final singleChar = message[startIndex];
          if (isEmoji(singleChar)) {
            spans.add(TextSpan(
              text: singleChar,
              style: TextStyle(
                  color: color, fontFamily: 'NotoColorEmoji', fontSize: 20),
            ));
          } else {
            spans.add(TextSpan(
              text: singleChar,
              style: TextStyle(color: color, fontSize: 17),
            ));
          }
          startIndex++;
        }
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
