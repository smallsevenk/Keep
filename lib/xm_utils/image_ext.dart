import 'package:flutter/material.dart';

extension ImageExt on Image {
  Image copy({
    Key key,
    ImageProvider image,
    ImageFrameBuilder frameBuilder,
    ImageLoadingBuilder loadingBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment,
    ImageRepeat repeat,
    Rect centerSlice,
    bool matchTextDirection,
    bool gaplessPlayback,
    FilterQuality filterQuality,
  }) {
    return Image(
        key: key ?? this.key,
        image: image ?? this.image,
        frameBuilder: frameBuilder ?? this.frameBuilder,
        loadingBuilder: loadingBuilder ?? this.loadingBuilder,
        errorBuilder: errorBuilder ?? this.errorBuilder,
        semanticLabel: semanticLabel ?? this.semanticLabel,
        excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
        width: width ?? this.width,
        height: height ?? this.height,
        color: color,
        colorBlendMode: colorBlendMode ?? this.colorBlendMode,
        fit: fit ?? this.fit,
        alignment: alignment ?? this.alignment,
        repeat: repeat ?? this.repeat,
        centerSlice: centerSlice ?? this.centerSlice,
        matchTextDirection: matchTextDirection ?? this.matchTextDirection,
        gaplessPlayback: gaplessPlayback ?? this.gaplessPlayback,
        filterQuality: filterQuality ?? this.filterQuality);
  }
}
