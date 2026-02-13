# Mint Personal Finance App — Complete Research & Rebuild Blueprint

## 1. History & Timeline

**Founded:** 2006–2007 by **Aaron Patzer** in Mountain View, CA  
**Original name:** Mint.com  
**Account aggregation:** Originally powered by **Yodlee**; switched to Intuit's own system post-acquisition  
**Funding:** $31M+ in venture capital from DAG Ventures, Shasta Ventures, First Round Capital, and angel investor Ram Shriram (early Google investor). Last round of $14M closed August 2009 at ~$140M valuation.  
**Employees at acquisition:** ~35  

**Key milestones:**
- **2007** — Launched as a free personal money management web app
- **Sept 2009** — Intuit announced acquisition for **$170 million**
- **Nov 2009** — Acquisition completed; Aaron Patzer became VP/GM of Intuit Personal Finance Group
- **2010** — Connected to 16,000+ US/Canadian financial institutions, 17M+ individual accounts
- **2011** — Replaced Intuit's Online Quicken product
- **Dec 2012** — Patzer left Intuit
- **2016** — Reported 20M+ users; bill tracking added
- **2017** — Mint Bills (formerly Pageonce/Check) integrated; JPMorgan Chase data-sharing agreement
- **2018** — Bill payment service discontinued
- **2019** — Intuit consumer sector (Mint + TurboTax) had $2.775B revenue
- **2020** — 13M registered users; Intuit acquired Credit Karma
- **2021** — 3.6M monthly active users
- **Oct 31, 2023** — Intuit announced Mint shutdown, users directed to Credit Karma
- **Mar 23, 2024** — Mint officially ceased operations

**Why it shut down:** Intuit consolidated consumer finance products under Credit Karma (130M users). A free personal finance app has high per-user costs (data aggregation fees from Plaid/Finicity/Yodlee) and Mint's free model relied on lead generation/referral fees that couldn't justify continued investment alongside Credit Karma's larger platform.

---

## 2. Complete Feature Set

### 2.1 Core: Account Aggregation
- Link bank accounts, credit cards, investment accounts, loans, mortgage, retirement accounts from **17,000+ financial institutions**
- Single dashboard view of all accounts
- Real-time balance updates
- Net worth calculation across all accounts
- Support for Coinbase/crypto tracking (later addition)

### 2.2 Transaction Management
- **Auto-import** of transactions from all linked accounts
- **Auto-categorization** using ML/rules into predefined categories
- **Rule engine:** "Always categorize [merchant] as [category]" — remembers and applies going forward
- **Manual re-categorization** with persistence
- **Transaction splitting** — split a single transaction across multiple categories (e.g., Target purchase split between Groceries, Clothing, Pharmacy)
- **Transaction search & filter** by date, amount, category, merchant, account
- **Transaction renaming** — clean up messy merchant names
- **Transfer detection** — automatically identified credit card payments and inter-account transfers, hiding them from budget reports
- **Cash/ATM tracking** — separated ATM withdrawals (e.g., $100 cash + $2 fee)
- **Manual transaction entry** for cash purchases
- **Transaction tagging** — custom tags for additional organization beyond categories

### 2.3 Budgeting
- **Category-based monthly budgets** with spending limits per category
- **Budget suggestions** based on historical spending patterns
- **Visual progress bars** — green/yellow/red indicating budget status
- **Over/under budget tracking** with month-to-month comparison
- **Rollover budgets** — unspent amounts could roll to next month
- **Daily budget planner** — suggested daily spending allowance
- **Income vs. expense overview** — monthly cash flow summary

### 2.4 Spending Analysis & Trends
- **Spending by category** — pie chart with drill-down to individual transactions
- **Spending by merchant** — identify top merchants
- **Monthly/quarterly/yearly trend reports** — compare spending over time
- **MintSights** (later feature) — AI-powered actionable insights about spending patterns, month-over-month comparisons, and savings opportunities
- **Income tracking** — paycheck detection and income trend analysis
- **Cash flow visualization** — income vs. expenses over time

### 2.5 Bills & Subscriptions
- **Bill tracker** — all upcoming bills in one view
- **Due date reminders** via push notification and email
- **Subscription detection** — automatically identified recurring charges
- **Price increase alerts** — notified when subscriptions increased
- **Late fee warnings** — alerts for missed or upcoming payments
- **Low balance alerts** — warned before account balances got too low

### 2.6 Financial Goals
- **Goal creation** — pay off credit card debt, save for home, emergency fund, vacation, etc.
- **Pre-set goal templates** + custom goals
- **Deadline setting** with monthly savings suggestions
- **Progress tracking** — visual progress bar toward each goal
- **Multiple simultaneous goals**
- **Goal integration with budget** — reflected in monthly budgeting

### 2.7 Investment Tracking
- **Portfolio overview** — linked brokerage/retirement accounts
- **Market benchmark comparison** — track portfolio against indices
- **Asset allocation view**
- **Investment performance tracking**
- **Bitcoin/crypto tracking** via Coinbase partnership

