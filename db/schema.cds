/**
 * CAPM Domain Model – Pharmacy Stock & Expiry Monitoring System
 *
 * Purpose:
 * This data model represents core pharmacy operations such as
 * medicine master data, suppliers, batch-wise stock tracking,
 * purchase and sales transactions, alerts, and audit logging.
 *
 * Design Principles:
 * - Uses cuid (UUID) for all technical identities
 * - Separates master, transactional, monitoring, and audit entities
 * - Uses reusable aspects for lifecycle/status handling
 * - Optimized for SAP Fiori/UI5 consumption
 *
 * This file defines ONLY the persistence model (db layer).
 * Service projections and business logic are handled separately.
 */

namespace com.trail.sample;

using {cuid} from '@sap/cds/common';

//12 entities created here
//1 selfmade Aspect

aspect StatusAspect {
    Status       : String;
    StatusReason : String;
}

entity Medicines : cuid ,StatusAspect {
    Name                 : String;
    Brand                : String(32);
    DosageForm           : String;
    Strength             : String;
    Category             : String;
    PrescriptionRequired : Boolean;
    //relations 1-n
    batches: Association to many Batches on batches.medicine=$self;
    
}

entity Suppliers : cuid , StatusAspect {
    SupplierName  : String;
    LicenseNumber : String;
    ContactPerson : String;
    Phone         : String;
    Email         : String;
    Address       : String;
}

entity Batches : cuid {
    BatchNumber       : String;
    ManufacturingDate : Date;
    ExpiryDate        : Date;
    PurchasePrice     : Decimal;
    Mrp               : Decimal;
    ReceivedQuantity  : Integer;
    //Relation n-1
    medicine: Association to Medicines;
}

entity Stocks : cuid {
    AvailableQuantity : Integer;
    ReservedQuantity  : Integer;
    ReorderLevel      : Integer;
    StorageLocation   : String;
    //Relation 1-1
    batch: Association to Batches;

}

entity PurchaseOrders : cuid , StatusAspect{
    PurchaseOrderNumber  : String;
    OrderDate            : Date;
    ExpectedDeliveryDate : Date;
    TotalAmount          : Decimal;
    //Relation 1-1
    supplier: Association to Suppliers;
    //Relation dependent 1-n
    items: Composition of many PurchaseItems on items.purchaseOrder = $self;
}

entity PurchaseItems : cuid {
    OrderQuantity    : Integer;
    ReceivedQuantity : Integer;
    UnitPrice        : Decimal;
    LineAmount       : Decimal;
    //Relation 1-1
    purchaseOrder : Association  to PurchaseOrders;
    medicine: Association to Medicines;
    batch:Association to Batches;
}

entity SalesTransactions : cuid {
    BillNumber   : String;
    SalesDate    : Date;
    CustomerType : String;
    TotalAmount  : Decimal;
    PaymentMode  : String;
    //Relation Dependent 1-n
    items:Composition of many SalesItems on items.salesTransaction = $self;
}

entity SalesItems : cuid {
    QuantitySold : Integer;
    SellingPrice : Decimal;
    Discount     : Decimal;
    LineAmount   : Decimal;
    //Relation 1-1
    salesTransaction:Association to SalesTransactions;
    medicine : Association to Medicines;
    batch : Association to Batches;

}

entity ExpiryAlerts : cuid {
    AlertType     : String;
    DaysRemaining : Integer;
    AlertStatus   : String;
    //Relation n-1
    batch: Association to Batches;
}

entity StockAlerts : cuid {
    AlertLevel     : String;
    ThresholdValue : Integer;
    AlertStatus    : String;
    //Relation 1-1
    stock : Association to Stocks;

}

entity PharmacyLicenses : cuid, StatusAspect {
    LicenseNumber : String;
    IssuedBy      : String;
    ValidFrom     : Date;
    ValidTo       : Date;
}

entity AuditLogs : cuid {
    EntityName    : String;
    OperationType : String;
    ChangeField   : String;
    OldValue      : String;
    NewValue      : String;
    ChangedAt     : Timestamp;
}
