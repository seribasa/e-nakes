import 'package:flutter_test/flutter_test.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';

void main() {
  group('BasePagination', () {
    final metadata = MetadataPaginationModel(total: 100, page: 2, perPage: 20);
    final pagination = BasePagination<int>(data: [1, 2, 3], metadata: metadata);

    dataReturnsCorrectValues() {
      expect(pagination.data, [1, 2, 3]);
    }

    metadataReturnsCorrectValues() {
      expect(pagination.metadata, metadata);
    }

    copyWithReturnsNewInstanceWithUpdatedValues() {
      final newPagination = pagination.copyWith(data: [4, 5, 6]);
      expect(newPagination.data, [4, 5, 6]);
      expect(newPagination.metadata, metadata);
    }

    propsReturnsCorrectValues() {
      expect(pagination.props, [
        [1, 2, 3],
        metadata
      ]);
    }

    test('data returns correct values', dataReturnsCorrectValues);
    test('metadata returns correct values', metadataReturnsCorrectValues);
    test('copyWith returns new instance with updated values',
        copyWithReturnsNewInstanceWithUpdatedValues);
    test('props returns correct values', propsReturnsCorrectValues);
  });

  group('MetadataPaginationModel', () {
    final metadata = MetadataPaginationModel(total: 100, page: 2, perPage: 20);

    totalReturnsCorrectValue() {
      expect(metadata.total, 100);
    }

    pageReturnsCorrectValue() {
      expect(metadata.page, 2);
    }

    perPageReturnsCorrectValue() {
      expect(metadata.perPage, 20);
    }

    copyWithReturnsNewInstanceWithUpdatedValues() {
      final newMetadata = metadata.copyWith(total: 200);
      expect(newMetadata.total, 200);
      expect(newMetadata.page, 2);
      expect(newMetadata.perPage, 20);
    }

    fromMapCreatesInstanceFromMap() {
      final map = {'total': 100, 'page': 2, 'page_size': 20};
      final metadataFromMap = MetadataPaginationModel.fromMap(map);
      expect(metadataFromMap.total, 100);
      expect(metadataFromMap.page, 2);
      expect(metadataFromMap.perPage, 20);
    }

    propsReturnsCorrectValues() {
      expect(metadata.props, [100, 2, 20]);
    }

    test('total returns correct value', totalReturnsCorrectValue);
    test('page returns correct value', pageReturnsCorrectValue);
    test('perPage returns correct value', perPageReturnsCorrectValue);
    test('copyWith returns new instance with updated values',
        copyWithReturnsNewInstanceWithUpdatedValues);
    test('fromMap creates instance from map', fromMapCreatesInstanceFromMap);
    test('props returns correct values', propsReturnsCorrectValues);
  });
}
