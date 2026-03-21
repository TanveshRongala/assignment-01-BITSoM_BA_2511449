---------------------------------------------------------------------------
## OP1: insertMany() — insert all 3 documents from sample_documents.json
---------------------------------------------------------------------------
db.products.insertMany([
  {
    _id: "ELEC1001",
    name: "Samsung 43-inch 4K Smart TV",
    category: "Electronics",
    brand: "Samsung",
    price: 32999,
    currency: "INR",
    stock: 18,
    specifications: {
      screen_size: "43 inch",
      resolution: "3840x2160",
      display_type: "LED",
      smart_tv: true,
      voltage: "220-240V",
      connectivity: ["Wi-Fi", "Bluetooth", "HDMI", "USB"]
    },
    warranty: {
      period_months: 24,
      type: "Manufacturer Warranty"
    },
    ratings: {
      average: 4.4,
      count: 276
    },
    features: [
      "Voice Assistant Support",
      "Dolby Audio",
      "Screen Mirroring"
    ]
  },
  {
    _id: "CLOT2001",
    name: "Men's Regular Fit Cotton Shirt",
    category: "Clothing",
    brand: "Allen Solly",
    price: 1499,
    currency: "INR",
    stock: 45,
    details: {
      material: "100% Cotton",
      color: "Navy Blue",
      fit: "Regular Fit",
      sleeve_type: "Full Sleeve",
      pattern: "Solid",
      gender: "Men"
    },
    sizes_available: ["S", "M", "L", "XL"],
    care_instructions: [
      "Machine wash cold",
      "Do not bleach",
      "Iron at low temperature"
    ],
    ratings: {
      average: 4.1,
      count: 134
    },
    seller: {
      name: "FashionHub Retail",
      location: "Mumbai"
    }
  },
  {
    _id: "GROC3001",
    name: "Organic Toor Dal 1kg",
    category: "Groceries",
    brand: "24 Mantra",
    price: 185,
    currency: "INR",
    stock: 120,
    package: {
      weight: "1 kg",
      type: "Pouch"
    },
    expiry: {
      manufacture_date: "2026-01-10",
      expiry_date: "2026-10-09"
    },
    nutrition_per_100g: {
      energy_kcal: 335,
      protein_g: 22.3,
      carbohydrates_g: 62.6,
      fat_g: 1.7,
      fiber_g: 15.2
    },
    ingredients: ["Organic toor dal"],
    storage_instructions: [
      "Store in a cool and dry place",
      "Keep away from moisture",
      "Transfer to an airtight container after opening"
    ],
    organic_certified: true
  }
]);

-----------------------------------------------------------------------
## OP2: find() — retrieve all Electronics products with price > 20000
-----------------------------------------------------------------------
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  }
);

---------------------------------------------------------------------
## OP3: find() — retrieve all Groceries expiring before 2025-01-01
---------------------------------------------------------------------
db.products.find(
  {
    category: "Groceries",
    "expiry.expiry_date": { $lt: "2025-01-01" }
  }
);

----------------------------------------------------------------------------
## OP4: updateOne() — add a "discount_percent" field to a specific product
----------------------------------------------------------------------------
db.products.updateOne(
  { _id: "ELEC1001" },
  {
    $set: {
      discount_percent: 10
    }
  }
);

----------------------------------------------------------------------------
## OP5: createIndex() — create an index on category field and explain why
----------------------------------------------------------------------------
db.products.createIndex({ category: 1 });

// Explanation:
// This index improves query performance for searches that filter by category,
// such as fetching all Electronics, Clothing, or Groceries products.
// Since category-based filtering is common in e-commerce catalogs, indexing
// this field reduces scan time and makes retrieval faster.
