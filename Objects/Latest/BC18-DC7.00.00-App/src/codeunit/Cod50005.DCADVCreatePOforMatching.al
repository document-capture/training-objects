codeunit 50005 "DCADV Create PO for Matching"
{
    TableNo = "Sales Header";
    trigger OnRun()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Record "No. Series";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchLineType: Enum "Purchase Line Type";
    begin
        PurchSetup.GET;
        NoSeries.SETRANGE(Code, PurchSetup."Order Nos.");
        NoSeries.FINDFIRST;
        NoSeries."Manual Nos." := TRUE;
        NoSeries.MODIFY(TRUE);

        IF NOT PurchHeader.GET('1003') THEN BEGIN
            PurchHeader.INIT;
            PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
            PurchHeader."No." := '1003';
            PurchHeader.INSERT(TRUE);

            PurchHeader.VALIDATE("Buy-from Vendor No.", '30000');
            PurchHeader.VALIDATE("Location Code", '');
            PurchHeader.MODIFY(TRUE);

            AddPurchLine(PurchHeader, PurchLineType::Item, '70060', 250, 10.3);
            AddPurchLine(PurchHeader, PurchLineType::Item, '70002', 15, 22.6);
            AddPurchLine(PurchHeader, PurchLineType::Item, '70010', 50, 41.1);
            AddPurchLine(PurchHeader, PurchLineType::Item, '70040', 45, 85.4);
            AddPurchLine(PurchHeader, PurchLineType::Item, '70101', 85, 2.2);
            AddPurchLine(PurchHeader, PurchLineType::"G/L Account", '0380', 1, 462.5);
        END;
    end;

    local procedure AddPurchLine(var PurchHeader: Record "Purchase Header"; Type: Enum "Purchase Line Type"; No: Code[20]; Qty: Decimal; UnitCost: Decimal)
    var
        PurchLine: Record "Purchase Line";
        NextLineNo: Integer;
    begin
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDLAST THEN
            NextLineNo := PurchLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        PurchLine.INIT;
        PurchLine."Document Type" := PurchHeader."Document Type";
        PurchLine."Document No." := PurchHeader."No.";
        PurchLine."Line No." := NextLineNo;
        PurchLine.INSERT(TRUE);

        PurchLine.VALIDATE(Type, Type);
        PurchLine.VALIDATE("No.", No);
        PurchLine.VALIDATE(Quantity, Qty);
        PurchLine.VALIDATE("Direct Unit Cost", UnitCost);
        PurchLine.MODIFY(TRUE);
    end;
}
