program CitySwipe_p;

uses
  System.StartUpCopy,
  FMX.Forms,
  CitySwipe_u in 'CitySwipe_u.pas' {frmCitySwipe},
  dmDataComponents_u in 'dmDataComponents_u.pas' {dmDataComponents: TDataModule},
  GoogleMaps_u in 'GoogleMaps_u.pas',
  Coordinate_u in 'Coordinate_u.pas',
  JsonRead_u in 'JsonRead_u.pas',
  GoogleMapClass_u in 'GoogleMapClass_u.pas',
  VibrateHelper_u in 'VibrateHelper_u.pas',
  URLLauncher_u in 'URLLauncher_u.pas',
  frmGroupCreation_u in 'frmGroupCreation_u.pas' {frmGroupCreation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCitySwipe, frmCitySwipe);
  Application.CreateForm(TdmDataComponents, dmDataComponents);
  Application.CreateForm(TfrmGroupCreation, frmGroupCreation);
  Application.Run;
end.