### 2.8 Credit Score
- **Free credit score** — TransUnion VantageScore
- **Score factors** — what's helping/hurting your score
- **Payment history view**
- **Credit age tracking**
- **Credit monitoring** (premium: Mint Credit Monitor at $16.99/mo with full reports from all 3 bureaus + Equifax Risk Score)

### 2.9 Alerts & Notifications
- Large transaction alerts
- Suspicious activity alerts
- ATM fee alerts
- Over-budget alerts
- Bill due date reminders
- Low balance warnings
- Subscription price increase alerts
- Weekly spending summary emails

### 2.10 UI/UX Design
- **Overview/Dashboard page** — at-a-glance view: account balances, credit score, cash flow, spending chart
- **Tab-based navigation**: Overview, Transactions, Budgets, Goals, Trends, Bills, Credit Score, Investments
- **Spending pie chart** — color-coded by category, tappable for drill-down
- **Budget progress bars** — red/yellow/green color coding
- **Clean, minimal design** with lots of white space
- **Dark mode** (later addition)
- **Touch ID / Face ID** for app security
- **4-digit PIN** backup security
- **Available on iOS, Android, and web**
- **Responsive web dashboard** with same data across platforms

---

## 3. Complete Category & Subcategory List

Mint had **hundreds of default categories** organized into parent categories with subcategories. Users could add custom subcategories under any parent. Here is the reconstructed list:

### Income
- Paycheck
- Investment Income
- Returned Purchase
- Bonus
- Interest Income
- Reimbursement
- Rental Income

### Transfer
- Credit Card Payment
- Transfer for Cash Spending
- Mortgage Payment

### Auto & Transport
- Auto Insurance
- Auto Payment
- Gas & Fuel
- Parking
- Public Transportation
- Service & Parts
- Ride Share (Uber/Lyft)

### Bills & Utilities
- Home Phone
- Internet
- Mobile Phone
- Television
- Utilities (Gas/Electric/Water)
- Trash

### Business Services
- Advertising
- Legal
- Office Supplies
- Printing
- Shipping

### Education
- Books & Supplies
- Student Loan
- Tuition

### Entertainment
- Amusement
- Arts
- Movies & DVDs
- Music
- Newspapers & Magazines

### Fees & Charges
- ATM Fee
- Bank Fee
- Finance Charge
- Late Fee
- Service Fee
- Trade Commissions

### Financial
- Financial Advisor
- Life Insurance

### Food & Dining
- Alcohol & Bars
- Coffee Shops
- Fast Food
- Groceries
- Restaurants

### Gifts & Donations
- Charity
- Gift

### Health & Fitness
- Dentist
- Doctor
- Eyecare
- Gym
- Health Insurance
- Pharmacy
- Sports

### Home
- Furnishings
- Home Improvement
- Home Insurance
- Home Services
- Home Supply
- Lawn & Garden
- Mortgage & Rent

### Kids
- Allowance
- Baby Supplies
- Babysitter & Daycare
- Child Support
- Kids Activities
- Toys

### Misc Expenses
- (User-defined subcategories)

### Personal Care
- Hair
- Laundry
- Spa & Massage

### Pets
- Pet Food & Supplies
- Pet Grooming
- Veterinary

### Shopping
- Books
- Clothing
- Electronics & Software
- Hobbies
- Sporting Goods

### Taxes
- Federal Tax
- Local Tax
- Property Tax
- Sales Tax
- State Tax

### Travel
- Air Travel
- Hotel
- Rental Car & Taxi
- Vacation

### Uncategorized
- (Catch-all for unrecognized transactions)

### Hide from Budgets & Trends
- (Internal transfers, credit card payments)

---

## 4. Technical Architecture (Original Mint)

### Backend
- **Account aggregation:** Originally Yodlee → Intuit's proprietary system
- **Data storage:** User credentials stored in encrypted/decryptable format (raised security concerns)
- **Revenue model:** Lead generation via personalized financial product recommendations (credit cards, bank accounts, loans)
- **API:** No public API was offered to end users

### Security
- VeriSign security scanning for data transfer
- Multi-factor authentication
- 4-digit PIN or Touch ID/Face ID
- 256-bit encryption
- Read-only access (Mint could never move money)
- JPMorgan Chase partnership (2017) — Chase customers could share data without Mint storing credentials

---

## 5. Rebuild Strategy for Personal Use with Claude Code

### 5.1 Recommended Architecture: iOS App + Backend

**Frontend: Native iOS (Swift/SwiftUI)**
- SwiftUI for modern, declarative UI
- Charts framework for spending visualizations
- Core Data or SwiftData for local persistence / offline access
- Combine/async-await for reactive data flow

**Backend Options (ranked by simplicity for personal use):**

1. **Firebase (Firestore + Cloud Functions)** — You already know this from LoungeAdvisor
   - Firestore for transaction/budget/category data
   - Cloud Functions for Plaid webhook handling and transaction sync
   - Firebase Auth for login
   - Minimal server management

2. **Supabase** — Open-source Firebase alternative
   - PostgreSQL database (more powerful queries for financial data)
   - Edge Functions for Plaid integration
   - Built-in auth

3. **Self-hosted (Node.js/Express + SQLite/PostgreSQL)**
   - Maximum control and privacy
   - Can run on a Raspberry Pi or cheap VPS
   - SQLite for personal use is perfectly adequate

