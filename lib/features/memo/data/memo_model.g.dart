// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMemoCollection on Isar {
  IsarCollection<Memo> get memos => this.collection();
}

const MemoSchema = CollectionSchema(
  name: r'Memo',
  id: -884281460052022898,
  properties: {
    r'bookName': PropertySchema(
      id: 0,
      name: r'bookName',
      type: IsarType.string,
    ),
    r'chapter': PropertySchema(
      id: 1,
      name: r'chapter',
      type: IsarType.long,
    ),
    r'content': PropertySchema(
      id: 2,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'verse': PropertySchema(
      id: 5,
      name: r'verse',
      type: IsarType.long,
    )
  },
  estimateSize: _memoEstimateSize,
  serialize: _memoSerialize,
  deserialize: _memoDeserialize,
  deserializeProp: _memoDeserializeProp,
  idName: r'id',
  indexes: {
    r'bookName': IndexSchema(
      id: -1933582217000277918,
      name: r'bookName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'bookName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'chapter': IndexSchema(
      id: 3334647619021962063,
      name: r'chapter',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'chapter',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'verse': IndexSchema(
      id: -7884883553101231627,
      name: r'verse',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'verse',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _memoGetId,
  getLinks: _memoGetLinks,
  attach: _memoAttach,
  version: '3.1.0+1',
);

int _memoEstimateSize(
  Memo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookName.length * 3;
  bytesCount += 3 + object.content.length * 3;
  return bytesCount;
}

void _memoSerialize(
  Memo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bookName);
  writer.writeLong(offsets[1], object.chapter);
  writer.writeString(offsets[2], object.content);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeDateTime(offsets[4], object.updatedAt);
  writer.writeLong(offsets[5], object.verse);
}

Memo _memoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Memo(
    bookName: reader.readString(offsets[0]),
    chapter: reader.readLong(offsets[1]),
    content: reader.readString(offsets[2]),
    createdAt: reader.readDateTime(offsets[3]),
    updatedAt: reader.readDateTime(offsets[4]),
    verse: reader.readLong(offsets[5]),
  );
  object.id = id;
  return object;
}

P _memoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _memoGetId(Memo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _memoGetLinks(Memo object) {
  return [];
}

void _memoAttach(IsarCollection<dynamic> col, Id id, Memo object) {
  object.id = id;
}

extension MemoQueryWhereSort on QueryBuilder<Memo, Memo, QWhere> {
  QueryBuilder<Memo, Memo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhere> anyChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'chapter'),
      );
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhere> anyVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'verse'),
      );
    });
  }
}

extension MemoQueryWhere on QueryBuilder<Memo, Memo, QWhereClause> {
  QueryBuilder<Memo, Memo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Memo, Memo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> idBetween(
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

  QueryBuilder<Memo, Memo, QAfterWhereClause> bookNameEqualTo(String bookName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookName',
        value: [bookName],
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> bookNameNotEqualTo(
      String bookName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookName',
              lower: [],
              upper: [bookName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookName',
              lower: [bookName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookName',
              lower: [bookName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookName',
              lower: [],
              upper: [bookName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> chapterEqualTo(int chapter) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'chapter',
        value: [chapter],
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> chapterNotEqualTo(int chapter) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapter',
              lower: [],
              upper: [chapter],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapter',
              lower: [chapter],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapter',
              lower: [chapter],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapter',
              lower: [],
              upper: [chapter],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> chapterGreaterThan(
    int chapter, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapter',
        lower: [chapter],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> chapterLessThan(
    int chapter, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapter',
        lower: [],
        upper: [chapter],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> chapterBetween(
    int lowerChapter,
    int upperChapter, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapter',
        lower: [lowerChapter],
        includeLower: includeLower,
        upper: [upperChapter],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> verseEqualTo(int verse) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'verse',
        value: [verse],
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> verseNotEqualTo(int verse) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'verse',
              lower: [],
              upper: [verse],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'verse',
              lower: [verse],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'verse',
              lower: [verse],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'verse',
              lower: [],
              upper: [verse],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> verseGreaterThan(
    int verse, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'verse',
        lower: [verse],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> verseLessThan(
    int verse, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'verse',
        lower: [],
        upper: [verse],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterWhereClause> verseBetween(
    int lowerVerse,
    int upperVerse, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'verse',
        lower: [lowerVerse],
        includeLower: includeLower,
        upper: [upperVerse],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MemoQueryFilter on QueryBuilder<Memo, Memo, QFilterCondition> {
  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> bookNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> chapterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> chapterGreaterThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> chapterLessThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> chapterBetween(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> verseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: value,
      ));
    });
  }

  QueryBuilder<Memo, Memo, QAfterFilterCondition> verseGreaterThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> verseLessThan(
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

  QueryBuilder<Memo, Memo, QAfterFilterCondition> verseBetween(
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

extension MemoQueryObject on QueryBuilder<Memo, Memo, QFilterCondition> {}

extension MemoQueryLinks on QueryBuilder<Memo, Memo, QFilterCondition> {}

extension MemoQuerySortBy on QueryBuilder<Memo, Memo, QSortBy> {
  QueryBuilder<Memo, Memo, QAfterSortBy> sortByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> sortByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension MemoQuerySortThenBy on QueryBuilder<Memo, Memo, QSortThenBy> {
  QueryBuilder<Memo, Memo, QAfterSortBy> thenByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<Memo, Memo, QAfterSortBy> thenByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension MemoQueryWhereDistinct on QueryBuilder<Memo, Memo, QDistinct> {
  QueryBuilder<Memo, Memo, QDistinct> distinctByBookName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Memo, Memo, QDistinct> distinctByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapter');
    });
  }

  QueryBuilder<Memo, Memo, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Memo, Memo, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Memo, Memo, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Memo, Memo, QDistinct> distinctByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verse');
    });
  }
}

extension MemoQueryProperty on QueryBuilder<Memo, Memo, QQueryProperty> {
  QueryBuilder<Memo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Memo, String, QQueryOperations> bookNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookName');
    });
  }

  QueryBuilder<Memo, int, QQueryOperations> chapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapter');
    });
  }

  QueryBuilder<Memo, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<Memo, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Memo, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Memo, int, QQueryOperations> verseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verse');
    });
  }
}
