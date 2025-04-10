import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lib_ui/lib_ui.dart';

import '../../../resources/resources.dart';
import '../controller/rich_text_controller.dart';

class ImageEmbed extends CustomBlockEmbed {
  ImageEmbed(String data) : super(imageType, data);

  factory ImageEmbed.fromAlbum({
    required String originFile,
    required String thumbFile,
  }) {
    return ImageEmbed(jsonEncode(
      <String, dynamic>{
        'originFile': originFile,
        'thumbFile': thumbFile,
      },
    ));
  }

  static const String imageType = 'image';

  /// 原图
  String get originFile =>
      (jsonDecode(data) as Map<String, dynamic>)['originFile'];

  /// 缩略图
  String get thumbFile =>
      (jsonDecode(data) as Map<String, dynamic>)['thumbFile'];
}

class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => ImageEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  String toPlainText(Embed node) {
    return ' [图片] ';
  }

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final ImageEmbed imageEmbed = ImageEmbed(node.value.data);
    return AppTouchableOpacity(
      onTap: () => _onTap(
        context: context,
        controller: controller,
        imageEmbed: imageEmbed,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 12.0, left: 4, right: 4),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              decoration: BoxDecoration(
                color: JournalRes.color.COMMON_ALL_WHITE,
                border: Border.all(
                  width: 0.5,
                  color: JournalRes.color.COMMON_GRAY,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(2, 2),
                    color: JournalRes.color.COMMON_BACK,
                  ),
                ],
              ),
              child: AppFileImage(
                width: 136,
                height: 136,
                fit: BoxFit.cover,
                path: imageEmbed.thumbFile,
              ),
            ),
            AppAssetImage(
              image: JournalRes.image.journal_ic_photo_stamp,
              width: 32,
              height: 26,
            ),
          ],
        ),
      ),
    );
  }

  void _onTap({
    required BuildContext context,
    required QuillController controller,
    required ImageEmbed imageEmbed,
  }) {
    int initialIndex = 0;
    final List<ImageEmbed>? imageEmbeds = controller.getAllImageEmbedNodes();
    if (imageEmbeds == null || imageEmbeds.isEmpty) {
      return;
    }
    final List<AppPhotoModel> photos = <AppPhotoModel>[];
    for (int i = 0; i < imageEmbeds.length; i++) {
      final ImageEmbed m = imageEmbeds[i];
      if (m.originFile == imageEmbed.originFile) {
        initialIndex = i;
      }
      photos.add(AppPhotoModel.file(
        id: m.originFile,
        path: m.originFile ?? '',
      ));
    }
    AppPhotoGalleryBuilder.of(context)
        .setDownloadButtonVisible(true)
        .setInitialIndex(initialIndex)
        .setPhotos(photos)
        .show();
  }
}
