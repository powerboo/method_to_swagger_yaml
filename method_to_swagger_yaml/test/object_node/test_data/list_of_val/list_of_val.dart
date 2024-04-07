import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_of_val.freezed.dart';
part 'list_of_val.g.dart';

abstract class InterfaceId {
  Map<String, Object?> toJson();
}

@freezed
class ListOfValue with _$ListOfValue {
  const ListOfValue._();
  const factory ListOfValue({
    required ListOfAny<ValueId> listOfValue,
  }) = _ListOfValue;
  factory ListOfValue.fromJson(Map<String, Object?> json) =>
      _$ListOfValueFromJson(json);
}

class ListOfValueException implements Exception {
  late final String message;
  ListOfValueException(final String message) {
    this.message = "[ListOfValueException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class BaseSort<Id extends InterfaceId> {
  @JsonKey(name: 'sort_key')
  final Id sortKey;
  @JsonKey(name: 'sort_num')
  final SortNum sortNum;

  BaseSort({
    required this.sortKey,
    required this.sortNum,
  });

  factory BaseSort.fromJson(Map<String, Object?> json) =>
      _$BaseSortFromJson(json, (Object? object) {
        // 型チェック
        if (object is! Map<String, Object?>) {
          throw Exception("object is not json.");
        }

        throw Exception("un supported json structure.");
      });

  Map<String, Object?> toJson() => _$BaseSortToJson(this, (Id id) {
        return id.toJson();
      });

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is BaseSort &&
          other.sortKey == sortKey &&
          other.sortNum == sortNum);

  @override
  int get hashCode =>
      runtimeType.hashCode ^ sortKey.hashCode ^ sortNum.hashCode;
}

@freezed
class ListOfAny<Id extends InterfaceId> with _$ListOfAny {
  const ListOfAny._();
  const factory ListOfAny({
    required List<BaseSort<Id>> listOfAny,
  }) = _ListOfAny;

  factory ListOfAny.fromJson(Map<String, Object?> json) =>
      _$ListOfAnyFromJson(json);

  /// 任意の値を取得する
  BaseSort<Id>? find({required Id target}) {
    final List<BaseSort<Id>> find = listOfAny
        .where((s) => s.sortKey == target)
        .toList() as List<BaseSort<Id>>;
    if (find.isEmpty) {
      return null;
    }
    return find.first;
  }

  /// 任意の値を追加する
  ListOfAny<Id> add({required Id item}) {
    // 重複していたら例外を投げる
    if (find(target: item) != null) {
      throw Exception("[ListOfAnyError] duplicate id.Id[$item]");
    }

    // 操作が0件の時、ソート番号は1とする
    int sortNum = 1;

    // 操作が1件以上あるとき、最大のソート番号+1とする
    if (listOfAny.isNotEmpty) {
      // ソート番号が最大のものを取得する
      // 昇順に並べる
      List<BaseSort<Id>> sort = List<BaseSort<Id>>.from(listOfAny);
      sort.sort((a, b) => a.sortNum.toInt() - b.sortNum.toInt());

      // 最大のものを取得する
      final max = sort.removeLast();

      sortNum = max.sortNum.toInt() + 1;
    }

    // 可変の変数に入れる
    List<BaseSort<Id>> result = [];
    result.addAll(List<BaseSort<Id>>.from(listOfAny));

    // 追加する
    BaseSort<Id> newItem = BaseSort<Id>(
      sortKey: item,
      sortNum: SortNum(sortNum),
    );
    result.add(newItem);

    return copyWith(
      listOfAny: result,
    ) as ListOfAny<Id>;
  }

  /// 任意の値を複数追加する
  ListOfAny<Id> addAll({required List<Id> targets}) {
    // 重複していたら例外を投げる
    for (final target in targets) {
      if (find(target: target) != null) {
        throw Exception("[ListOfAnyError] duplicate id.Id[$target]");
      }
    }

    // 操作が0件の時、ソート番号は1とする
    int sortNum = 1;

    // 操作が1件以上あるとき、最大のソート番号+1とする
    if (listOfAny.isNotEmpty) {
      // ソート番号が最大のものを取得する
      // 昇順に並べる
      List<BaseSort<Id>> sort = List<BaseSort<Id>>.from(listOfAny);
      sort.sort((a, b) => a.sortNum.toInt() - b.sortNum.toInt());

      // 最大のものを取得する
      final max = sort.removeLast();

      sortNum = max.sortNum.toInt() + 1;
    }

    List<BaseSort<Id>> ids = List<BaseSort<Id>>.from(listOfAny);
    for (final Id id in targets) {
      ids.add(
        BaseSort<Id>(
          sortKey: id,
          sortNum: SortNum(sortNum),
        ),
      );
      sortNum++;
    }

    return copyWith(
      listOfAny: ids,
    ) as ListOfAny<Id>;
  }

