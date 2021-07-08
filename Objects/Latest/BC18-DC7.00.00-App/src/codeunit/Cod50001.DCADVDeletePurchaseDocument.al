codeunit 50001 "DCADV Delete Purchase Document"
{
    TableNo = "Purchase Header";
    trigger OnRun()
    begin
        Delete(true);
    end;
}
