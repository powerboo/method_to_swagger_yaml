import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:sample_pj/domain/entity/target_picture.dart';
import 'package:sample_pj/domain/value_object/picture_id.dart';

@ConvertTargetClass(
  title: "title",
  version: "0.0.1",
)
abstract interface class TargetPictureApi {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "target-picture/:pictureId",
  )
  Future<TargetPicture?> find({
    @RequestParameter(
      requestParameterDiv: RequestParameterDiv.path,
    )
    required PictureId pictureId,
  });

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "target-picture",
  )
  Future<List<TargetPicture>> all({
    int cursor = 0,
    int length = 100,
  });

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.post,
    pathName: "target-picture",
  )
  Future<void> save({required TargetPicture targetPicture});

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.delete,
    pathName: "target-picture/:pictureId",
  )
  Future<void> delete({required PictureId pictureId});
}
