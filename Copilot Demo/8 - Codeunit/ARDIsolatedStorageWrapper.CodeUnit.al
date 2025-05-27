codeunit 50002 ARD_IsolatedStorageWrapper
{
    SingleInstance = true;
    Access = Internal;

    var
        IsolatedStorageSecretKeyKey: Label 'CopilotSecret', Locked = true;
        IsolatedStorageDeploymentKey: Label 'CopilotDeployment', Locked = true;
        IsolatedStorageEndpointKey: Label 'CopilotEndpoint', Locked = true;

    procedure GetSecretKey() SecretKey: Text
    begin
        if IsolatedStorage.Get(IsolatedStorageSecretKeyKey, SecretKey) = false then SecretKey := '';
    end;

    procedure GetDeployment() Deployment: Text
    begin
        if IsolatedStorage.Get(IsolatedStorageDeploymentKey, Deployment) = false then Deployment := '';
    end;

    procedure GetEndpoint() Endpoint: Text
    begin
        if IsolatedStorage.Get(IsolatedStorageEndpointKey, Endpoint) = false then Endpoint := '';
    end;

    procedure SetSecretKey(SecretKey: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageSecretKeyKey, SecretKey);
    end;

    procedure SetDeployment(Deployment: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageDeploymentKey, Deployment);
    end;

    procedure SetEndpoint(Endpoint: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageEndpointKey, Endpoint);
    end;

}