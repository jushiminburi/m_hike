
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
@Embedded(ignore: {'copyWith'})
class Image with _$Image {
  factory Image({List<int>? image}) = _Image;
}
