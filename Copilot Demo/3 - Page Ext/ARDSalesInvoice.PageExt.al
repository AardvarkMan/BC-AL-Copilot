pageextension 50003 ARD_SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter(SalesLines)
        {
            part(ResolutionNotes; ARD_ResolutionNotes)
            {
                ApplicationArea = All;
                SubPageLink = "ARD_SalesHeaderNo." = field("No.");
                Visible = true;
            }

            group(ResolutionNotesGroup)
            {
                Caption = 'Resolution Notes';
                field(ResolutionNotes_Text; ResolutionNotes)
                {
                    ApplicationArea = All;
                    Caption = 'Resolution Notes';
                    ToolTip = 'The generated resolution notes for this invoice.';
                    Editable = true;
                    MultiLine = true;
                    ShowCaption = false;
                    ExtendedDatatype = RichContent;

                    Trigger OnValidate()
                    begin
                        SetRichText(ResolutionNotes);
                    end;
                }
            }
        }
    }

    var
        ResolutionNotes: Text;

    trigger OnAfterGetCurrRecord()
    begin
        ResolutionNotes := GetRichText();
    end;

    procedure GetRichText(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        TextValue: Text;
        istream: InStream;
    begin
        Rec.CalcFields(ARD_ResolutionNote);
        Rec.ARD_ResolutionNote.CreateInStream(istream, TextEncoding::UTF16);
        TextValue := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(istream, TypeHelper.LFSeparator(), Rec.FieldName(ARD_ResolutionNote));
        exit(TextValue);
    end;

    procedure SetRichText(NewValue: Text)
    var
        oStream: OutStream;
    begin
        Rec.ARD_ResolutionNote.CreateOutStream(oStream, TextEncoding::UTF16);
        oStream.WriteText(NewValue, StrLen(NewValue));
        Rec.Modify();
    end;
}
