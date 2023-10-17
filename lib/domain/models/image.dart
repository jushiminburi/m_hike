
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
@Embedded(ignore: {'copyWith'})
class ImageLocal with _$ImageLocal {
  factory ImageLocal({List<int>? image}) = _ImageLocal;
}
