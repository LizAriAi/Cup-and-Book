// Cup&Book - Seed Data

import '../models/models.dart';

class SeedData {
  static List<Book> getSampleBooks() {
    return [
      Book(
        id: 'harry-potter-1',
        title: 'Harry Potter and the Sorcerer\'s Stone',
        author: 'J.K. Rowling',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/10521270-M.jpg',
        pageCount: 309,
        description:
            'Harry Potter has no idea how famous he is, that he lives in a mansion surrounded by his terrible family, or that he is in danger.',
        ageRange: AgeRange.middleGrade,
        genres: [Genre.fantasy, Genre.adventure],
        rating: const BookRating(
          violence: ViolenceLevel.fantasyBattles,
          profanity: ProfanityLevel.none,
          sexualContent: SexualContentLevel.none,
          scaryThemes: ScaryLevel.tension,
          matureTopics: MatureTopicsLevel.mentions,
        ),
        reviewCount: 847,
        communityRating: 4.8,
        purchaseLinks: {
          'Amazon': 'https://amazon.com/dp/0590353427',
          'Bookshop.org': 'https://bookshop.org/p/books/8385',
          'Barnes & Noble': 'https://barnesandnoble.com/dp/0590353427',
        },
      ),
      Book(
        id: 'percy-jackson-1',
        title: 'Percy Jackson & The Lightning Thief',
        author: 'Rick Riordan',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/8361536-M.jpg',
        pageCount: 377,
        description:
            'Twelve-year-old Percy Jackson discovers he\'s a demigod, the son of Poseidon, and is launched into a world of monsters and myths.',
        ageRange: AgeRange.middleGrade,
        genres: [Genre.fantasy, Genre.adventure],
        rating: const BookRating(
          violence: ViolenceLevel.action,
          profanity: ProfanityLevel.none,
          sexualContent: SexualContentLevel.none,
          scaryThemes: ScaryLevel.spooky,
          matureTopics: MatureTopicsLevel.mentions,
        ),
        reviewCount: 623,
        communityRating: 4.9,
        purchaseLinks: {
          'Amazon': 'https://amazon.com/dp/0786856292',
          'Bookshop.org': 'https://bookshop.org/p/books/238926',
        },
      ),
      Book(
        id: 'hunger-games',
        title: 'The Hunger Games',
        author: 'Suzanne Collins',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/8754363-M.jpg',
        pageCount: 374,
        description:
            'In a dark future, children are forced to fight to the death in a televised event. Katniss volunteers to take her sister\'s place.',
        ageRange: AgeRange.youngAdult,
        genres: [Genre.sciFi, Genre.mystery, Genre.adventure],
        rating: const BookRating(
          violence: ViolenceLevel.intense,
          profanity: ProfanityLevel.mild,
          sexualContent: SexualContentLevel.crushHoldingHands,
          scaryThemes: ScaryLevel.scary,
          matureTopics: MatureTopicsLevel.majorElement,
        ),
        reviewCount: 1523,
        communityRating: 4.7,
        purchaseLinks: {
          'Amazon': 'https://amazon.com/dp/0439023481',
          'Bookshop.org': 'https://bookshop.org/p/books/293400',
        },
      ),
      Book(
        id: 'charlotte-web',
        title: 'Charlotte\'s Web',
        author: 'E.B. White',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/8231856-M.jpg',
        pageCount: 184,
        description:
            'The tale of how a little girl, Fern, helped save her pig Wilbur from slaughter through the help of a spider named Charlotte.',
        ageRange: AgeRange.middleGrade,
        genres: [Genre.fantasy],
        rating: const BookRating(
          violence: ViolenceLevel.none,
          profanity: ProfanityLevel.none,
          sexualContent: SexualContentLevel.none,
          scaryThemes: ScaryLevel.sunny,
          matureTopics: MatureTopicsLevel.discussTheme,
        ),
        reviewCount: 2103,
        communityRating: 4.9,
        purchaseLinks: {
          'Amazon': 'https://amazon.com/dp/0064400557',
          'Bookshop.org': 'https://bookshop.org/p/books/8191',
        },
      ),
      Book(
        id: 'gatsby',
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/8432048-M.jpg',
        pageCount: 180,
        description:
            'A story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
        ageRange: AgeRange.adult,
        genres: [Genre.historical, Genre.romance],
        rating: const BookRating(
          violence: ViolenceLevel.none,
          profanity: ProfanityLevel.moderate,
          sexualContent: SexualContentLevel.kissingClosedDoor,
          scaryThemes: ScaryLevel.tension,
          matureTopics: MatureTopicsLevel.majorElement,
        ),
        reviewCount: 5621,
        communityRating: 4.5,
        purchaseLinks: {
          'Amazon': 'https://amazon.com/dp/0743273567',
          'Barnes & Noble': 'https://barnesandnoble.com/dp/0743273567',
        },
      ),
    ];
  }
}