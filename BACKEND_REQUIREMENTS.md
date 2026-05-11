# SkyTrip — Backend API Requirements
**Date:** 2026-05-11  
**Base URL:** `https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net`  
**Auth:** All protected endpoints require `Authorization: Bearer <token>` header.

---

## What's Already Working ✅

These endpoints are fully wired to the frontend — no changes needed.

| Endpoint | Method | Feature |
|---|---|---|
| `/api/Login/login` | POST | Login |
| `/api/FlightSchedules/Cities` | GET | City list for search |
| `/api/FlightSchedules/oneway` | POST | One-way flight search |
| `/api/FlightSchedules/roundtrip` | POST | Round-trip flight search |
| `/api/PassengerClass/All` | GET | Cabin classes |
| `/api/Triptypes/All` | GET | Trip type list |
| `/api/Country/All` | GET | Country list (passenger form) |
| `/api/BookingTrip` | POST | Create booking |
| `/api/InfoTickets` | POST | Create ticket record |
| `/api/bookings/{bookId}/passengers` | POST | Add passenger (multipart) |
| `/api/Services/All` | GET | Available add-on services |
| `/api/tickets/{ticketId}/services` | POST | Attach service to ticket |
| `/api/tickets/{ticketId}/services` | DELETE | Remove all services from ticket |
| `/api/payments/checkout-session` | POST | Create Stripe checkout session |
| `/api/payments/my/status/{ticketId}` | GET | Poll payment status |
| `/api/BookingTrip/{bookId}/confirm` | POST | Confirm booking after payment |
| `/api/profile/me` | GET | Fetch user profile |
| `/api/profile/me` | PUT | Update profile fields |
| `/api/profile/me/image` | POST | Upload profile avatar |

---

## Critical — App is Broken Without These 🔴

### 1. Fetch User's Tickets
The tickets screen currently shows dummy data. The frontend calls this on every load.

```
GET /api/InfoTickets/my
Authorization: Bearer <token>

Response (array):
[
  {
    "ticketID": 1,
    "bookID": 5,
    "ticketPrice": 150.0,
    "passengersCount": 1,
    "departureCity": "Amman",
    "arrivalCity": "Dubai",
    "flightDate": "2026-06-15T00:00:00Z",
    "departureTime": "10:00:00",
    "arrivalTime": "13:30:00",
    "flightNumber": "RJ501",
    "seatNumber": "14A",
    "status": "Confirmed | Cancelled | Completed",
    "isActive": true
  }
]
```

> **Note:** The frontend maps `status` values as: `"Confirmed"` → upcoming, `"Completed"` → past, `"Cancelled"` → cancelled. The `/api/InfoTickets/my` path was tried and returned 404 — please confirm the correct path.

---

### 2. User Registration
The auth screen has a full registration form (name, email, password) that currently shows "coming soon". This blocks new users from signing up.

```
POST /api/Auth/register

Request:
{
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "password": "string",
  "phone": "string"       // optional
}

Response (same shape as login):
{
  "token": "string",
  "userId": 0,
  "personId": 0,
  "clientId": 0,
  "email": "string",
  "role": "string"
}
```

---

## High Priority — Core Features Incomplete 🟠

### 3. Hotel Search
The hotel booking screen shows 5 hardcoded hotels. The form collects destination, check-in, check-out, rooms, and guests — but submits nowhere.

```
POST /api/Hotels/search

Request:
{
  "destination": "string",
  "checkInDate": "ISO8601",
  "checkOutDate": "ISO8601",
  "numberOfRooms": 1,
  "numberOfGuests": 2
}

Response (array):
[
  {
    "hotelId": "string",
    "hotelName": "string",
    "location": "string",
    "rating": 4.5,
    "pricePerNight": 120.0,
    "roomType": "string",
    "amenities": ["WiFi", "Pool"],
    "imageUrl": "string"    // optional
  }
]
```

### 4. Book a Hotel

```
POST /api/Hotels/{hotelId}/book

Request:
{
  "clientId": 0,
  "checkInDate": "ISO8601",
  "checkOutDate": "ISO8601",
  "numberOfRooms": 1,
  "numberOfGuests": 2,
  "roomType": "string"
}

Response:
{
  "bookingId": "string",
  "confirmationNumber": "string",
  "totalPrice": 0.0
}
```

### 5. Get User's Hotel Bookings
Currently saved locally only — lost on reinstall.

```
GET /api/Hotels/my/bookings
Authorization: Bearer <token>

Response (array):
[
  {
    "id": "string",
    "hotelName": "string",
    "location": "string",
    "checkInDate": "ISO8601",
    "checkOutDate": "ISO8601",
    "numberOfGuests": 2,
    "numberOfRooms": 1,
    "roomType": "string",
    "pricePerNight": 120.0
  }
]
```

---

### 6. Vehicle Rental Search
The van rental screen shows 4 hardcoded vehicles. The search form collects pickup/drop location and dates — but submits nowhere.

