# Daraz-Style Product Listing — Flutter

A single-screen Flutter app that mimics Daraz-style product listing. It has a collapsible header, sticky tab bar, and you can swipe between tabs. I used the [FakeStore API](https://fakestoreapi.com/) to fetch real product data, categories, and handle login/profile.

## Screenshots

<p>
  <img src="screenshots/home_full.png" width="250" />
  &nbsp;&nbsp;
  <img src="screenshots/home_scrolled.png" width="250" />
</p>

## How to Run

```bash
flutter pub get
flutter run
```

**Flutter version**: 3.38.7 (Channel stable)

For login, use FakeStore test credentials: `mor_2314` / `83r5^_`

---

## Architecture Explanation

### 1. How I Implemented Horizontal Swipe

I used `GestureDetector.onHorizontalDragEnd` and wrapped it around the whole screen body. The reason I chose `onHorizontalDragEnd` instead of `onHorizontalDragUpdate` is that it only fires after the user lifts their finger — so it doesn't interfere with vertical scrolling at all during the drag.

I also added a velocity threshold of 300 px/s so that only intentional swipes trigger a tab switch. Small accidental horizontal movements are ignored.

I didn't use `PageView` or `TabBarView` because those create their own internal scrollable widget, and that would break the single-scroll requirement.

You can check `HomeScreen._onHorizontalDragEnd()` and the controller methods `swipeToNextTab()` / `swipeToPreviousTab()` for the implementation.

### 2. Who Owns the Vertical Scroll and Why

`HomeController` owns the single `ScrollController`.

The whole screen has only one vertical scrollable — a `CustomScrollView`. Products are inside a `SliverGrid`, not a separate `ListView`, so everything scrolls together in one context. No nested scrolling.

I kept the `ScrollController` in the controller instead of the widget so it survives rebuilds. When you switch tabs, the scroll position stays exactly where it is — I just swap the product list reactively using GetX. No jumping, no resetting.

### 3. Trade-offs and Limitations

- Swipe works from anywhere on screen, including the banner area. I did this to keep gesture handling simple, but it means swiping over the banner also switches tabs.
- Products re-render when switching tabs because I replace the `currentProducts` list instead of keeping all tabs alive. Less memory usage but there's a brief rebuild.
- Single `ScrollController` is the simplest way to meet the one-scrollable requirement. If I needed a second scrollable area later, I'd have to restructure things.
- No `PageView` / `TabBarView` means no built-in swipe animation, but it avoids all the nested scroll conflicts.
- I used shimmer loading for the product grid instead of a spinner — looks cleaner while data loads.

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── models/          # ProductModel, UserModel
│   ├── services/        # ApiService, NetworkCaller
│   ├── common/styles/   # Global text styles
│   └── utils/           # Sizer, Colors, API constants
└── features/
    └── home/
        ├── controllers/
        │   └── home_controller.dart   # State + scroll ownership
        └── presentation/
            ├── screens/
            │   └── home_screen.dart   # Single-scroll sliver layout
            └── widgets/
                ├── search_app_bar.dart       # Pinned search bar
                ├── banner_section.dart       # Collapsible banner
                ├── sticky_tab_bar.dart       # Sticky tab bar delegate
                ├── product_card.dart         # Product grid item
                ├── product_shimmer.dart      # Loading skeleton
                ├── login_bottom_sheet.dart   # Login UI
                └── profile_bottom_sheet.dart # User profile UI
```

## Key Points

- Sliver-based layout: `CustomScrollView` → `SliverAppBar` → `SliverToBoxAdapter` (banner) → `SliverPersistentHeader` (sticky tabs) → `SliverGrid` (products)
- GetX for state management — reactive product list, tab index, loading and auth states
- Pull-to-refresh works from any tab
- Tab switching keeps the scroll position as it is
- Shimmer loading in product grid while data loads
