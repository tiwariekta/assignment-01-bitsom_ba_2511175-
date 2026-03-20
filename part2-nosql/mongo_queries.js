// OP1: insertMany() — insert all 3 documents

db.products.insertMany([
  {
    product_id: "E1001",
    name: "Smartphone X Pro",
    category: "Electronics",
    price: 75000,
    brand: "TechCorp",
    specifications: {
      warranty_years: 2,
      voltage: "220V",
      battery: "5000mAh",
      processor: "Octa-core"
    },
    features: ["5G", "Dual SIM", "Fast Charging"],
    stock: 50
  },
  {
    product_id: "C2001",
    name: "Men's Denim Jacket",
    category: "Clothing",
    price: 3500,
    brand: "StyleHub",
    sizes_available: ["S", "M", "L", "XL"],
    material: "Denim",
    color_options: ["Blue", "Black"],
    care_instructions: {
      wash: "Machine Wash",
      iron: "Low Heat"
    },
    stock: 120
  },
  {
    product_id: "G3001",
    name: "Organic Milk 1L",
    category: "Grocery",
    price: 80,
    brand: "FarmFresh",
    expiry_date: new Date("2024-12-20"),
    nutritional_info: {
      calories: 60,
      protein: "3.2g",
      fat: "3.5g"
    },
    storage_instructions: "Keep Refrigerated",
    stock: 200
  }
]);


// OP2: find Electronics with price > 20000

db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});


// OP3: find Groceries expiring before 2025-01-01

db.products.find({
  category: "Grocery",
  expiry_date: { $lt: new Date("2025-01-01") }
});


// OP4: updateOne() — add discount_percent

db.products.updateOne(
  { product_id: "E1001" },
  { $set: { discount_percent: 10 } }
);


// OP5: createIndex() — index on category field

db.products.createIndex({ category: 1 });



