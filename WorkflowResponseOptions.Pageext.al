pageextension 50100 "Red Workflow Response Options" extends "Workflow Response Options"
{
    layout
    {
        addafter(Control35)
        {
            group(TLNRmoGroup0)
            {
                Caption = 'Rental Model Event Selection';
                Visible = "Response Option Group" = 'RED GROUP 0';
                field("Field No. Red"; "Field No. Red")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field number.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        GetQtyDamagedFieldNo();
                    end;
                }
                field("FieldName Red"; "FieldName Red")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name.';
                }
            }
        }
    }

    procedure GetQtyDamagedFieldNo();
    var
        Field: Record Field;
    begin
        Field.SetRange(TableNo, Database::Item);

        if Page.RunModal(Page::"Fields Lookup", Field) = Action::LookupOK then begin
            "Field No. Red" := Field."No.";
            Modify();
            CurrPage.Update(false);
        end;
    end;
}