  /// 要素を削除する
  ListOfAny<Id> tryDelete({
    required Id targetId,
  }) {
    final target = find(target: targetId);
    // 削除対象が存在しない場合は削除失敗
    if (target == null) {
      throw Exception("[ListOfAnyError] target does not exists.");
    }

    // 削除したあとの操作一覧
    final List<BaseSort<Id>> deletedList = listOfAny
        .where((s) => s.sortKey != targetId)
        .toList() as List<BaseSort<Id>>;

    // 採番し直す
    final renumber = _renumbering(
      deleted: target,
      deletedList: deletedList,
    );

    return copyWith(
      listOfAny: renumber,
    ) as ListOfAny<Id>;
  }

  /// 要素を並べ替える
  ListOfAny<Id> rearrangeSortNum({
    required Id targetId,
    required SortNum moveTo,
  }) {
    // 操作対象を取得する
    final target = find(target: targetId);
    if (target == null)
      throw Exception("[ListOfAnyError] target does not exists.");

    // 移動先が自分の配列の長さを超えたものでないか確認する
    if (listOfAny.length < moveTo.toInt()) {
      throw Exception(
          "[ListOfAnyError] moveTo index exceeds the length of its own array length.");
    }

    // 移動先が現在位置より前の場合
    if (moveTo.toInt() < target.sortNum.toInt()) {
      return copyWith(
        listOfAny: _inFront<Id>(
          listOfAny: listOfAny as List<BaseSort<Id>>,
          moveTo: moveTo,
          target: target,
        ),
      ) as ListOfAny<Id>;
    }

    // 移動先が現在位置よりうしろの場合
    if (target.sortNum.toInt() < moveTo.toInt()) {
      return copyWith(
        listOfAny: _back<Id>(
          listOfAny: listOfAny as List<BaseSort<Id>>,
          moveTo: moveTo,
          target: target,
        ),
      ) as ListOfAny<Id>;
    }

    // 移動先が現在位置と等しい場合
    if (target.sortNum.toInt() == moveTo.toInt()) {
      // 変更しない
      return copyWith() as ListOfAny<Id>;
    }

    throw Exception("[ListOfAnyError] Unexpected sortNum. 想定外のソート番号です。");
  }

