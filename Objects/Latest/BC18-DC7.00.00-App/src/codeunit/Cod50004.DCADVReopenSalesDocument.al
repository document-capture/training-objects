codeunit 50004 "DCADV Reopen Sales Document"
{
    TableNo = "Sales Header";
    trigger OnRun()
    var
        RelPurchDoc: Codeunit "Release Sales Document";
        SalesPerson: Record "Salesperson/Purchaser";
    begin
        RelPurchDoc.Reopen(Rec);
        if SalesPerson.Get('TZ') then
            Rec."Salesperson Code" := 'TZ'
        else
            if SalesPerson.Get('RL') then
                Rec."Salesperson Code" := 'TZ';

        Modify(true);
    end;
}
