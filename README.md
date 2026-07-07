# KampalaCart - E-Commerce Platform for Uganda

A production-ready, full-featured e-commerce platform designed specifically for Uganda, built with Flutter, NestJS, PostgreSQL, and Firebase.

## 🚀 Features

### Core Features
- **Multi-platform Support**: Android, iOS, and Web from a single Flutter codebase
- **User Management**: Buyers, sellers, and admin accounts with role-based access
- **Product Catalog**: Complete product management with categories and filtering
- **Advanced Search**: Full-text search with multiple filters and sorting
- **Shopping Experience**: Cart, wishlist, and secure checkout
- **Payment Integration**: MTN Mobile Money, Airtel Money, and Flutterwave (cards)
- **Order Management**: Order tracking, delivery updates, and history
- **Reviews & Ratings**: Product and seller reviews with ratings
- **Discounts & Coupons**: Promotional codes and seasonal discounts
- **Notifications**: Real-time push notifications and in-app alerts
- **Chat System**: Direct messaging between buyers and sellers
- **Analytics Dashboard**: Sales metrics, user behavior, and performance insights
- **AI Recommendations**: Personalized product recommendations
- **Admin Dashboard**: Complete platform management and moderation

## 📁 Project Structure

```
KampalaCart/
├── backend/                 # NestJS backend application
├── frontend/                # Flutter mobile & web app
├── docker-compose.yml       # Development environment setup
├── .github/                 # GitHub Actions workflows
└── docs/                    # Documentation
```

## 🏗️ Tech Stack

**Backend**
- NestJS (Node.js framework)
- PostgreSQL (relational database)
- TypeORM (ORM)
- Passport.js (authentication)
- Firebase Admin SDK
- Socket.io (real-time communication)
- Flutterwave API (payment processing)

**Frontend**
- Flutter 3.x
- Riverpod (state management)
- Firebase SDK
- Google Maps Flutter
- Flutterwave Flutter

**Infrastructure**
- Docker & Docker Compose
- Firebase (Auth, Storage, FCM)
- PostgreSQL
- Redis (caching & sessions)
- GitHub Actions (CI/CD)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x
- Node.js 18+
- PostgreSQL 14+
- Docker & Docker Compose

### Development Setup

```bash
# Clone repository
git clone https://github.com/sadinho0samuel-maker/KampalaCart.git
cd KampalaCart

# Start development environment
docker-compose up -d

# Backend setup
cd backend
npm install
npm run typeorm migration:run
npm run start:dev

# Frontend setup
cd frontend
flutter pub get
flutterfire configure
flutter run
```

## 📱 API Documentation

API documentation available at `http://localhost:3000/api/docs`

## 🔒 Security

- JWT token-based authentication
- Firebase Auth for multi-factor authentication
- HTTPS/TLS encryption
- Password hashing with bcrypt
- SQL injection prevention
- CORS configuration
- Rate limiting
- Input validation and sanitization

## 🧪 Testing

```bash
# Backend tests
cd backend
npm run test
npm run test:e2e

# Frontend tests
cd frontend
flutter test
```

## 📄 License

MIT License - see LICENSE file for details

---

**Built with ❤️ for Uganda**
