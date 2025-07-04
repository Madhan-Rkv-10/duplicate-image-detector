import 'package:flutter/cupertino.dart'
    show
        StatelessWidget,
        BuildContext,
        Widget,
        GridView,
        EdgeInsets,
        SliverGridDelegateWithFixedCrossAxisCount;

import '../../../core/utils.dart' show ImageManagementLogic;
import '../../domain/image_data.dart' show ImageData;
import 'image_card.dart' show ImageCardWidget;

class ImageGridWidget extends StatelessWidget {
  final List<ImageData> images;

  final Function(int) onRemove;
  final ImageManagementLogic logic;

  const ImageGridWidget({
    super.key,
    required this.images,

    required this.onRemove,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ImageCardWidget(
          imageData: images[index],
          index: index,
          onRemove: () => onRemove(index),
          logic: logic,
        );
      },
    );
  }
}
