unit dmDataComponents_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.IOUtils, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, System.Sensors,
  System.Sensors.Components, FireDAC.FMXUI.Wait;

type
  TdmDataComponents = class(TDataModule)
    conDatabase: TFDConnection;
    qryDatabase: TFDQuery;
    dsrDatabase: TDataSource;
    WhatTheHellAnator: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    sDataFolder, sDBPath, sConfigPath : string;
  end;

var
  dmDataComponents: TdmDataComponents;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TdmDataComponents.DataModuleCreate(Sender: TObject);
var
  exePath : string;
begin
  // Automatic Connection
  {$IFDEF MSWINDOWS}
    // On Windows, tab back until projectfolder
    exePath := ExtractFilePath(ParamStr(0));
    exePath := Copy(exePath, 0, exePath.Length - 1);
    exePath := Copy(exePath, 0, exePath.LastIndexOf('\'));
    exePath := Copy(exePath, 0, exePath.LastIndexOf('\'));
    sDataFolder := TPath.Combine(exePath, 'DataFiles');
    sDBPath := TPath.Combine(sDataFolder, 'Database6.sqlite');
  {$ELSE}
    // On Android, iOS, etc, use Documents folder
    sDataFolder := TPath.GetDocumentsPath;
    sDBPath := TPath.Combine(sDataFolder, 'Database6.sqlite');
  {$ENDIF}
  // Finsih Connection
  conDatabase.Params.DriverID := 'SQLite';
  conDatabase.Params.Database := sDBPath;
  conDatabase.Connected := True;
  // Setup Folders For Refrence > First to access these paths, so might as well save them
  sConfigPath := TPath.Combine(sDataFolder, 'Config4.json');
end;

end.