  // ソート番号が削除対象未満のデータを採番し直す
  List<BaseSort<Id>> _renumbering({
    required BaseSort<Id> deleted,
    required List<BaseSort<Id>> deletedList,
  }) {
    // 1. ソート番号がdeletedより大きい操作一覧
    final less = deletedList
        .where((d) => d.sortNum.toInt() > deleted.sortNum.toInt())
        .toList();

    // [1.]を採番し直す : -1する
    List<BaseSort<Id>> renumber = [];
    int index = 0;
    for (final _ in less) {
      // 採番計算
      final newSortNum = less[index].sortNum.toInt() - 1;

      // 採番
      renumber.add(BaseSort<Id>(
        sortKey: less[index].sortKey,
        sortNum: SortNum(newSortNum),
      ));
      index++;
    }

    return renumber;
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool get isLastOne {
    return listOfAny.isNotEmpty && listOfAny.length == 1;
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  int get length {
    return listOfAny.length;
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<BaseSort<Id>> get list {
    return List<BaseSort<Id>>.from(listOfAny);
  }
  // */
}

// /*
// 移動先が現在位置より前の時の採番生成
List<BaseSort<InterfaceId>> _inFront<Id>({
  required List<BaseSort<InterfaceId>> listOfAny,
  required SortNum moveTo,
  required BaseSort<InterfaceId> target,
}) {
  // 1. moveTo 未満のId
  final List<BaseSort<InterfaceId>> less =
      listOfAny.where((s) => s.sortNum.toInt() < moveTo.toInt()).toList();

  // 2. 移動対象のId 移動先を設定する
  final BaseSort<InterfaceId> just =
      BaseSort<InterfaceId>(sortKey: target.sortKey, sortNum: moveTo);

  // 3. 移動対象を除くmoveTo を以上のId
  List<BaseSort<InterfaceId>> more = listOfAny
      .where((s) => s.sortKey != target.sortKey)
      .where((s) => s.sortNum.toInt() >= moveTo.toInt())
      .toList();

  // [3.]を採番し直す : 昇順に(moveTo + 1)番とする
  more.sort((a, b) => a.sortNum.toInt() - b.sortNum.toInt());
  int sortNum = moveTo.toInt();
  int index = 0;
  for (final _ in more) {
    // 採番
    sortNum++;
    more[index] = BaseSort<InterfaceId>(
      sortKey: more[index].sortKey,
      sortNum: SortNum(sortNum),
    );
    index++;
  }

  return [...less, just, ...more];
}

// 移動先が現在位置よりうしろの時の採番生成
List<BaseSort<InterfaceId>> _back<Id>({
  required List<BaseSort<InterfaceId>> listOfAny,
  required SortNum moveTo,
  required BaseSort<InterfaceId> target,
}) {
  // 1. 移動対象のsortNum(移動前) 未満のId
  final List<BaseSort<InterfaceId>> less = listOfAny
      .where((s) => s.sortNum.toInt() < target.sortNum.toInt())
      .toList();

  // 2. 移動対象のsortNum(移動前) より大きい　かつ moveTo 以下のもの
  List<BaseSort<InterfaceId>> between = listOfAny
      .where((s) =>
          target.sortNum.toInt() < s.sortNum.toInt()) // 移動対象のsortNum(移動前) より大きい
      .where((s) => s.sortNum.toInt() <= moveTo.toInt()) // moveTo 以下
      .toList();

  // 3. 移動対象のId 移動先を設定する
  final BaseSort<InterfaceId> just =
      BaseSort<InterfaceId>(sortKey: target.sortKey, sortNum: moveTo);

  // 4. moveTo 以上のId
  List<BaseSort<InterfaceId>> more =
      listOfAny.where((s) => moveTo.toInt() < s.sortNum.toInt()).toList();

  // [2.]を採番し直す : -1する
  int index = 0;
  for (final _ in between) {
    // 採番計算
    final newSortNum = between[index].sortNum.toInt() - 1;

    // 採番
    between[index] = BaseSort<InterfaceId>(
      sortKey: between[index].sortKey,
      sortNum: SortNum(newSortNum),
    );
    index++;
  }

  // [3.]を採番し直す : 昇順に(moveTo + 1)番とする
  index = 0;
  more.sort((a, b) => a.sortNum.toInt() - b.sortNum.toInt());
  int sortNum = moveTo.toInt();
  for (final _ in more) {
    // 採番
    sortNum++;
    more[index] = BaseSort<InterfaceId>(
      sortKey: more[index].sortKey,
      sortNum: SortNum(sortNum),
    );
    index++;
  }

  return [...less, ...between, just, ...more];
}

@JsonSerializable()
class SortNum {
  @JsonKey(name: 'sort_num')
  final int value;

  SortNum(this.value) {
    if (value < 0) {
      throw SortNumException("SortNum must have more than 1.");
    }
  }

  factory SortNum.fromJson(Map<String, Object?> json) =>
      _$SortNumFromJson(json);

  Map<String, Object?> toJson() => _$SortNumToJson(this);

  int toInt() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is SortNum && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class SortNumException implements Exception {
  late final String message;
  SortNumException(final String message) {
    this.message = "[SortNum] $message";
  }
  @override
  String toString() {
    return message;
  }
}

@JsonSerializable()
class ValueId implements InterfaceId {
  @JsonKey(name: 'value_id')
  final String value;

  ValueId(this.value) {
    if (value.isEmpty) {
      throw Exception("ValueId does not empty.");
    }
  }

  factory ValueId.fromJson(Map<String, Object?> json) =>
      _$ValueIdFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ValueIdToJson(this);

  @override
  String toString() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is ValueId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
