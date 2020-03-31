codeunit 50100 "Red Workflow Events"
{
    procedure CreateEventsLibrary();
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(
            RunWorkflowAfterItemChangedCode, Database::Item, RunWorkflowAfterItemChangedTxt, 0, false);
    end;

    procedure RunWorkflowAfterItemChangedCode(): Code[128];
    begin
        exit(UpperCase('RunWorkflowAfterItemChanged'));
    end;

    [EventSubscriber(ObjectType::CodeUnit, CodeUnit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary();
    begin
        CreateEventsLibrary();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::Item, 'OnAfterModifyEvent', '', false, false)]
    local procedure RunWorkflowAfterRentalLogEntryToRented(var Rec: Record Item);
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowAfterItemChangedCode(), Rec);
    end;

    var
        RunWorkflowAfterItemChangedTxt: Label 'Red an item has been modified';
}