# Writing style

- Write in ASD-STE100 Simplified Technical English (STE).
- Use US English (en-US) spelling and words. Do not use UK English (en-GB). For example, write "color" and not "colour", and write "serialize" and not "serialise".

# Time-aware APIs

Use these rules for all API parameters that contain a date, a datetime, a date range, or a datetime range.

## Date and date range

- Use `YYYY-MM-DD` strings. If the value contains a time, return a validation error.
- A date range includes the start date and the end date. For example, `from=2026-03-01&to=2026-03-31` includes all of March.
- Keep the value as a calendar date through the API and business layers. Change it to a timestamp only in the storage layer, where you compare it with stored timestamps.
- When you change a date to a timestamp, use the resource timezone. The resource timezone is the IANA timezone of the resource that owns the data (for example, `Europe/Copenhagen` for a resource in Denmark).
  - Get the resource timezone on the server. The caller must not supply the timezone.
  - Do not hard-code a UTC offset, because offsets change with daylight saving time (DST).
  - A single date becomes `[date, date + 1 day)`. A range becomes `[from, to + 1 day)`.
- If the stored column is a date and not a timestamp, compare the dates directly. Do not convert them.
- In the frontend, send the literal string from the date-picker. Do not serialize a JS `Date` object.
- Use the same timezone in the UI, exports, and reports. Do not use the timezone of the user.

## Datetime and datetime range

- Use RFC 3339 values with an explicit offset (`Z` or `+01:00`). If a value has no offset, return a validation error.
- A datetime range includes `from` and does not include `to`: `[from, to)`.
- In the backend, parse the offset that the caller supplies and convert the value to UTC. Do not apply the resource timezone.
- In the frontend, serialize values with the current UTC offset of the user.
- Use datetime ranges only for sub-day precision (for example, audit logs or event streams). For calendar-day filters, use date ranges.

## Shared rules

- In range queries, use `>=` for the start and `<` for the end. Do not use `BETWEEN`.
- Store and compare timestamps in UTC.
- Show a timezone label on timestamps in the UI, in exports, and in reports.
- Do not change the date handling of an existing endpoint. Add a new API version. Document the change. Set a deprecation date for the old version.

|                | Date              | Date range        | Datetime             | Datetime range       |
| -------------- | ----------------- | ----------------- | -------------------- | -------------------- |
| Format         | `YYYY-MM-DD`      | `YYYY-MM-DD`      | RFC 3339 with offset | RFC 3339 with offset |
| API boundaries | one date          | `[from, to]`      | one instant          | `[from, to)`         |
| Query interval | `[d, d+1)`        | `[from, to+1)`    | instant              | `[from, to)`         |
| Timezone       | resource timezone | resource timezone | offset from caller   | offset from caller   |
| Go type        | `civil.Date`      | `civil.Date`      | `time.Time`          | `time.Time`          |

# Code standards

## Go

- Use the tools of the `gopls` MCP server. Do not write your own code for a task that these tools can do.

### Time-aware APIs

- Use `cloud.google.com/go/civil` for values that have no timezone:
  - `civil.Date` for calendar dates. Parse with `civil.ParseDate`.
  - `civil.Time` for a time of day that has no date or timezone (for example, a cut-off time of 14:30).
  - `civil.DateTime` for a date and time of day that has no timezone (for example, 2026-03-18 14:30 in the resource timezone). To make one from a date and a time, use `civil.DateTime{Date: d, Time: t}`.
- Use `time.Time` only for a value that has a date, a time of day, and a timezone.
- Do not change a `civil.Date`, `civil.Time`, or `civil.DateTime` to a `time.Time` at the API boundary. The handler parses the value to the `civil` type and passes it to the business layer unchanged.
- Change a `civil` value to `time.Time` only in the layer that needs an instant, usually the storage layer:
  - Load the timezone with `time.LoadLocation` and the IANA name.
  - Date range: start `from.In(loc)`, end `to.AddDays(1).In(loc)`.
  - Date and time: `dt.In(loc)`.
- The API must not accept a `civil.DateTime`. A datetime without an offset is ambiguous, so the API returns a validation error for it. Use `civil.DateTime` only inside the backend.
- Parse datetime values from the API with `time.Parse(time.RFC3339, s)`. These values are instants, so use `time.Time`.
