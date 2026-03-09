# Group 3 Screens: Search, Orders, Wallet, Profile & Splash

## Design System (Shared)
- **Primary Color**: Dark Brown (#8B4513 / similar)
- **Background**: White (#FFFFFF) / Light Grey (#F5F5F5)
- **Text**: Dark (#1A1A1A) for headers, Grey (#888) for subtitles
- **Bottom Nav**: 4 items — Home, Search, Wallet, Profile (with active state indicator)
- **Typography**: Clean sans-serif, bold headers, regular body
- **Corners**: Rounded (12-16px) on cards, buttons, inputs

---

## Screen 13: Search Screen (image 9)
- **Header**: Back arrow (←) + Search input field with magnifying glass icon + clear (X) button
- **Search Input**: Rounded, light grey background, placeholder "Search..."
- **Recent Search Section**:
  - Title: "Recent Search"
  - Items: "Raspberry Rhapsody", "Berry Burst Bonanza", "Velvet Dream Delight"
  - Each with an X button to remove
- **Recent View Section**:
  - Title: "Recent View"
  - List items with thumbnail image, title, category, and price:
    - Chocolate Chip Cascade — Cookies — $20.00
    - Choco Bliss Cupcakes — Cup Cake — $22.00
    - Strawberry Fields Frosted — Donut — $25.00
    - Chocolate Caramel Donuts — Donut — $18.00
- **Bottom Nav**: Home, Search (Active), Wallet, Profile

---

## Screen 14: Search Results - Products (image 10)
- **Header**: Back arrow + Search bar containing "Cake" + clear (X)
- **Tabs**: "Products" (Active, underlined brown) | "Bakeries"
- **Bakery Section Header**: Bakery name (e.g., "Zestful Zephyr Bakery")
  - Metadata: green dot, "15 min • 1.5km • Free Delivery"
- **Product Grid**: 2-column grid layout
  - Each card:
    - Product image with "ADD" button overlay (brown)
    - Product name (e.g., "Chocolate Creamy")
    - Star rating + "(1k+ Reviews)" text
    - Price (e.g., "$ 35.00")
  - Products shown: Chocolate Creamy ($35.00, $45.00), Raspberry Cake ($24.00), Citrus Bliss Cake ($32.00)
- **Multiple bakeries**: "Heavenly Harvest Bakes" section follows same pattern
- **Bottom Nav**: Home, Search (Active), Wallet, Profile

---

## Screen 15: Search Results - Bakeries Tab (image 8)
- **Header**: Same as Products — Back arrow + "Cake" search + X
- **Tabs**: "Products" | "Bakeries" (Active, underlined brown)
- **Bakery List**: Card-based vertical list
  - Each bakery card:
    - Cover photo (landscape image of bakery interior)
    - Bakery name (e.g., "Rise & Shine Bakery Co.")
    - Categories: "Cup Cake, Cookies, Donuts, Breads, Cake..."
    - Location icon + address
    - Delivery info: "15 mins • 2.5 km • Free Delivery"
    - Rating: "4.8 (1k+ Reviews)" with star
    - Heart/favorite icon
  - Bakeries listed: Rise & Shine Bakery Co., Sweet Confections Cottage
- **Bottom Nav**: Home, Search (Active), Wallet, Profile

---

## Screen 16: Filter Screen (image 7)
- **Header**: Back arrow + "Filter" title
- **Location Section**:
  - Label: "Location"
  - Dropdown: "New York, USA" with chevron down
- **Category Section**:
  - Label: "Category"
  - Horizontal chips: "All" (selected, brown bg), "Cup Cake", "Cookies", "Donu..." (scrollable)
- **Price Range Section**:
  - Label: "Price Range"
  - Dual-thumb range slider (brown handles)
  - Values: $10 to $40 with labels ($10, $15, $20, $25, $30, $35, $40)
- **Reviews Section**:
  - Label: "Reviews"
  - Radio button list with star icons:
    - 4.5 and above (selected, brown dot)
    - 4.0 - 4.5
    - 3.5 - 4.0
    - 3.0 - 3.5
    - 2.5 - 3.0
- **Sortby Section**:
  - Label: "Sortby"
  - Horizontal chips: "All" (selected, brown), "Popular", "Near by", "Price ↑"
- **Bottom Buttons**:
  - "Reset Filter" (outlined, brown border) | "Apply" (solid brown)

---

## Screen 17: My Orders - Active Tab (image 6)
- **Header**: Back arrow + "My Orders" title
- **Tabs**: "Active" (selected, brown underline) | "Completed" | "Cancelled"
- **Order List**: Vertical scrollable list
  - Each order card:
    - Product thumbnail image (circular/rounded)
    - Product name (e.g., "Strawberry Cup Cake")
    - Category + quantity (e.g., "Cup Cake | Qty : 02 pcs")
    - Price (e.g., "$50.00")
    - "Track Order" button (small, brown outlined/solid)
  - Orders listed:
    - Strawberry Cup Cake — 02 pcs — $50.00
    - Vanila Cake — 01 pcs — $80.00
    - Strawberry Cake — 02 pcs — $88.00
    - Almond Chocolate Cake — 01 pcs — $70.00
    - Chocolate Vanila — 02 pcs — $60.00
    - Chocolate Cake (partially visible)
- **Bottom Nav**: Home, Search, Wallet, Profile

---

## Screen 18: Track Order - Stepper (image 5)
- **Header**: Back arrow + "Track Order" title
- **Order Item Info**:
  - Product thumbnail
  - "Strawberry Cup Cake"
  - Quantity and price info
- **Tracking Stepper** (vertical timeline):
  - ✅ **Order Placed** (completed — brown checkmark)
  - ✅ **Order Confirmed** (completed — brown checkmark)
  - 🔵 **Order Shipped** (in progress — brown circle, highlighted)
  - ⚪ **Out for Delivery** (pending — grey circle)
  - ⚪ **Order Delivered** (pending — grey circle)
  - Each step has a timestamp
- **Driver Section**:
  - Driver profile picture (circular)
  - Driver name: "Sadek Ebubekir"
  - Role: "Delivery Man"
  - Action icons: Phone call icon + Message icon (brown)

---

## Screen 19: My Wallet (image 4)
- **Header**: "My Wallet" title
- **Balance Card**:
  - Brown patterned/gradient card
  - Label: "Total Balance"
  - Amount: "$450.00" (large white text)
  - "Add Money" button or link
- **Transaction History**:
  - Section title: "Transaction History"
  - List of transactions:
    - Product thumbnail
    - Product name (e.g., "Strawberry Cup Cake")
    - Date
    - Price
    - Status icon (green checkmark for success)
  - Multiple transaction entries
- **Bottom Nav**: Home, Search, Wallet (Active), Profile

---

## Screen 20: My Profile / Settings (image 3)
- **Header**: "My Profile" title
- **Profile Header**:
  - User avatar (circular)
  - User name
- **Settings Menu List**:
  - Personal Info — icon + right chevron (>)
  - Track Order — icon + right chevron
  - My Address — icon + right chevron
  - Payment Method — icon + right chevron
  - My Wishlist — icon + right chevron
  - Notification — icon + right chevron
  - Security — icon + right chevron
  - Logout — icon + right chevron
- **Bottom Nav**: Home, Search, Wallet, Profile (Active)

---

## Screen 21 & 22: Splash Screen (image 2 & image 1)
- **Background**: Solid dark brown color (#8B4513 or similar)
- **Branding**: Large, centered white text "Quiki"
- **No navigation elements** — full-screen branding view
- Two variants may exist (logo only vs. logo + tagline)
