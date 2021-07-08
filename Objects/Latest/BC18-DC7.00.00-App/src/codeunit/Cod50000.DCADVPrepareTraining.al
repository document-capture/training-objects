Codeunit 50000 "DCADV Prepare Training"
{
    trigger OnRun()
    var
        DCSetup: Record "CDC Document Capture Setup";
    begin
        if not Confirm('This will prepare the current company for Document Capture Training.\\Do you want to continue?', true) then
            exit;

        if not DCSetup.Get AND (DCSetup."Document Nos." <> '') THEN
            if not Confirm('You already have Document Capture configuration in the current company.\\Do you want to continue?', false) then
                exit;

        Code();

        message('This company is now ready for Document Capture Training');
    end;

    local procedure Code()
    var
        myInt: Integer;
    begin
        DeletePOs;
        DeletePIs;
        ReopenPOs;
        DeleteSOs;
        ReopenSOs;

        CreateMatchPO;
    end;


    local procedure DeletePIs()
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
        if PurchHeader.FindFirst THEN
            Repeat
                if Codeunit.Run(Codeunit::"DCADV Delete Purchase Document", PurchHeader) then;
            Until PurchHeader.Next = 0;
    end;



    local procedure DeletePOs()
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
        PurchHeader.SETFILTER("Buy-from Vendor No.", '30000|40000|61000');
        if PurchHeader.FindFirst THEN
            Repeat
                if Codeunit.Run(Codeunit::"DCADV Delete Purchase Document", PurchHeader) THEN;
            Until PurchHeader.Next = 0;
    end;

    local procedure ReopenPOs()
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SetRange(Status, PurchHeader.Status::Released);
        if PurchHeader.FindFirst() THEN
            Repeat
                if Codeunit.Run(Codeunit::"DCADV Reopen Purchase Document", PurchHeader) THEN;
            Until PurchHeader.Next = 0;

    end;

    local procedure DeleteSOs()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        if SalesHeader.FindFirst THEN
            Repeat
                if Codeunit.Run(Codeunit::"DCADV Delete Sales Document", SalesHeader) THEN;
            Until SalesHeader.Next = 0;
    end;

    local procedure ReopenSOs()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        if SalesHeader.FindFirst THEN
            Repeat
                if Codeunit.Run(Codeunit::"DCADV Reopen Sales Document", SalesHeader) THEN;
            Until SalesHeader.Next = 0;
    end;

    local procedure CreateMatchPO()
    var
    begin
        Codeunit.Run(Codeunit::"DCADV Create PO for Matching");
    end;
}
