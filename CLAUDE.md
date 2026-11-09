# Meridian

## Product

Meridian is a men's styling app. One job: tell a man what to wear today, from what he already owns, and what is missing.

MVP has four tabs:

- Today
- Wardrobe
- Shop
- Stylist

Plus a Setup area: onboarding, style blend, privacy and data.

Out of scope for MVP:

- Body scan
- Made-to-measure
- Own-label products
- Celebrity or "worn by" content
- In-app checkout
- Payments
- Subscriptions

## Stack

- SwiftUI, iOS 17 minimum, Swift concurrency (async/await), Observation framework (`@Observable`).
- No third-party UI libraries. Swift Package Manager only.
- Supabase: Sign in with Apple auth, Postgres with Row Level Security on every table, Storage for garment photos.
- Claude API is called ONLY from Supabase Edge Functions (TypeScript/Deno). The app never holds an Anthropic key.
- Model name is read from an environment variable, never hardcoded.

## Design system

### Colours

| Name      | Hex       | Use                                                |
| --------- | --------- | -------------------------------------------------- |
| Bone      | `#F2EEE7` | Ground                                             |
| Page      | `#EDE8E0` | Page                                               |
| Charcoal  | `#22201E` | Type, 2px rules                                    |
| Camel     | `#B08A56` | Small-caps labels                                  |
| Taupe     | `#8A8378` | Captions                                           |
| Rule      | `#D8D0C2` | 1px dividers                                       |
| Deep red  | `#7A1F1B` | Alerts and errors only, always paired with text    |

### Type

- Bodoni Moda for headlines and figures.
- Archivo for everything else.
- Bundle both fonts (SIL Open Font License).

### Surfaces

- No rounded corners.
- No shadows.
- No gradients except image scrims.
- Sections are separated by a 2px charcoal rule.
- Rows are separated by a 1px rule.

### Motion

- 350 to 500ms, ease-out.
- Screens fade and rise 14pt.
- Nothing bounces.

### Voice

- Short, declarative.
- No hype words.
- No exclamation marks.
- No em dashes.

## Rules for you (Claude Code)

- Build only what the current prompt asks. Do not add features.
- Every screen ships with loading, empty and error states.
- Every network call has a timeout and a user-facing error message.
- Write unit tests for view models and edge functions as you go.
- Never commit secrets. Use `.xcconfig` files that are gitignored, plus a checked-in `.xcconfig.example`.
- After each task, list what you built, what you skipped, and anything I must do by hand in Xcode or Supabase.
