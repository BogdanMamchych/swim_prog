# swim_prog

## State Management

This project uses **Riverpod** for state management.

I chose Riverpod because it keeps the UI and business logic well separated, makes the state easy to share across screens, and works well for reactive features like:
- syncing the pace slider with the MIN:SEC inputs,
- updating swimmer level dynamically,
- handling loading and error states for network requests,
- managing user list search, refresh, and navigation state.

It also makes the code easier to test and maintain compared to putting logic directly inside widgets.

## Project Structure

The project is organized by feature and responsibility:

- `screens/` — main pages of the app, such as the pace selector, user list, and user detail screens.
- `widgets/` — reusable UI components used across screens.
- `providers/` — Riverpod state providers and controllers for app logic.
- `models/` — data models for API responses and app entities.
- `repositories/` — network and data access layer.
- `routes/` — navigation and route definitions.

This structure keeps the codebase clean, reusable, and easier to extend.

## What I Would Do Differently With More Time

With more time, I would improve the project in several ways:

- add more comprehensive validation for time input,
- improve loading and error UI with better feedback,
- add unit and widget tests,
- introduce caching for API responses,
- polish responsiveness for different screen sizes,
- improve accessibility and visual consistency,
- add more smooth animations and transitions,
- document swimmer level time ranges directly in the README more clearly.

## Notes

- The pace selector sends a POST request to `https://jsonplaceholder.typicode.com/posts`.
- The user list is loaded from `https://jsonplaceholder.typicode.com/users`.
- Swimmer level ranges are defined in the app logic.
