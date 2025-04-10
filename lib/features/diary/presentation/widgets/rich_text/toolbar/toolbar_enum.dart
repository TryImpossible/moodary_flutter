enum RichTextToolbarType {
  /// 相册
  album(value: 'album'),

  /// 贴纸
  sticker(value: 'sticker'),

  /// 对齐
  alignment(value: 'alignment'),

  /// 时间戳
  timestamp(value: 'timestamp'),

  /// 待办
  todo(value: 'todo'),

  /// 背景
  background(value: 'background'),

  /// 位置
  location(value: 'location'),

  /// 文字颜色
  textColor(value: 'textColor');

  const RichTextToolbarType({required this.value});

  final String value;
}
