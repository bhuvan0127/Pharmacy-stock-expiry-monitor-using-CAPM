namespace com.trail.sample;

using {cuid} from '@sap/cds/common';

//12 entities created here

entity Medicines : cuid {
    Name                 : String;
    Brand                : String(32);
    DosageForm           : String;
    Strength             : String;
    Category             : String;
    PrescriptionRequired : Boolean;
    IsActive             : String;
}

entity Suppliers : cuid {
    SupplierName  : String;
    LicenseNumber : String;
    ContactPerson : String;
    Phone         : String;
    Email         : String;
    Address       : String;
    IsActive      : String;
}

entity Batches : cuid {
    BatchNumber       : String;
    ManufacturingDate : Date;
    ExpiryDate        : Date;
    PurchasePrice     : Decimal;
    Mrp               : Decimal;
    ReceivedQuantity  : Integer;
}

entity Stocks : cuid {
    AvailableQuantity : Integer;
    ReservedQuantity  : Integer;
    ReorderLevel      : Integer;
    StorageLocation   : String;

}

entity PurchaseOrders : cuid {
    PurchaseOrderNumber  : String;
    OrderDate            : Date;
    ExpectedDeliveryDate : Date;
    Status               : String;
    TotalAmount          : Decimal;
}

entity PurchaseItems : cuid {
    OrderQuantity    : Integer;
    ReceivedQuantity : Integer;
    UnitPrice        : Decimal;
    LineAmount       : Decimal;
}

entity SalesTransactions : cuid {
    BillNumber   : Integer;
    SalesDate    : Date;
    CustomerType : String;
    TotalAmount  : String;
    PaymentMode  : String;
}

entity SalesItems : cuid {
    QuantitySold : Integer;
    SellingPrice : Decimal;
    Discount     : Decimal;
    LineAmount   : Decimal;

}

entity ExpiryAlerts : cuid {
    AlertType     : String;
    DaysRemaining : Integer;
    AlertStatus   : String;
}

entity StockAlerts : cuid {
    AlertLevel     : String;
    ThresholdValue : Integer;
    AlertStatus    : String;
}

entity PharmacyLicenses : cuid {
    LicenseNumber : String;
    IssuedBy      : String;
    ValidFrom     : Date;
    ValidTo       : Date;
    IsActive      : String;
}

entity AuditLogs : cuid {
    EntityName    : String;
    OperationType : String;
    ChangeField   : String;
    OldValue      : String;
    NewValue      : String;
    ChangedAt     : Date;
}