### 5.2 Bank Connection: Plaid API

**Plaid is the modern equivalent of what Yodlee did for Mint.**

**Pricing for personal use:**
- **Free tier:** 200 API calls in Limited Production (enough to get started and test)
- **Pay as you go:** After free tier, transaction sync costs vary
- **For a personal app with a few linked accounts, costs should be minimal** — Plaid charges per Item (linked account), not per transaction query

**Key Plaid Products you'd use:**
- **Transactions** — Pull categorized transaction history (up to 24 months). Plaid auto-categorizes with merchant name, category, and location
- **Auth** — Verify account ownership
- **Balance** — Real-time account balances
- **Investments** — Brokerage/retirement holdings and transactions
- **Liabilities** — Credit card, mortgage, student loan details

**iOS Integration:**
- Plaid Link SDK for iOS (Swift) — drop-in UI for users to connect banks
- Server-side: Exchange `public_token` for `access_token`, store securely
- Webhook-based transaction sync (Plaid pushes new transactions to your server)

### 5.3 Suggested Data Model

```
Users
├── id, email, name, created_at

Accounts (linked via Plaid)
├── id, user_id, plaid_item_id, plaid_account_id
├── name, type (checking/savings/credit/investment/loan)
├── institution_name, current_balance, available_balance
├── last_synced_at

Transactions
├── id, account_id, user_id
├── plaid_transaction_id (for dedup)
├── date, amount, merchant_name
├── category_id, subcategory_id
├── original_category (from Plaid)
├── is_pending, is_transfer
├── notes, tags[]
├── created_at, updated_at

Categories
├── id, user_id, name, parent_id (null for top-level)
├── icon, color, is_system (default vs custom)
├── budget_amount (monthly default)

Budgets
├── id, user_id, category_id
├── month (YYYY-MM), amount
├── rollover (boolean)

Goals
├── id, user_id, name, target_amount
├── current_amount, deadline
├── linked_account_id (optional)
├── status (active/completed/paused)

CategoryRules (auto-categorization)
├── id, user_id
├── merchant_pattern (regex or exact match)
├── target_category_id
├── priority

RecurringTransactions (subscriptions/bills)
├── id, user_id, merchant_name
├── amount, frequency (monthly/weekly/yearly)
├── next_due_date, category_id
├── alert_enabled
```

### 5.4 Key Features to Build (Priority Order)

