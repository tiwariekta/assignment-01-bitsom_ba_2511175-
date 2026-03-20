## 🔄 ETL Decisions

---

### 🧹 Decision 1 — Category Standardization

**Problem:**  
The dataset contains inconsistent category values:
- "electronics" vs "Electronics"  
- "Grocery" vs "Groceries"

➡️ Leads to incorrect aggregation and reporting, as the same category would be treated as different groups.

**Resolution:**  
Standardized all values:
- electronics → Electronics  
- Groceries → Grocery  

✅ Ensures accurate grouping in analysis

---

### 📅 Decision 2 — Date Format Normalization

**Problem:**  
Dates are in `DD/MM/YYYY` format:
- Not ideal for sorting  
- Causes issues in time-based analysis  

**Resolution:**  
Converted all dates to:
> `YYYY-MM-DD` (ISO format)

Also created a **TBL_DIM_DATE table** with:
- Year  
- Quarter
- Month  
- Month_Name
- Day  
- Day of the Week

✅ Enables efficient time-based reporting

---

### 💰 Decision 3 — Deriving Total Sales Metric

**Problem:**  
Dataset lacks total revenue field

➡️ Requires repeated calculations in queries

**Resolution:**  
Created:
> `sales_amount = units_sold × unit_price`

Stored in **fact table**

✅ Improves performance and simplifies queries

---

### 🎯 Summary

These transformations ensure:
- ✔ Data consistency  
- ✔ Better query performance  
- ✔ Accurate business insights  
