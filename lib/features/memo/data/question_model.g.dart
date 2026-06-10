// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionModelCollection on Isar {
  IsarCollection<QuestionModel> get questionModels => this.collection();
}

const QuestionModelSchema = CollectionSchema(
  name: r'QuestionModel',
  id: -2676110388347547262,
  properties: {
    r'answerText': PropertySchema(
      id: 0,
      name: r'answerText',
      type: IsarType.string,
    ),
    r'bibleTags': PropertySchema(
      id: 1,
      name: r'bibleTags',
      type: IsarType.stringList,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isResolved': PropertySchema(
      id: 3,
      name: r'isResolved',
      type: IsarType.bool,
    ),
    r'questionText': PropertySchema(
      id: 4,
      name: r'questionText',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _questionModelEstimateSize,
  serialize: _questionModelSerialize,
  deserialize: _questionModelDeserialize,
  deserializeProp: _questionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _questionModelGetId,
  getLinks: _questionModelGetLinks,
  attach: _questionModelAttach,
  version: '3.1.0+1',
);

int _questionModelEstimateSize(
  QuestionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.answerText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.bibleTags.length * 3;
  {
    for (var i = 0; i < object.bibleTags.length; i++) {
      final value = object.bibleTags[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.questionText.length * 3;
  return bytesCount;
}

void _questionModelSerialize(
  QuestionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answerText);
  writer.writeStringList(offsets[1], object.bibleTags);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeBool(offsets[3], object.isResolved);
  writer.writeString(offsets[4], object.questionText);
  writer.writeDateTime(offsets[5], object.updatedAt);
}

QuestionModel _questionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionModel(
    answerText: reader.readStringOrNull(offsets[0]),
    bibleTags: reader.readStringList(offsets[1]) ?? [],
    createdAt: reader.readDateTime(offsets[2]),
    isResolved: reader.readBool(offsets[3]),
    questionText: reader.readString(offsets[4]),
    updatedAt: reader.readDateTime(offsets[5]),
  );
  object.id = id;
  return object;
}

P _questionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionModelGetId(QuestionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionModelGetLinks(QuestionModel object) {
  return [];
}

void _questionModelAttach(
    IsarCollection<dynamic> col, Id id, QuestionModel object) {
  object.id = id;
}

extension QuestionModelQueryWhereSort
    on QueryBuilder<QuestionModel, QuestionModel, QWhere> {
  QueryBuilder<QuestionModel, QuestionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionModelQueryWhere
    on QueryBuilder<QuestionModel, QuestionModel, QWhereClause> {
  QueryBuilder<QuestionModel, QuestionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterWhereClause> idBetween(
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

extension QuestionModelQueryFilter
    on QueryBuilder<QuestionModel, QuestionModel, QFilterCondition> {
  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'answerText',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'answerText',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answerText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'answerText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'answerText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answerText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      answerTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'answerText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bibleTags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bibleTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bibleTags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bibleTags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bibleTags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      bibleTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bibleTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      isResolvedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isResolved',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      questionTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<QuestionModel, QuestionModel, QAfterFilterCondition>
      updatedAtBetween(
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
}

extension QuestionModelQueryObject
    on QueryBuilder<QuestionModel, QuestionModel, QFilterCondition> {}

extension QuestionModelQueryLinks
    on QueryBuilder<QuestionModel, QuestionModel, QFilterCondition> {}

extension QuestionModelQuerySortBy
    on QueryBuilder<QuestionModel, QuestionModel, QSortBy> {
  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> sortByAnswerText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByAnswerTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> sortByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByIsResolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension QuestionModelQuerySortThenBy
    on QueryBuilder<QuestionModel, QuestionModel, QSortThenBy> {
  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenByAnswerText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByAnswerTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByIsResolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension QuestionModelQueryWhereDistinct
    on QueryBuilder<QuestionModel, QuestionModel, QDistinct> {
  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByAnswerText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answerText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByBibleTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bibleTags');
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isResolved');
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByQuestionText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuestionModel, QuestionModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension QuestionModelQueryProperty
    on QueryBuilder<QuestionModel, QuestionModel, QQueryProperty> {
  QueryBuilder<QuestionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionModel, String?, QQueryOperations> answerTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answerText');
    });
  }

  QueryBuilder<QuestionModel, List<String>, QQueryOperations>
      bibleTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bibleTags');
    });
  }

  QueryBuilder<QuestionModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<QuestionModel, bool, QQueryOperations> isResolvedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isResolved');
    });
  }

  QueryBuilder<QuestionModel, String, QQueryOperations> questionTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionText');
    });
  }

  QueryBuilder<QuestionModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
