import 'package:marshaller/domain/entities/character.dart';

sealed class CharacterListState {
  const CharacterListState();
}

final class CharacterListInitial extends CharacterListState {
  const CharacterListInitial();
}

final class CharacterListLoading extends CharacterListState {
  const CharacterListLoading();
}

final class CharacterListLoaded extends CharacterListState {
  final List<Character> characters;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentPage;
  final int totalCount;
  final String? species;
  final String? type;
  final String? gender;
  const CharacterListLoaded({
    required this.characters,
    required this.hasMore,
    this.isLoadingMore = false,
    required this.currentPage,
    this.totalCount = 0,
    this.species,
    this.type,
    this.gender,
  });
  CharacterListLoaded copyWith({
    List<Character>? characters,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentPage,
    int? totalCount,
    String? species,
    String? type,
    String? gender,
  }) {
    return CharacterListLoaded(
      characters: characters ?? this.characters,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
    );
  }
}

final class CharacterListError extends CharacterListState {
  final String message;
  const CharacterListError(this.message);
}
