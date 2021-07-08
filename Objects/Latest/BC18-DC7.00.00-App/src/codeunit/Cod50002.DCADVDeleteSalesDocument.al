codeunit 50002 "DCADV Delete Sales Document"
{
    TableNo = "Sales Header";
    trigger OnRun()
    begin
        Delete(true);
    end;
}
