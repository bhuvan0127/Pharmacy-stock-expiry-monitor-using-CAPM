using com.trail.sample as hm from '../db/schema';

// PurchaseOrders is the aggregate root
// PurchaseItems will come automatically via composition
// UI5 Object Page works best with this pattern

// ❌ You do NOT expose PurchaseItems separately
// ✔ They are managed through PurchaseOrders

service PharmacyService {

    // ============================
    // Master Data (User Maintained)
    // ============================

    // Draft-enabled to allow controlled creation and modification
    // through Fiori Elements Object Pages.
    @odata.draft.enabled
    entity Medicines         as projection on hm.Medicines;

    @odata.draft.enabled
    entity Suppliers         as projection on hm.Suppliers;

    // Compliance-related master data.
    // Maintained less frequently, no draft required.
    entity PharmacyLicenses  as projection on hm.PharmacyLicenses;


    // ============================
    // Transactional Data
    // ============================

    // Aggregate root for procurement transactions.
    // Draft-enabled to support header–item editing via composition.
    @odata.draft.enabled
    entity PurchaseOrders    as projection on hm.PurchaseOrders;

    // Aggregate root for sales transactions.
    // Draft-enabled to support invoice creation and editing.
    @odata.draft.enabled
    entity SalesTransactions as projection on hm.SalesTransactions;


    // ============================
    // Operational / Derived Data
    // ============================

    // Batch-level operational data.
    // Exposed for reference and reporting.
    entity Batches           as projection on hm.Batches;

    // Stock data is derived from purchase and sales transactions.
    // Read-only to ensure inventory integrity.
    @readonly
    entity Stocks            as projection on hm.Stocks;


    // ============================
    // Monitoring & Alerts
    // ============================

    // System-generated alerts for near-expiry batches.
    // Read-only and not user-editable.
    @readonly
    entity ExpiryAlerts      as projection on hm.ExpiryAlerts;

    // System-generated alerts for low or critical stock levels.
    // Read-only for operational monitoring only.
    @readonly
    entity StockAlerts       as projection on hm.StockAlerts;
}
