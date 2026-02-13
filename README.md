# BudgetMint

A personal finance iOS app that connects to your bank accounts via Plaid to automatically sync transactions, track spending, and manage budgets.

## Features

- **Bank Account Linking** — Connect bank accounts securely through Plaid
- **Transaction Syncing** — Automatically import and categorize transactions
- **Balance Tracking** — View real-time account balances
- **Spending Insights** — Visualize spending with interactive pie charts
- **Budget Categories** — Organize expenses into custom categories
- **Firebase Auth** — Secure user authentication

## Tech Stack

- **iOS App**: Swift / SwiftUI
- **Backend**: Firebase Cloud Functions (TypeScript)
- **Database**: Cloud Firestore
- **Banking API**: Plaid

## Project Structure

```
BudgetMint/
├── BudgetMint/              # iOS app (Swift)
│   ├── Models/              # Data models (Account, Transaction, BudgetCategory)
│   ├── Services/            # Auth, Firestore, and Plaid services
│   ├── Views/               # SwiftUI views (Dashboard, Accounts, Transactions)
│   └── Utilities/           # Extensions and helpers
├── functions/               # Firebase Cloud Functions (TypeScript)
│   └── src/                 # createLinkToken, exchangePublicToken, syncTransactions, etc.
├── firebase.json            # Firebase configuration
└── firestore.rules          # Firestore security rules
```

## Setup

### Prerequisites

- Xcode 15+
- Node.js 20
- Firebase CLI (`npm install -g firebase-tools`)
- A Firebase project
- A Plaid developer account

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/bwbishop-max/BudgetMint.git
   cd BudgetMint
   ```

2. Install Cloud Functions dependencies:
   ```bash
   cd functions
   npm install
   ```

3. Create `functions/.env` with your Plaid credentials:
   ```
   PLAID_CLIENT_ID=your_client_id
   PLAID_SECRET=your_secret
   ```

4. Add your `GoogleService-Info.plist` to the Xcode project.

5. Deploy Firebase:
   ```bash
   firebase deploy --only functions,firestore:rules
   ```

6. Open the Xcode project and run on a simulator or device.
