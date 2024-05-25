# News Reader App Sample using SWIFTUI

## Overview

The News Reader App is a simple iOS application designed to fetch and display news articles from a public API. Users can browse articles by category, bookmark articles for later reading, and view their bookmarked articles.

## Implementation Choices

### Technology Stack
- **SwiftUI**: Used for building the user interface, providing a modern and declarative approach to UI development.
- **Combine**: Utilized for handling asynchronous operations, such as fetching articles from the API and managing data flow within the app.
- **Core Data**: Employed for local persistence of bookmarked articles, enabling users to save articles across app sessions.

### Public News API
- The app fetches articles from a public news API, such as [NewsAPI](https://newsapi.org/), utilizing its endpoints to retrieve news data based on different categories.

### Core Data Setup
- The Core Data stack is set up to manage the local database, including entities for articles and bookmarks. Articles fetched from the API are stored as `ArticleEntity` objects, allowing users to bookmark and save articles for later viewing.

## Testing Strategy

### Unit Testing
- Unit tests are written to ensure the correctness of critical components such as view models, networking services, and Core Data operations.
- Tests cover various scenarios including successful API requests, error handling, bookmarking functionality, and data persistence.

### UI Testing
- UI tests are implemented to validate the behavior and interactions of user interface components.
- Tests include navigation flows, category selection, bookmarking articles, and switching between different views.

### Integration Testing
- Integration tests are performed to verify the integration between different layers of the application, ensuring seamless communication between SwiftUI views, view models, network services, and Core Data.

## Setup Instructions

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.
4. Browse news articles by selecting different categories or bookmark articles for later reading.

## Future Enhancements

- Implement search functionality to allow users to search for specific articles.
- Add support for user authentication and cloud synchronization of bookmarks.
- Enhance UI/UX with animations, gestures, and custom styling.
