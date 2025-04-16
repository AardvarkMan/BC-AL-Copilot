page 50000 ARD_CopilotSettings
{
    ApplicationArea = All;
    Caption = 'AardvarkLabs Copilot Settings';
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Integer";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Endpoint; Endpoint)
                {
                    ApplicationArea = All;
                    Caption = 'Endpoint';
                    ToolTip = 'Enter the endpoint URL for the Copilot service.';

                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetEndpoint(Endpoint);
                    end;
                }
                field(Deployment; Deployment)
                {
                    ApplicationArea = All;
                    Caption = 'Deployment';
                    ToolTip = 'Enter the deployment name for the Copilot service.';
                    
                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetDeployment(Deployment);
                    end;
                }
                field(APIKey; UserAPIKey)
                {
                    ApplicationArea = All;
                    Caption = 'API Key';
                    ToolTip = 'Enter the API key for the Copilot service.';
                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetSecretKey(UserAPIKey);
                    end;
                }
                
            }
        }
    }

    var
    Endpoint: Text;
    Deployment: Text;
    UserAPIKey: Text;
    IsolatedStorageWrapper: Codeunit ARD_IsolatedStorageWrapper;
    
    trigger OnAfterGetRecord()
    begin
        UserAPIKey := '*****';
        GetSettings();
    end;

    local procedure GetSettings()
    begin
        Deployment := IsolatedStorageWrapper.GetDeployment();
        Endpoint := IsolatedStorageWrapper.GetEndpoint();
    end;
}
