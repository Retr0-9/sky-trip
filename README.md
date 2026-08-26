# SkyTrip ✈️

SkyTrip is a full-stack flight booking platform consisting of a Flutter mobile app, a web frontend, and an ASP.NET backend. It covers the complete booking lifecycle — from search and payment to document approval and e-ticket issuance.

## Features

- 🔍 Flight search and booking
- 💳 Stripe payment integration (hybrid deep-link + polling flow)
- 📄 Document upload and approval workflow
- 🎫 QR-based digital boarding passes
- 📧 Automated email notifications (via Resend)
- 🧾 PDF ticket generation
- 🔐 User authentication

## Booking Lifecycle

Bookings move through a well-defined state machine:

```
DRAFT → PENDING_PAYMENT → PAID → PENDING_REVIEW → APPROVED → TICKET_ISSUED
```

## Tech Stack

| Layer            | Technology                          |
|-------------------|--------------------------------------|
| Mobile App         | Flutter / Dart (Provider state mgmt) |
| Web Frontend        | HTML, CSS, JavaScript               |
| Backend API         | ASP.NET                             |
| Hosting (Web)       | Firebase                            |
| Hosting (Backend)   | Azure                                |
| Payments            | Stripe                              |
| Email               | Resend                              |

## Project Structure

```
skytrip/
├── lib/             # Flutter mobile application
├── web/             # Web frontend (HTML/CSS/JS)
├── swagger.spec     # ASP.NET backend API
└── docs/            # design docs
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- .NET SDK
- Node.js (for web tooling, if applicable)
- Firebase CLI

### Mobile App

```bash
cd lib
flutter pub get
flutter run main.dart
```

### Web Frontend

```bash
cd web
firebase serve
```

## Team

- **Frontend (Web & Mobile):** [Talal Ali & Tasneem Hashlmoon]
- **Backend:** [Ali Rami Alaidi]

## License

This project was developed as a graduation project and is not currently licensed for commercial use.
