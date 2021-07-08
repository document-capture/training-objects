pageextension 50000 "DCADV Order Processor RC Ext." extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(embedding)
        {
            action("Prepare DC Training")
            {
                RunObject = codeunit "DCADV Prepare Training";
                ApplicationArea = All;
            }
        }
    }
}
