# 🚖 Ride Cancellation Prediction & Revenue Impact Analysis | Predictive Analytics in Ride-Hailing

# EXECUTIVE SUMMARY
Analyzed ride-level data to identify key drivers of cancellations and quantify their impact on revenue and operational efficiency. Combined SQL-based analysis with a predictive model to detect high-risk rides and support proactive interventions.

- 🎯 **Business Problem:** Ride cancellations causing ~13.5% revenue loss (~₹36.7L) and operational inefficiencies  
- ⚙️ **Approach:** SQL-driven analysis + feature engineering + Logistic Regression model for prediction  
- 📈 **Impact:** Identified surge pricing, peak hours, and driver quality as primary drivers of cancellations  

---

# BUSINESS PROBLEM
Ride cancellations directly impact revenue, driver utilization, and customer experience in ride-hailing platforms. High cancellation rates during surge pricing and peak hours indicate inefficiencies in pricing strategy and supply-demand balance.

The goal is to identify the key drivers of cancellations and enable early prediction of high-risk rides to support better pricing, allocation, and operational decisions.

---

# METHODOLOGY

- 🧩 Extracted and transformed data using SQL across rides, users, drivers, locations, and payments tables  
- 🧹 Performed data cleaning and preprocessing using Python (handling nulls, feature consistency)  
- 🔍 Conducted segmentation analysis on surge levels, peak hours, driver ratings, and ride distance  
- 🏗️ Engineered features such as peak-hour flags, surge buckets, and driver/user segments  
- 🤖 Trained Logistic Regression model using time-based split (15 months train, 3 months test)  
- 📊 Evaluated model performance with focus on recall to capture high-risk cancellations  

---

# SKILLS

**SQL:**
- 🧠 CTEs, Joins, Window Functions, Aggregations  

**Python:**
- 🐍 Pandas, NumPy, EDA, Feature Engineering, Logistic Regression  

**Analytics Concepts:**
- 📌 Segmentation, KPI Design, Predictive Modeling, Business Impact Analysis  

---

# RESULTS & BUSINESS RECOMMENDATIONS

Analysis shows that cancellations are strongly influenced by pricing pressure, demand timing, and driver quality, leading to measurable revenue loss.

### 🔍 Key Insights:
- 🚨 Cancellation rate increases from ~10% to **20.38% under high surge pricing**  
- ⏰ Peak hours show highest risk: **9 PM (~20%) and 8 AM (~17.85%)**  
- ⭐ Low-rated drivers have higher cancellations (**~20% vs ~12% for high-rated**)  
- 📉 Short-distance rides slightly more prone to cancellation  
- 💰 Estimated revenue loss: **₹36.7L (~13.5%)**

### 🚀 Business Recommendations:
![Recommendation Impact](https://github.com/nmashokkumar/ride-cancellation-prediction-analysis/blob/34375d4735acea4e4d1aa1c2123f251b4db0d85f/Surge_multiplier.png)
- ⚡ Optimize surge pricing by capping multipliers and using driver incentives instead of aggressive price spikes  
- 🚗 Increase driver supply during peak hours through targeted bonuses and scheduling strategies  
- 🌟 Prioritize high-rated drivers during critical demand periods to improve ride completion  
- 📍 Introduce incentives or minimum fare guarantees for short-distance rides  
- 🧠 Use predictive signals to identify high-risk rides and apply preventive actions early  


---

# NEXT STEPS

- 🔧 Improve model performance using ensemble methods (Random Forest, XGBoost)  
- ➕ Add behavioral features such as user cancellation history and driver acceptance rates  
- ⚙️ Build real-time prediction pipeline for operational integration  
- 📊 Develop interactive dashboard to monitor cancellation KPIs and trends  
- 🧪 Run controlled experiments (A/B testing) on pricing and incentive strategies
