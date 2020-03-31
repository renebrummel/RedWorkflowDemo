codeunit 50101 "Red Workflow Response"
{
    procedure CreateResponsesLibrary();
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(MessageItemCode, 0, MessageItemTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(MessageItemFieldCode, 0, MessageItemFieldTxt, 'RED GROUP 0');
    end;

    procedure MessageItemCode(): Code[128];
    begin
        exit(UpperCase('MessageItem'));
    end;

    procedure MessageItemFieldCode(): Code[128];
    begin
        exit(UpperCase('MessageItemField'));
    end;

    [EventSubscriber(ObjectType::CodeUnit, CodeUnit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsesToLibrary();
    begin
        CreateResponsesLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure OnExecuteWorkflowResponse(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance");
    var
        WorkflowResponse: Record "Workflow Response";
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        if not WorkflowResponse.Get(ResponseWorkflowStepInstance."Function Name") then
            exit;

        if WorkflowStepArgument.Get(ResponseWorkflowStepInstance.Argument) then;

        case WorkflowResponse."Function Name" of
            MessageItemCode():
                MessageItem(Variant);
            MessageItemFieldCode:
                MessageItem(Variant, WorkflowStepArgument."Field No. Red");
            else
                exit;
        end;
        ResponseExecuted := true;
    end;

    local procedure MessageItem(Variant: Variant)
    var
        Item: Record Item;
    begin
        Item := Variant;
        Message('Item No. is: %1', Item."No.");
    end;

    local procedure MessageItem(Variant: Variant; FieldNo: Integer)
    var
        Item: Record Item;
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.GetTable(Variant);
        FldRef := RecRef.Field(FieldNo);
        Message('Field no %1 value is: %2', FieldNo, FldRef.Value);
    end;

    var
        MessageItemTxt: Label 'Message with Item No';
        MessageItemFieldTxt: Label 'Message with Item Field No';
}