```
POST /api/Vehicles/search

Request:
{
  "pickupLocation": "string",
  "dropLocation": "string",
  "pickupDate": "ISO8601",
  "returnDate": "ISO8601",
  "vehicleType": "All | Economy | SUV | Van | Luxury"   // optional filter
}

Response (array):
[
  {
    "vehicleId": "string",
    "name": "string",
    "type": "Economy | SUV | Van | Luxury",
    "seats": 5,
    "bags": 3,
    "rating": 4.5,
    "pricePerDay": 45.0,
    "features": ["AC", "GPS"],
    "imageUrl": "string"    // optional
  }
]
```

### 7. Book a Vehicle

```
POST /api/Vehicles/{vehicleId}/book

Request:
{
  "clientId": 0,
  "pickupLocation": "string",
  "dropLocation": "string",
  "pickupDate": "ISO8601",
  "returnDate": "ISO8601"
}

Response:
{
  "bookingId": "string",
  "confirmationNumber": "string",
  "totalPrice": 0.0,
  "days": 3
}
```

### 8. Get User's Vehicle Bookings
Currently saved locally only — lost on reinstall.

```
GET /api/Vehicles/my/bookings
Authorization: Bearer <token>

Response (array):
[
  {
    "id": "string",
    "vehicleName": "string",
    "vehicleType": "string",
    "seats": 5,
    "bags": 3,
    "rating": 4.5,
    "price": 45.0,
    "features": ["AC"],
    "pickupLocation": "string",
    "dropLocation": "string",
    "pickupDate": "string",
    "returnDate": "string",
    "days": 3,
    "totalPrice": 135.0
  }
]
```

---

## Medium Priority — UX Gaps 🟡

### 9. Promotional Offers
The home screen shows 4 hardcoded offers that never change. These should come from the backend so the marketing team can manage them.

```
GET /api/Offers
Authorization: Bearer <token>

Response (array):
[
  {
    "offerId": "string",
    "title": "string",
    "subtitle": "string",
    "discount": "30%",
    "validUntil": "2026-07-01",
    "colorHex": "#5BB8C8"   // optional, for card background
  }
]
```

---

### 10. Real Seat Map
The seat map screen generates a fake layout and the selection is never saved to the backend.

```
GET /api/FlightSchedules/{flightScheduleId}/seats

Response:
{
  "rows": 30,
  "columns": ["A", "B", "C", "D", "E", "F"],
  "seats": {
    "1A": "available",
    "1B": "occupied",
    "1C": "available"
    // ...
  }
}
```

```
POST /api/FlightSchedules/{flightScheduleId}/seats/reserve

Request:
{
  "ticketId": 0,
  "seatId": "14A"
}

Response:
{
  "success": true,
  "seatId": "14A"
}
```

---

### 11. Contact / Support
The "Contact Us" screen has a form (subject + message) but the submit button does nothing.

```
POST /api/Support/contact

Request:
{
  "clientId": 0,
  "subject": "Booking Issue | Refund Request | Flight Change | Baggage Issue | Other",
  "message": "string"
}

Response:
{
  "ticketId": "string",
  "message": "Your request was received."
}
```

---

## Low Priority — Polish 🟢

### 12. Sync Notification Preferences
Notification toggles (flight updates, price alerts, reminders, promotions, SMS) are UI-only — never saved.

```
GET  /api/profile/preferences
POST /api/profile/preferences

Request/Response:
{
  "flightUpdates": true,
  "priceAlerts": true,
  "bookingReminders": true,
  "promotions": false,
  "smsAlerts": false
}
```

---

## Edits Needed on Existing Endpoints 📝

| Endpoint | Issue | Requested Change |
|---|---|---|
| `GET /api/InfoTickets/my` (or equivalent) | Returns 404 — path unknown | Confirm correct path and that it returns flight details (city names, date, time, flight number) joined with the booking, not just ticket IDs |
| `GET /api/FlightSchedules/...` | Returns `departureCity`/`arrivalCity` as full city name strings | Frontend derives a 3-letter code from the first 3 chars — if IATA codes exist in the response, please include them as `departureCode` / `arrivalCode` |
| `DELETE /api/tickets/{ticketId}/services` | Removes ALL services at once | Would be cleaner to also support `DELETE /api/tickets/{ticketId}/services/{serviceId}` to remove individually |
| `POST /api/BookingTrip` response | Returns `bookID` or `bookId` inconsistently | Please standardise casing — frontend handles both but one is preferred |

---

## Technical Constraints (Frontend Side)

- All requests timeout after **20 seconds**.
- Errors must include either `detail` or `title` in the JSON body — the frontend displays these directly to the user.
- `401` responses automatically log the user out and redirect to the login screen.
- File uploads use `multipart/form-data`; everything else is `application/json`.
- Dates should be **ISO 8601** strings. Times should be `"HH:mm:ss"` or `"HH:mm"`.
