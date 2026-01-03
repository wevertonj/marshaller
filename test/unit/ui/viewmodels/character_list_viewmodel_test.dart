import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_state.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_viewmodel.dart';

import '../../../fixtures/character_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late CharacterListViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = CharacterListViewModel(repository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('CharacterListViewModel', () {
    test('should have CharacterListInitial as initial state', () {
      expect(viewModel.state.value, isA<CharacterListInitial>());
    });

    group('loadCharactersCommand', () {
      test(
        'should emit CharacterListLoading then CharacterListLoaded when loading succeeds',
        () async {
          final states = <CharacterListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          final paginatedResult = PaginatedResult(
            items: CharacterFixtures.testCharacterList,
            totalCount: 826,
            totalPages: 42,
            nextPage: 2,
            hasMore: true,
          );

          when(
            () => mockRepository.getCharacters(page: 1),
          ).thenAnswer((_) async => Success(paginatedResult));

          await viewModel.loadCharactersCommand.execute((
            forceRefresh: false,
            species: null,
            type: null,
            gender: null,
            name: null,
          ));

          expect(states.length, 2);
          expect(states[0], isA<CharacterListLoading>());
          expect(states[1], isA<CharacterListLoaded>());

          final loadedState = viewModel.state.value as CharacterListLoaded;
          expect(loadedState.characters, CharacterFixtures.testCharacterList);
          expect(loadedState.hasMore, true);
          expect(loadedState.currentPage, 1);

          verify(() => mockRepository.getCharacters(page: 1)).called(1);
        },
      );

      test(
        'should emit CharacterListLoading then CharacterListError when loading fails',
        () async {
          final states = <CharacterListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getCharacters(page: 1),
          ).thenAnswer((_) async => Failure(Exception('Network error')));

          await viewModel.loadCharactersCommand.execute((
            forceRefresh: false,
            species: null,
            type: null,
            gender: null,
            name: null,
          ));

          expect(states.length, 2);
          expect(states[0], isA<CharacterListLoading>());
          expect(states[1], isA<CharacterListError>());

          final errorState = viewModel.state.value as CharacterListError;
          expect(errorState.message, contains('Network error'));
        },
      );
    });

    group('loadMoreCommand', () {
      test('should append characters when load more succeeds', () async {
        final firstPageResult = PaginatedResult(
          items: [CharacterFixtures.testCharacter],
          totalCount: 826,
          totalPages: 42,
          nextPage: 2,
          hasMore: true,
        );

        when(
          () => mockRepository.getCharacters(page: 1),
        ).thenAnswer((_) async => Success(firstPageResult));

        await viewModel.loadCharactersCommand.execute((
          forceRefresh: false,
          species: null,
          type: null,
          gender: null,
          name: null,
        ));

        final secondPageResult = PaginatedResult(
          items: [CharacterFixtures.testCharacter2],
          totalCount: 826,
          totalPages: 42,
          nextPage: 3,
          hasMore: true,
        );

        when(
          () => mockRepository.getCharacters(page: 2),
        ).thenAnswer((_) async => Success(secondPageResult));

        await viewModel.loadMoreCommand.execute();

        final loadedState = viewModel.state.value as CharacterListLoaded;
        expect(loadedState.characters.length, 2);
        expect(loadedState.characters[0], CharacterFixtures.testCharacter);
        expect(loadedState.characters[1], CharacterFixtures.testCharacter2);
        expect(loadedState.currentPage, 2);
        expect(loadedState.hasMore, true);
      });

      test('should not load more when hasMore is false', () async {
        final paginatedResult = PaginatedResult(
          items: CharacterFixtures.testCharacterList,
          totalCount: 2,
          totalPages: 1,
          nextPage: null,
          hasMore: false,
        );

        when(
          () => mockRepository.getCharacters(page: 1),
        ).thenAnswer((_) async => Success(paginatedResult));

        await viewModel.loadCharactersCommand.execute((
          forceRefresh: false,
          species: null,
          type: null,
          gender: null,
          name: null,
        ));

        await viewModel.loadMoreCommand.execute();

        verifyNever(() => mockRepository.getCharacters(page: 2));
      });

      test(
        'should not load more when state is not CharacterListLoaded',
        () async {
          await viewModel.loadMoreCommand.execute();

          verifyNever(
            () => mockRepository.getCharacters(page: any(named: 'page')),
          );
        },
      );
    });
  });
}
