using com.trail.sample as hm from '../db/schema';

// PurchaseOrders is the aggregate root
// PurchaseItems will come automatically via composition
// UI5 Object Page works best with this pattern

// ❌ You do NOT expose PurchaseItems separately
// ✔ They are managed through PurchaseOrders

service PharmacyService {

    // Master Data
    @odata.draft.enabled
    entity Medicines        as projection on hm.Medicines;
    @odata.draft.enabled
    entity Suppliers        as projection on hm.Suppliers;
    entity PharmacyLicenses as projection on hm.PharmacyLicenses;

    // Transactions
    @odata.draft.enabled
    entity PurchaseOrders   as projection on hm.PurchaseOrders;
    @odata.draft.enabled
    entity SalesTransactions as projection on hm.SalesTransactions;

    // Operational Data
    entity Batches as projection on hm.Batches;
    @readonly
    entity Stocks as projection on hm.Stocks;

    // Monitoring (Read-only)

    @readonly
    entity ExpiryAlerts as projection on hm.ExpiryAlerts;
    @readonly
    entity StockAlerts  as projection on hm.StockAlerts;

}
