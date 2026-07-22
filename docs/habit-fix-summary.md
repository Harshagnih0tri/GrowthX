# GrowthX — Flutter Habit Integration Fix: Full Summary

## Context
Two separate projects:
- **`growthx-backend`** (`F:\Downloads\growthx-backend`) — FastAPI + PostgreSQL backend
- **`growthx`** (`C:\Users\hp\growthx`) — Flutter frontend (Riverpod, Dio, Material 3)

## The Problem Reported
Dashboard crashed on Flutter Web immediately after login, with:
```
Unsupported operation: Unsupported on the web, use sqflite_common_ffi_web instead.
```
Traced to: `TodayHabitsSection → habitProvider → HabitNotifier → HabitRepository → DatabaseService (SQLite)`.

## Root Causes Found (after reading the actual project files, not guessing)

1. **`HabitRepository` used local SQLite** (`sqflite_common_ffi`), which doesn't work on Flutter Web at all — this was the literal crash.
2. **`Habit` model predated the backend** and never matched it: Flutter had `title`/`isDone`; backend's `HabitRead` has `name`, `description`, `frequency`, `created_at`, `updated_at`. No completion/`isDone` concept exists on the backend at all.
3. **Dead code**: `habit_repository.dart` called `Habit.fromMap`/`.toMap()`, which didn't exist on the model (only `fromJson`/`toJson` did) — wouldn't have compiled as-is.
4. **`TodayHabitsSection` was already commented out** in `dashboard_screen.dart` as a prior workaround for the crash.
5. **Real, separate bug**: `ApiConstants.baseUrl` had an incorrect `/api/v1` prefix that doesn't exist anywhere on the actual FastAPI backend — this was breaking *every* API call in the app, not just Habits.

## Decision Made
Chose to make **Flutter adapt to the existing backend**, not add new backend features — per explicit direction to stay focused on backend/AI work. This meant dropping habit completion/streak tracking from the UI entirely (no `HabitLog` table added), since the backend has no such concept.

## Files Changed (Flutter side only — zero backend changes)

| File | Change |
|---|---|
| `lib/core/network/api_constants.dart` | Removed incorrect `/api/v1` prefix |
| `lib/features/habits/domain/habit_model.dart` | Rebuilt to match `HabitRead` exactly; removed `isDone` |
| `lib/features/habits/data/habit_repository.dart` | Replaced all SQLite calls with Dio calls to real `/habits` endpoints; added error handling surfacing backend `{"detail": ...}` messages |
| `lib/features/habits/data/habit_notifier.dart` | Switched to `AsyncValue<List<Habit>>` for proper loading/data/error state |
| `lib/features/habits/presentation/habits_screen.dart` | Add Habit dialog now collects name/description/frequency; added loading + error/retry views |
| `lib/features/dashboard/presentation/widgets/habit_row.dart` | Removed checkbox/toggle; simple display row with frequency badge |
| `lib/features/dashboard/presentation/widgets/today_habits_section.dart` | Updated field names; removed streak counter |
| `lib/features/dashboard/presentation/dashboard_screen.dart` | Re-enabled `TodayHabitsSection` (previously commented out) |
| `lib/core/database/database_service.dart` | Removed unused `_createHabitsTable`; all other local tables untouched |

## Bugs Hit and Resolved During Testing

| Issue | Cause | Resolution |
|---|---|---|
| `uvicorn` not recognized | `.venv` not activated in that terminal | `.venv\Scripts\Activate.ps1` |
| Habits failed to load, "Could not load habits" | Login returned `401` — stale/wrong test credentials, not a code bug | Registered a fresh test user via Swagger, confirmed login works there first |
| Token always read as `null` | Direct consequence of the failed login above — no token was ever saved because login never succeeded | Resolved once login succeeded with valid credentials |
| App asked to log in again after every `flutter run -d chrome` restart | **Not a real bug** — `flutter run -d chrome` launches a fresh throwaway Chrome profile every session, wiping local storage each time (a known Flutter Web dev-mode artifact) | Verified real persistence by testing on `flutter run -d windows` instead — auto-login worked correctly, confirming `splash_screen.dart`/`TokenStorage` logic was correct all along |
| `RenderFlex overflowed` warnings in `summary_card.dart` | Pre-existing UI layout bug, unrelated to this fix | Not fixed — flagged as out of scope, cosmetic only |

## Verified End-to-End
- ✅ Dashboard loads without crashing on Web
- ✅ Habits list loads from real PostgreSQL data via the backend
- ✅ Create habit works (name/description/frequency) through the full stack
- ✅ Delete habit works
- ✅ Token persists correctly across real app restarts (confirmed on Windows desktop)
- ✅ `flutter analyze` — zero errors, zero warnings (only pre-existing `avoid_print` info-level notes in files we didn't touch)

## Not Yet Done / Optional Cleanup
- Remove `print()` statements in `token_storage.dart` and `auth_repository.dart` — currently logging raw JWTs to console (flagged by linter as `avoid_print`)
- Fix the unrelated `RenderFlex overflowed` warning in `summary_card.dart`
- Commit this fix to git (commit message prepared, pending confirmation of whether `growthx` has a remote set up)

## Suggested Git Commit (prepared, not yet run)
```
git add .
git commit -m "fix(habits): rebuild Habit feature against real backend, fix Dashboard crash on Web

Root cause: HabitRepository used SQLite (sqflite_common_ffi), which
throws 'Unsupported on the web' on Flutter Web, crashing Dashboard
via TodayHabitsSection -> habitProvider -> HabitNotifier on load.
The Habit model/repository also predated the backend and never
matched its contract (title/isDone vs name/description/frequency).

[... full body as provided earlier ...]"
git push
```

---

## Overall GrowthX Project Status (both repos)

### Backend (`growthx-backend`) — Complete
- Auth (JWT, bcrypt, HTTPBearer — unified after fixing a dual-scheme bug)
- Users, Profile, Goals, Habits, Daily Progress, Dashboard (CRUD, all ownership-scoped)
- AI Chat (Groq, free) with Context Injection (real profile/goals/habits/progress) and persistent Conversation Memory
- Conversation listing/detail endpoints
- Lightweight RAG: PDF upload → chunk → local embeddings (sentence-transformers) → cosine similarity retrieval → injected into AI chat context (backend files built; Flutter integration for document upload not yet started)

### Frontend (`growthx`) — Habit feature now fully backend-integrated
- Auth flow (login/register) working against real backend
- Habits feature fully rebuilt against real API (this session's work)
- Other local-SQLite-backed features (study, workouts, weight, water, journal) — **not yet migrated**, still using local SQLite, untouched and out of scope for this fix

### Natural Next Steps
1. Commit this Flutter fix
2. Decide whether other SQLite-backed Flutter features (study/workouts/weight/water/journal) should be migrated to the backend too, or remain local-only by design
3. Flutter integration for Document Upload (RAG) and AI Chat screens, if desired
4. Final polish pass: README, screenshots, remove debug `print()` statements