**Phase 1 — MVP (Core Mint)**
1. Plaid integration — link bank accounts
2. Transaction import & display (list view with search/filter)
3. Auto-categorization (leverage Plaid's categories + custom rules)
4. Category management (add/edit/delete, subcategories)
5. Monthly spending dashboard (pie chart, category breakdown)
6. Account balances overview
7. Net worth calculation

**Phase 2 — Budgeting**
8. Category-based monthly budgets with progress bars
9. Budget vs. actual comparison
10. Over-budget alerts (local notifications)
11. Transaction splitting across categories
12. Transaction renaming and rule creation
13. Monthly/yearly trend charts

**Phase 3 — Bills & Goals**
14. Recurring transaction detection
15. Bill due date reminders
16. Subscription tracking with price change alerts
17. Financial goals with progress tracking
18. Cash flow forecasting

**Phase 4 — Polish**
19. Credit score display (if desired — can use a separate API)
20. Investment portfolio tracking (Plaid Investments)
21. Data export (CSV)
22. Widgets (iOS home screen)
23. Apple Watch companion (balance glance)
24. Dark mode
25. Face ID / passcode lock

### 5.5 Open Source References

These projects can serve as code references when building:

| Project | Stack | Notes |
|---------|-------|-------|
| [Maybe](https://github.com/maybe-finance/maybe) | Rails + React | Full-featured, AI-powered PFM. Great UI reference |
| [Financial Freedom](https://github.com/serversideup/financial-freedom) | Laravel + Vue.js | Open-source Mint/YNAB alternative |
| [Budget Board](https://github.com/teelur/budget-board) | C# + React | Self-hosted, auto bank sync |
| [Mintable](https://github.com/kevinschaich/mintable) | Node.js | Plaid → Google Sheets automation |
| [Firefly III](https://github.com/firefly-iii/firefly-iii) | PHP/Laravel | Mature self-hosted PFM, no bank sync but great data model |
| [Ghostfolio](https://github.com/ghostfolio/ghostfolio) | Angular + NestJS | Investment-focused tracker |

### 5.6 Plaid Quick-Start Code (Server Side — Node.js)

```javascript
const { PlaidApi, Configuration, PlaidEnvironments } = require('plaid');

const config = new Configuration({
  basePath: PlaidEnvironments.development, // or .production
  baseOptions: {
    headers: {
      'PLAID-CLIENT-ID': process.env.PLAID_CLIENT_ID,
      'PLAID-SECRET': process.env.PLAID_SECRET,
    },
  },
});

const plaidClient = new PlaidApi(config);

// 1. Create link token (call from your iOS app)
async function createLinkToken(userId) {
  const response = await plaidClient.linkTokenCreate({
    user: { client_user_id: userId },
    client_name: 'BudgetMint',
    products: ['transactions'],
    country_codes: ['US'],
    language: 'en',
  });
  return response.data.link_token;
}

// 2. Exchange public token (after user links account)
async function exchangePublicToken(publicToken) {
  const response = await plaidClient.itemPublicTokenExchange({
    public_token: publicToken,
  });
  return {
    accessToken: response.data.access_token,
    itemId: response.data.item_id,
  };
}

// 3. Fetch transactions
async function getTransactions(accessToken, startDate, endDate) {
  const response = await plaidClient.transactionsGet({
    access_token: accessToken,
    start_date: startDate, // 'YYYY-MM-DD'
    end_date: endDate,
  });
  return response.data.transactions; // Each has: amount, date, name, category[], merchant_name, etc.
}

// 4. Get account balances
async function getBalances(accessToken) {
  const response = await plaidClient.accountsBalanceGet({
    access_token: accessToken,
  });
  return response.data.accounts;
}
```

### 5.7 Claude Code Prompt Strategy

When working with Claude Code, consider structuring the project as:

```
BudgetMint/
├── BudgetMint/              # iOS app (SwiftUI)
│   ├── Models/              # Data models, Core Data entities
│   ├── Views/               # SwiftUI views
│   │   ├── Dashboard/       # Overview, net worth, cash flow
│   │   ├── Transactions/    # Transaction list, search, detail
│   │   ├── Budgets/         # Budget setup, progress
│   │   ├── Goals/           # Financial goals
│   │   ├── Accounts/        # Linked accounts, Plaid Link
│   │   └── Settings/        # Categories, rules, preferences
│   ├── Services/            # API clients, Plaid service
│   ├── Utilities/           # Extensions, helpers
│   └── Resources/           # Assets, colors, fonts
├── Server/                  # Node.js/Express backend
│   ├── routes/              # API endpoints
│   ├── services/            # Plaid integration, sync logic
│   ├── models/              # Database models
│   └── webhooks/            # Plaid webhook handlers
└── README.md
```

---

## 6. Key Lessons from Mint's Success & Failure

**What made Mint great:**
- Zero friction onboarding — link accounts and see value immediately
- Auto-categorization reduced manual work to near-zero
- Clean, visual UI with spending pie charts and color-coded budgets
- Free (lowered barrier to entry for millions)
- Rule engine that "learned" your preferences over time
- Comprehensive — one place for everything financial

**What users complained about:**
- Auto-categorization was imperfect, required regular cleanup
- No CSV/data export (fixed later)
- Bank connectivity issues (accounts becoming unlinked)
- Intrusive ads and product recommendations
- Couldn't set different budgets per month
- No way to handle cash spending elegantly
- Spending chart only showed current month (no multi-month comparison initially)

**What killed it:**
- Free model couldn't sustain data aggregation costs
- Intuit prioritized Credit Karma's 130M users over Mint's 3.6M active users
- Became an "advertising company" rather than a finance company
- Original team (including Patzer) left shortly after acquisition

**Your advantage building for personal use:**
- No monetization concerns — build exactly what you need
- No ads, no product recommendations
- Can use Plaid's free/low-cost tier for just your accounts
- Total data privacy and control
- Can iterate rapidly with Claude Code

---

## 7. Plaid Complete Transaction Response (Sample JSON)

This is the actual shape of data you'll receive from Plaid — critical for building your data model:

```json
{
  "account_id": "ybV8yjea61u8XjY5EXPLuEYRnV5MAwcOZbzOZ",
  "account_owner": null,
  "amount": 5.99,
  "authorized_date": "2021-06-30",
  "category": ["Service", "Subscription"],
  "category_id": "18061000",
  "date": "2021-07-01",
  "datetime": null,
  "iso_currency_code": "USD",
  "location": {
    "address": null,
    "city": null,
    "country": null,
    "lat": null,
    "lon": null,
    "postal_code": null,
    "region": null,
    "store_number": null
  },
  "merchant_name": "Hulu",
  "merchant_entity_id": "unique-plaid-merchant-id",
  "name": "HLU*Hulu 1541146425727-U HULU.COM/BILLCA",
  "payment_channel": "online",
  "pending": false,
  "pending_transaction_id": "NpZnO8VyJmu97X1qY7D8Hp6mbARE56fRaOV71",
  "personal_finance_category": {
    "primary": "ENTERTAINMENT",
    "detailed": "ENTERTAINMENT_TV_AND_MOVIES",
    "confidence_level": "VERY_HIGH"
  },
  "personal_finance_category_icon_url": "https://plaid-category-icons.plaid.com/PFC_ENTERTAINMENT.png",
  "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
  "website": "hulu.com",
  "logo_url": "https://plaid-merchant-logos.plaid.com/hulu_619.png"
}
```

**Key fields for your app:**
- `amount` — Transaction amount (positive = debit/spend, negative = credit/income)
- `date` — Posted date (YYYY-MM-DD)
- `merchant_name` — Clean merchant name (use this over `name`)
- `name` — Raw transaction description (messy, but useful for rules)
- `personal_finance_category.primary` — Broad category (use this for budgets)
- `personal_finance_category.detailed` — Specific category
- `payment_channel` — "online", "in store", "other"
- `pending` — Whether transaction is still pending
- `website` — Merchant website
- `logo_url` — Merchant logo (100x100 PNG)

---

## 8. Plaid Personal Finance Categories (Complete PFCv1 Taxonomy)

**16 primary categories, 104 detailed subcategories.** This is what Plaid auto-assigns to every transaction — you get this for FREE with every transaction pull:

### INCOME (7)
- INCOME_DIVIDENDS — Dividends from investment accounts
- INCOME_INTEREST_EARNED — Interest on savings
- INCOME_RETIREMENT_PENSION — Pension payments
- INCOME_TAX_REFUND — Tax refunds
- INCOME_UNEMPLOYMENT — Unemployment benefits
- INCOME_WAGES — Salaries, gig-economy, tips
- INCOME_OTHER_INCOME — Alimony, social security, child support, rental

### TRANSFER_IN (6)
- TRANSFER_IN_CASH_ADVANCES_AND_LOANS
- TRANSFER_IN_DEPOSIT — Cash, checks, ATM deposits
- TRANSFER_IN_INVESTMENT_AND_RETIREMENT_FUNDS
- TRANSFER_IN_SAVINGS
- TRANSFER_IN_ACCOUNT_TRANSFER
- TRANSFER_IN_OTHER_TRANSFER_IN

### TRANSFER_OUT (5)
- TRANSFER_OUT_INVESTMENT_AND_RETIREMENT_FUNDS
- TRANSFER_OUT_SAVINGS
- TRANSFER_OUT_WITHDRAWAL
- TRANSFER_OUT_ACCOUNT_TRANSFER
- TRANSFER_OUT_OTHER_TRANSFER_OUT

### LOAN_PAYMENTS (6)
- LOAN_PAYMENTS_CAR_PAYMENT
- LOAN_PAYMENTS_CREDIT_CARD_PAYMENT
- LOAN_PAYMENTS_PERSONAL_LOAN_PAYMENT
- LOAN_PAYMENTS_MORTGAGE_PAYMENT
- LOAN_PAYMENTS_STUDENT_LOAN_PAYMENT
- LOAN_PAYMENTS_OTHER_PAYMENT

### BANK_FEES (6)
- BANK_FEES_ATM_FEES
- BANK_FEES_FOREIGN_TRANSACTION_FEES
- BANK_FEES_INSUFFICIENT_FUNDS
- BANK_FEES_INTEREST_CHARGE
- BANK_FEES_OVERDRAFT_FEES
- BANK_FEES_OTHER_BANK_FEES

### ENTERTAINMENT (6)
- ENTERTAINMENT_CASINOS_AND_GAMBLING
- ENTERTAINMENT_MUSIC_AND_AUDIO
- ENTERTAINMENT_SPORTING_EVENTS_AMUSEMENT_PARKS_AND_MUSEUMS
- ENTERTAINMENT_TV_AND_MOVIES
- ENTERTAINMENT_VIDEO_GAMES
- ENTERTAINMENT_OTHER_ENTERTAINMENT

### FOOD_AND_DRINK (7)
- FOOD_AND_DRINK_BEER_WINE_AND_LIQUOR
- FOOD_AND_DRINK_COFFEE
- FOOD_AND_DRINK_FAST_FOOD
- FOOD_AND_DRINK_GROCERIES
- FOOD_AND_DRINK_RESTAURANT
- FOOD_AND_DRINK_VENDING_MACHINES
- FOOD_AND_DRINK_OTHER_FOOD_AND_DRINK

### GENERAL_MERCHANDISE (14)
- GENERAL_MERCHANDISE_BOOKSTORES_AND_NEWSSTANDS
- GENERAL_MERCHANDISE_CLOTHING_AND_ACCESSORIES
- GENERAL_MERCHANDISE_CONVENIENCE_STORES
- GENERAL_MERCHANDISE_DEPARTMENT_STORES
- GENERAL_MERCHANDISE_DISCOUNT_STORES
- GENERAL_MERCHANDISE_ELECTRONICS
- GENERAL_MERCHANDISE_GIFTS_AND_NOVELTIES
- GENERAL_MERCHANDISE_OFFICE_SUPPLIES
- GENERAL_MERCHANDISE_ONLINE_MARKETPLACES
- GENERAL_MERCHANDISE_PET_SUPPLIES
- GENERAL_MERCHANDISE_SPORTING_GOODS
- GENERAL_MERCHANDISE_SUPERSTORES
- GENERAL_MERCHANDISE_TOBACCO_AND_VAPE
- GENERAL_MERCHANDISE_OTHER_GENERAL_MERCHANDISE

### HOME_IMPROVEMENT (5)
- HOME_IMPROVEMENT_FURNITURE
- HOME_IMPROVEMENT_HARDWARE
- HOME_IMPROVEMENT_REPAIR_AND_MAINTENANCE
- HOME_IMPROVEMENT_SECURITY
- HOME_IMPROVEMENT_OTHER_HOME_IMPROVEMENT

### MEDICAL (7)
- MEDICAL_DENTAL_CARE
- MEDICAL_EYE_CARE
- MEDICAL_NURSING_CARE
- MEDICAL_PHARMACIES_AND_SUPPLEMENTS
- MEDICAL_PRIMARY_CARE
- MEDICAL_VETERINARY_SERVICES
- MEDICAL_OTHER_MEDICAL

### PERSONAL_CARE (4)
- PERSONAL_CARE_GYMS_AND_FITNESS_CENTERS
- PERSONAL_CARE_HAIR_AND_BEAUTY
- PERSONAL_CARE_LAUNDRY_AND_DRY_CLEANING
- PERSONAL_CARE_OTHER_PERSONAL_CARE

### GENERAL_SERVICES (9)
- GENERAL_SERVICES_ACCOUNTING_AND_FINANCIAL_PLANNING
- GENERAL_SERVICES_AUTOMOTIVE
- GENERAL_SERVICES_CHILDCARE
- GENERAL_SERVICES_CONSULTING_AND_LEGAL
- GENERAL_SERVICES_EDUCATION
- GENERAL_SERVICES_INSURANCE
- GENERAL_SERVICES_POSTAGE_AND_SHIPPING
- GENERAL_SERVICES_STORAGE
- GENERAL_SERVICES_OTHER_GENERAL_SERVICES

### GOVERNMENT_AND_NON_PROFIT (4)
- GOVERNMENT_AND_NON_PROFIT_DONATIONS
- GOVERNMENT_AND_NON_PROFIT_GOVERNMENT_DEPARTMENTS_AND_AGENCIES
- GOVERNMENT_AND_NON_PROFIT_TAX_PAYMENT
- GOVERNMENT_AND_NON_PROFIT_OTHER_GOVERNMENT_AND_NON_PROFIT

### TRANSPORTATION (7)
- TRANSPORTATION_BIKES_AND_SCOOTERS
- TRANSPORTATION_GAS
- TRANSPORTATION_PARKING
- TRANSPORTATION_PUBLIC_TRANSIT
- TRANSPORTATION_TAXIS_AND_RIDE_SHARES
- TRANSPORTATION_TOLLS
- TRANSPORTATION_OTHER_TRANSPORTATION

### TRAVEL (4)
- TRAVEL_FLIGHTS
- TRAVEL_LODGING
- TRAVEL_RENTAL_CARS
- TRAVEL_OTHER_TRAVEL

### RENT_AND_UTILITIES (7)
- RENT_AND_UTILITIES_GAS_AND_ELECTRICITY
- RENT_AND_UTILITIES_INTERNET_AND_CABLE
- RENT_AND_UTILITIES_RENT
- RENT_AND_UTILITIES_SEWAGE_AND_WASTE_MANAGEMENT
- RENT_AND_UTILITIES_TELEPHONE
- RENT_AND_UTILITIES_WATER
- RENT_AND_UTILITIES_OTHER_UTILITIES

**Plaid also provides:**
- Category icon URLs: `https://plaid-category-icons.plaid.com/PFC_{PRIMARY}.png`
- Confidence levels: VERY_HIGH (>98%), HIGH (>90%), MEDIUM, LOW, UNKNOWN
- Merchant logos: `logo_url` field on transactions

---

## 9. Plaid iOS SDK — SwiftUI Integration (Latest v6.x)

### Installation (Swift Package Manager)
```
https://github.com/plaid/plaid-link-ios-spm.git  (use this, NOT the main repo — it's 500KB vs 1GB)
```

### SwiftUI View Modifier (New in v6.x!)
```swift
import LinkKit

struct AccountLinkView: View {
    @State private var isPresentingLink = false
    
    var body: some View {
        Button("Link Bank Account") {
            isPresentingLink = true
        }
        .plaidLink(
            isPresented: $isPresentingLink,
            token: linkToken,   // from your server's /link/token/create
            onSuccess: { success in
                // success.publicToken — send to your server
                // success.metadata.accounts — linked accounts
                let publicToken = success.publicToken
                sendToServer(publicToken: publicToken)
            },
            onExit: { exit in
                // Handle user exit or errors
                if let error = exit.error {
                    print("Link error: \(error)")
                }
            }
        )
    }
}
```

### Alternative: Handler-based approach
```swift
import LinkKit

class PlaidLinkManager: ObservableObject {
    private var handler: Handler?
    
    func createHandler(linkToken: String) {
        var config = LinkTokenConfiguration(token: linkToken) { success in
            print("Public token: \(success.publicToken)")
            // Exchange on server
        }
        config.onExit = { exit in
            print("User exited Link")
        }
        
        let result = Plaid.create(config)
        switch result {
        case .success(let handler):
            self.handler = handler
        case .failure(let error):
            print("Handler creation failed: \(error)")
        }
    }
    
    func present() {
        // Use handler.makePlaidLinkSheet() for SwiftUI .fullScreenCover
    }
}
```

### Required Xcode Setup
1. Add `plaid-link-ios-spm` via SPM
2. Configure Universal Links for OAuth (required for some banks):
   - Add Associated Domains capability
   - Register redirect URI with Plaid Dashboard
3. Add `NSCameraUsageDescription` to Info.plist (only if using Identity Verification)

---

## 10. Firebase Cloud Functions — Plaid Server (Copy-Paste Ready)

This is the complete server you need for Plaid integration, ready to deploy:

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Configuration, PlaidApi, PlaidEnvironments } = require('plaid');

admin.initializeApp();
const db = admin.firestore();

// Plaid client setup
const plaidConfig = new Configuration({
  basePath: PlaidEnvironments.sandbox, // Change to .production when ready
  baseOptions: {
    headers: {
      'PLAID-CLIENT-ID': functions.config().plaid.client_id,
      'PLAID-SECRET': functions.config().plaid.secret,
    },
  },
});
const plaidClient = new PlaidApi(plaidConfig);

// 1. Create Link Token (called from iOS app before opening Plaid Link)
exports.createLinkToken = functions.https.onCall(async (data, context) => {
  const userId = context.auth.uid;
  const response = await plaidClient.linkTokenCreate({
    user: { client_user_id: userId },
    client_name: 'BudgetMint',
    products: ['transactions'],
    country_codes: ['US'],
    language: 'en',
    redirect_uri: 'https://your-app.com/plaid-redirect',  // Your Universal Link
  });
  return { link_token: response.data.link_token };
});

// 2. Exchange Public Token (called after user links account)
exports.exchangePublicToken = functions.https.onCall(async (data, context) => {
  const userId = context.auth.uid;
  const { publicToken } = data;
  
  const response = await plaidClient.itemPublicTokenExchange({
    public_token: publicToken,
  });
  
  const { access_token, item_id } = response.data;
  
  // Store access token securely in Firestore
  await db.collection('plaid_items').doc(item_id).set({
    userId,
    accessToken: access_token,  // Encrypt in production!
    itemId: item_id,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // Fetch accounts
  const accountsResponse = await plaidClient.accountsGet({
    access_token: access_token,
  });
  
  // Store accounts
  for (const account of accountsResponse.data.accounts) {
    await db.collection('accounts').doc(account.account_id).set({
      userId,
      itemId: item_id,
      plaidAccountId: account.account_id,
      name: account.name,
      officialName: account.official_name,
      type: account.type,
      subtype: account.subtype,
      balanceCurrent: account.balances.current,
      balanceAvailable: account.balances.available,
      mask: account.mask,
      institution: accountsResponse.data.item.institution_id,
    });
  }
  
  return { success: true, itemId: item_id };
});

// 3. Sync Transactions (called on-demand or via webhook)
exports.syncTransactions = functions.https.onCall(async (data, context) => {
  const userId = context.auth.uid;
  const { itemId } = data;
  
  const itemDoc = await db.collection('plaid_items').doc(itemId).get();
  const { accessToken } = itemDoc.data();
  
  // Get cursor from last sync (null for first sync)
  let cursor = itemDoc.data().transactionsCursor || null;
  let hasMore = true;
  let added = [];
  let modified = [];
  let removed = [];
  
  while (hasMore) {
    const response = await plaidClient.transactionsSync({
      access_token: accessToken,
      cursor: cursor || undefined,
      options: {
        include_personal_finance_category: true,
      },
    });
    
    added = added.concat(response.data.added);
    modified = modified.concat(response.data.modified);
    removed = removed.concat(response.data.removed);
    hasMore = response.data.has_more;
    cursor = response.data.next_cursor;
  }
  
  // Batch write transactions to Firestore
  const batch = db.batch();
  
  for (const txn of added) {
    const ref = db.collection('transactions').doc(txn.transaction_id);
    batch.set(ref, {
      userId,
      accountId: txn.account_id,
      transactionId: txn.transaction_id,
      amount: txn.amount,
      date: txn.date,
      merchantName: txn.merchant_name || txn.name,
      name: txn.name,
      category: txn.personal_finance_category?.primary || 'UNCATEGORIZED',
      categoryDetailed: txn.personal_finance_category?.detailed || '',
      categoryConfidence: txn.personal_finance_category?.confidence_level || '',
      categoryIconUrl: txn.personal_finance_category_icon_url || '',
      paymentChannel: txn.payment_channel,
      pending: txn.pending,
      logoUrl: txn.logo_url || '',
      website: txn.website || '',
      isoCurrencyCode: txn.iso_currency_code,
      // Custom fields for your app
      userCategory: null,  // User override category
      tags: [],
      notes: '',
    });
  }
  
  for (const txn of modified) {
    const ref = db.collection('transactions').doc(txn.transaction_id);
    batch.update(ref, {
      amount: txn.amount,
      date: txn.date,
      pending: txn.pending,
      merchantName: txn.merchant_name || txn.name,
    });
  }
  
  for (const txn of removed) {
    const ref = db.collection('transactions').doc(txn.transaction_id);
    batch.delete(ref);
  }
  
  await batch.commit();
  
  // Update cursor
  await db.collection('plaid_items').doc(itemId).update({
    transactionsCursor: cursor,
    lastSyncedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  return { added: added.length, modified: modified.length, removed: removed.length };
});

// 4. Plaid Webhook Handler
exports.plaidWebhook = functions.https.onRequest(async (req, res) => {
  const { webhook_type, webhook_code, item_id } = req.body;
  
  if (webhook_type === 'TRANSACTIONS') {
    if (webhook_code === 'SYNC_UPDATES_AVAILABLE') {
      // New transactions available — trigger sync
      const itemDoc = await db.collection('plaid_items').doc(item_id).get();
      if (itemDoc.exists) {
        // You could trigger syncTransactions here or notify the iOS app
        console.log(`New transactions available for item: ${item_id}`);
      }
    }
  }
  
  res.status(200).json({ received: true });
});

// 5. Get Account Balances (refresh on demand)
exports.refreshBalances = functions.https.onCall(async (data, context) => {
  const userId = context.auth.uid;
  const { itemId } = data;
  
  const itemDoc = await db.collection('plaid_items').doc(itemId).get();
  const { accessToken } = itemDoc.data();
  
  const response = await plaidClient.accountsBalanceGet({
    access_token: accessToken,
  });
  
  const batch = db.batch();
  for (const account of response.data.accounts) {
    const ref = db.collection('accounts').doc(account.account_id);
    batch.update(ref, {
      balanceCurrent: account.balances.current,
      balanceAvailable: account.balances.available,
      lastBalanceUpdate: admin.firestore.FieldValue.serverTimestamp(),
    });
  }
  await batch.commit();
  
  return { accounts: response.data.accounts.length };
});
```

### Deploy Commands
```bash
# Set Plaid credentials
firebase functions:config:set plaid.client_id="YOUR_CLIENT_ID" plaid.secret="YOUR_SECRET"

# Install dependencies
cd functions && npm install plaid firebase-functions firebase-admin

# Deploy
firebase deploy --only functions
```

---

## 11. SwiftUI Quick-Start: Key Views to Build Tonight

### Spending Pie Chart (iOS 17+ Swift Charts)
```swift
import SwiftUI
import Charts

struct SpendingPieChart: View {
    let categoryTotals: [(category: String, amount: Double, color: Color)]
    
    var body: some View {
        Chart(categoryTotals, id: \.category) { item in
            SectorMark(
                angle: .value("Amount", item.amount),
                innerRadius: .ratio(0.6),  // Makes it a donut chart
                angularInset: 1.5
            )
            .foregroundStyle(item.color)
            .cornerRadius(4)
        }
        .frame(height: 250)
    }
}
```

### Transaction List Row
```swift
struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: transaction.logoUrl)) { image in
                image.resizable().frame(width: 40, height: 40).clipShape(Circle())
            } placeholder: {
                Image(systemName: "creditcard.fill")
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading) {
                Text(transaction.merchantName)
                    .font(.body).fontWeight(.medium)
                Text(transaction.date, style: .date)
                    .font(.caption).foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "USD"))
                .fontWeight(.semibold)
                .foregroundColor(transaction.amount > 0 ? .red : .green)
        }
    }
}
```

### Budget Progress Bar
```swift
struct BudgetProgressBar: View {
    let categoryName: String
    let spent: Double
    let budgeted: Double
    
    var progress: Double { min(spent / budgeted, 1.0) }
    var color: Color {
        if progress >= 1.0 { return .red }
        if progress >= 0.8 { return .yellow }
        return .green
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(categoryName).font(.subheadline)
                Spacer()
                Text("\(spent, specifier: "%.0f") / \(budgeted, specifier: "%.0f")")
                    .font(.caption).foregroundColor(.secondary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 8)
        }
    }
}
```

---

## 12. Tonight's Build Checklist

If you're firing up Claude Code tonight, here's the most efficient order:

### Step 0: Prerequisites (10 min)
- [ ] Sign up for Plaid at https://dashboard.plaid.com (free)
- [ ] Get client_id and secret (Sandbox for tonight)
- [ ] Set up Firebase project (you know this from LoungeAdvisor)

### Step 1: Backend First (30 min with Claude Code)
- [ ] `firebase init functions`
- [ ] Paste the Cloud Functions code from Section 10 above
- [ ] `npm install plaid` in functions/
- [ ] Set Plaid config: `firebase functions:config:set plaid.client_id="..." plaid.secret="..."`
- [ ] Deploy: `firebase deploy --only functions`

### Step 2: Xcode Project (20 min)
- [ ] Create new SwiftUI project "BudgetMint"
- [ ] Add SPM packages: `plaid-link-ios-spm`, `FirebaseFirestore`, `FirebaseAuth`, `FirebaseFunctions`
- [ ] Configure Firebase (GoogleService-Info.plist)
- [ ] Set up Universal Links for Plaid OAuth

### Step 3: Core App (60-90 min with Claude Code)
- [ ] Auth screen (Firebase Auth — email/password for personal use is fine)
- [ ] Account linking screen (Plaid Link SwiftUI integration)
- [ ] Transaction list view with search
- [ ] Dashboard with spending pie chart
- [ ] Category breakdown view
- [ ] Net worth / account balances overview

### Step 4: If Time Permits
- [ ] Budget creation and tracking
- [ ] Monthly spending trends (line chart)
- [ ] Transaction categorization rules
- [ ] Recurring transaction detection
