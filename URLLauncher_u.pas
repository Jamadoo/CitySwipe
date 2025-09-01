unit URLLauncher_u;

interface

type
  /// <summary>
  ///  Opens a URL in the system's default browser.
  ///  The method is <c>static</c>; no instance of <see cref="TURLLauncher"/> is required.
  /// </summary>
  TURLLauncher = class
  public
    class procedure Open(const AUrl: string); static;
  end;

implementation

uses
  {$IFDEF MSWINDOWS}
  Winapi.Windows,
  Winapi.ShellAPI,
  System.SysUtils;
  {$ENDIF}
  {$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText,
  System.SysUtils,
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.Net;
  {$ENDIF}

{$IFDEF MSWINDOWS}
class procedure TURLLauncher.Open(const AUrl: string);
begin
  if ShellExecute(0, 'open', PChar(AUrl), nil, nil, SW_SHOWNORMAL) <= 32 then
    raise Exception.CreateFmt('ShellExecute failed for URL %s', [AUrl]);
end;
{$ENDIF}

{$IFDEF ANDROID}
class procedure TURLLauncher.Open(const AUrl: string);
var
  Intent: JIntent;
begin
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(TJnet_Uri.JavaClass.parse(StringToJString(AUrl)));
  Intent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
  TAndroidHelper.Context.startActivity(Intent);
end;
{$ENDIF}

end.

