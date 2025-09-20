import 'dart:io';

import 'package:flutter/material.dart';
import 'assets.dart';
import 'package:http/http.dart' as http;

// class ProfileAvatarForHomeScreen extends StatelessWidget {
//   final String networkImageUrl;
//   final String assetImagePath;
//   final double radius;
//
//   const ProfileAvatarForHomeScreen({
//     Key? key,
//     required this.networkImageUrl,
//     required this.assetImagePath,
//     this.radius = 30.0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final url = (networkImageUrl).trim();
//     final hasUrl = url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true;
//
//     if (!hasUrl) {
//       return CircleAvatar(
//         radius: radius,
//         backgroundImage: AssetImage(assetImagePath),
//         backgroundColor: Colors.grey.shade200,
//       );
//     }
//
//     return CircleAvatar(
//       radius: radius,
//       backgroundColor: Colors.grey.shade200,
//       child: ClipOval(
//         child: Image.network(
//           url,
//           key: ValueKey(url), // IMPORTANT: rebuild when URL changes
//           width: radius * 2,
//           height: radius * 2,
//           fit: BoxFit.cover,
//           loadingBuilder: (context, child, progress) {
//             if (progress == null) return child;
//             return SizedBox(
//               width: radius * 2,
//               height: radius * 2,
//               child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
//             );
//           },
//           errorBuilder: (context, error, stackTrace) {
//             return Image.asset(
//               assetImagePath,
//               width: radius * 2,
//               height: radius * 2,
//               fit: BoxFit.cover,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ProfileAvatarForHomeScreen extends StatefulWidget {
  final String networkImageUrl;
  final String assetImagePath;
  final double radius;

  const ProfileAvatarForHomeScreen({
    Key? key,
    required this.networkImageUrl,
    required this.assetImagePath,
    this.radius = 30.0,
  }) : super(key: key);

  @override
  State<ProfileAvatarForHomeScreen> createState() => _ProfileAvatarForHomeScreenState();
}

class _ProfileAvatarForHomeScreenState extends State<ProfileAvatarForHomeScreen> {
  late String _url;
  late bool _hasUrl;

  @override
  void initState() {
    super.initState();
    _syncFromWidget();
    // Precache the fallback asset to avoid flicker
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(widget.assetImagePath), context);
      if (_hasUrl) {
        precacheImage(Image.network(_url).image, context);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ProfileAvatarForHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.networkImageUrl != widget.networkImageUrl ||
        oldWidget.assetImagePath != widget.assetImagePath) {
      _syncFromWidget();
      // Optionally precache the new image
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_hasUrl) {
          precacheImage(Image.network(_url).image, context);
        }
      });
    }
  }

  void _syncFromWidget() {
    _url = (widget.networkImageUrl).trim();
    // Use isAbsolute for a proper full URL check
    _hasUrl = _url.isNotEmpty && (Uri.tryParse(_url)?.isAbsolute == true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasUrl) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundImage: AssetImage(widget.assetImagePath),
        backgroundColor: Colors.grey.shade200,
      );
    }

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: Image.network(
          _url,
          key: ValueKey(_url), // rebuild when URL changes
          width: widget.radius * 2,
          height: widget.radius * 2,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return SizedBox(
              width: widget.radius * 2,
              height: widget.radius * 2,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              widget.assetImagePath,
              width: widget.radius * 2,
              height: widget.radius * 2,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String networkImageUrl;
  final String assetImagePath;
  final double radius;

  const ProfileAvatar({
    Key? key,
    required this.networkImageUrl,
    required this.assetImagePath,
    this.radius = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: Image.network(
          networkImageUrl,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          errorBuilder: (context, error, stackTrace) {
            // If the network image fails, fallback to asset image
            return Image.asset(
              assetImagePath,
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
            );
          },
        ),
      ),
    );
  }
}
// ProfileAvatarCustom.dart
class ProfileAvatarCustom extends StatelessWidget {
  final String? networkImageUrl;   // full URL, may be null
  final File? localImageFile;      // local file for instant preview, may be null
  final String assetImagePath;
  final double radius;

  const ProfileAvatarCustom({
    Key? key,
    this.networkImageUrl,
    this.localImageFile,
    required this.assetImagePath,
    this.radius = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (localImageFile != null) {
      imageProvider = FileImage(localImageFile!);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(networkImageUrl!);
    } else {
      imageProvider = AssetImage(assetImagePath);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: imageProvider,
    );
  }
}


class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool isExpanded;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final Alignment? alignment;
  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final int? lines;
  final bool? giveLinesAsText;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.alignment,
    this.isExpanded = false,
    this.fontFamily,
    this.textOverflow,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none, this.lines, this.giveLinesAsText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: isExpanded ? MediaQuery.of(context).size.width : null,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          fontFamily: fontFamily ?? Assets.interRegular,
          decoration: textDecoration,
        ),
        overflow:giveLinesAsText == true?null: textOverflow??TextOverflow.ellipsis,
        maxLines: lines,
      ),
    );
  }
}