# Architecture Rules

This project uses a feature-first structure with three layers:
`core`, `app`, and `features`.

## core/
Reusable, app-agnostic foundations.
- ❌ Must NOT import from `app/` or `features/`
- ✅ Can be imported by anyone
- Use for: reusable widgets, layouts, theme, utils

## app/
Application wiring & structure.
- ✅ Can import from `core/` and `features/`
- ❌ No business logic
- Use for: shells, routing, navigation, tabs, app bar

## features/
Business capabilities.
- ✅ Can import from `core/`
- ❌ Must NOT import from `app/` or other features
- Use for: auth, onboarding, visits, messages, profile

## Rule of thumb
- Navigation/shells → `app/`
- Business/domain → `features/`
- Reusable & generic → `core/`
