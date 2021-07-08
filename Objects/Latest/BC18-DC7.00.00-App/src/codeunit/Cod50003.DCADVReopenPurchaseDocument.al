codeunit 50003 "DCADV Reopen Purchase Document"
{
    TableNo = "Purchase Header";
    trigger OnRun()
    var
        RelPurchDoc: Codeunit "Release Purchase Document";
    begin
        RelPurchDoc.Reopen(Rec);
    end;
}
