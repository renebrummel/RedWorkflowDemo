tableextension 50100 "Red Workflow Step Argument" extends "Workflow Step Argument"
{
    fields
    {
        field(50000; "Field No. Red"; Integer)
        {
            Caption = 'Qty. Damaged Field No.';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(50001; "FieldName Red"; Text[30])
        {
            Caption = 'Qty. Damaged FieldName';
            FieldClass = FlowField;
            CalcFormula = Lookup (Field.FieldName where("No." = field("Field No. Red"), TableNo = field("Table No.")));
            Editable = false;
        }
    }
}