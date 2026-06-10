// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHighlightModelCollection on Isar {
  IsarCollection<HighlightModel> get highlightModels => this.collection();
}

const HighlightModelSchema = CollectionSchema(
  name: r'HighlightModel',
  id: 8278649049609836408,
  properties: {
    r'bookId': PropertySchema(
      id: 0,
      name: r'bookId',
      type: IsarType.long,
    ),
    r'chapter': PropertySchema(
      id: 1,
      name: r'chapter',
      type: IsarType.long,
    ),
    r'colorCode': PropertySchema(
      id: 2,
      name: r'colorCode',
      type: IsarType.long,
    ),
    r'endIndex': PropertySchema(
      id: 3,
      name: r'endIndex',
      type: IsarType.long,
    ),
    r'startIndex': PropertySchema(
      id: 4,
      name: r'startIndex',
      type: IsarType.long,
    ),
    r'verse': PropertySchema(
      id: 5,
      name: r'verse',
      type: IsarType.long,
    )
  },
  estimateSize: _highlightModelEstimateSize,
  serialize: _highlightModelSerialize,
  deserialize: _highlightModelDeserialize,
  deserializeProp: _highlightModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _highlightModelGetId,
  getLinks: _highlightModelGetLinks,
  attach: _highlightModelAttach,
  version: '3.1.0+1',
);

int _highlightModelEstimateSize(
  HighlightModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _highlightModelSerialize(
  HighlightModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bookId);
  writer.writeLong(offsets[1], object.chapter);
  writer.writeLong(offsets[2], object.colorCode);
  writer.writeLong(offsets[3], object.endIndex);
  writer.writeLong(offsets[4], object.startIndex);
  writer.writeLong(offsets[5], object.verse);
}

HighlightModel _highlightModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HighlightModel(
    bookId: reader.readLong(offsets[0]),
    chapter: reader.readLong(offsets[1]),
    colorCode: reader.readLong(offsets[2]),
    endIndex: reader.readLong(offsets[3]),
    startIndex: reader.readLong(offsets[4]),
    verse: reader.readLong(offsets[5]),
  );
  object.id = id;
  return object;
}

P _highlightModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _highlightModelGetId(HighlightModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _highlightModelGetLinks(HighlightModel object) {
  return [];
}

void _highlightModelAttach(
    IsarCollection<dynamic> col, Id id, HighlightModel object) {
  object.id = id;
}

extension HighlightModelQueryWhereSort
    on QueryBuilder<HighlightModel, HighlightModel, QWhere> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HighlightModelQueryWhere
    on QueryBuilder<HighlightModel, HighlightModel, QWhereClause> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HighlightModelQueryFilter
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      bookIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      bookIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      bookIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      bookIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      chapterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      chapterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapter',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      chapterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapter',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      chapterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      colorCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      colorCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      colorCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      colorCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      endIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      endIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      endIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      endIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      startIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      startIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      startIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      startIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      verseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      verseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verse',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      verseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verse',
        value: value,
      ));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
      verseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HighlightModelQueryObject
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {}

extension HighlightModelQueryLinks
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {}

extension HighlightModelQuerySortBy
    on QueryBuilder<HighlightModel, HighlightModel, QSortBy> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorCode', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByColorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorCode', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByEndIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endIndex', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByEndIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endIndex', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByStartIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startIndex', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      sortByStartIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startIndex', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension HighlightModelQuerySortThenBy
    on QueryBuilder<HighlightModel, HighlightModel, QSortThenBy> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorCode', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByColorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorCode', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByEndIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endIndex', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByEndIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endIndex', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByStartIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startIndex', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
      thenByStartIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startIndex', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension HighlightModelQueryWhereDistinct
    on QueryBuilder<HighlightModel, HighlightModel, QDistinct> {
  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookId');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapter');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct>
      distinctByColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorCode');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByEndIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endIndex');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct>
      distinctByStartIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startIndex');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verse');
    });
  }
}

extension HighlightModelQueryProperty
    on QueryBuilder<HighlightModel, HighlightModel, QQueryProperty> {
  QueryBuilder<HighlightModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> bookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookId');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> chapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapter');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> colorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorCode');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> endIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endIndex');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> startIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startIndex');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> verseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verse');
    });
  }
}
