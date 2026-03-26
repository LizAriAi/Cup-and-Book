# Cup&Book ☕📚

A book content ratings lookup site where people can look up books and see if it suits them — appropriate for themselves or their children. Includes community Circles for connecting with readers who share similar tastes.

## Features

### Rating System (5 Dimensions)
- **Violence** — None to Graphic with gore
- **Profanity** — None to Strong/Constant
- **Sexual Content** — None to Explicit
- **Scary Themes** — Sunny to Horror
- **Mature Topics** — None to Very Dark

### Search & Filter
- Age ranges: Board Books, Picture Books, Early Readers, Chapter Books, Middle Grade, Young Adult, Adult
- Genres: Fantasy, Sci-Fi, Mystery, Adventure, Romance, Historical, Graphic Novels, Non-Fiction
- Color-coded results: Green (within filters), Yellow (borderline), Red (exceeds limits)
- Content filters with sliders

### Book Details
- Cover image, title, author, page count
- 5-dimension rating visualization
- Community reviews with specific page references
- "Where to Buy" links (Amazon, Bookshop.org, Barnes & Noble, Libro.fm)

### Community Features
- Personal bookshelves with ratings and notes
- Family profiles with custom filters per child
- Circles — Groups for connecting with similar readers

## Tech Stack

- **Frontend:** Flutter
- **Backend:** Firebase (Auth + Firestore)
- **Data:** Open Library API

## Getting Started

```bash
cd cup_and_book
flutter pub get
flutter run -d chrome
```

## Deployment

Deploy to Vercel:
```bash
vercel --prod
```

Or connect your GitHub repository to Vercel for automatic deployments.

## License

MIT