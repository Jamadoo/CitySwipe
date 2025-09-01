unit VibrateHelper_u;

interface

type
  TVibrateHelper = class(TObject)
    public
      class procedure TryVibrate(const AMilliseconds: Cardinal = 200); static;
    private
  end;

implementation

uses
  System.SysUtils,
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.Os,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNIBridge,
{$ENDIF}
{$IFDEF IOS}
  iOSapi.AudioToolbox, // kSystemSoundID_Vibrate + AudioServicesPlaySystemSound
{$ENDIF}
  FMX.Platform;

class procedure TVibrateHelper.TryVibrate(const AMilliseconds: Cardinal);
{$IFDEF ANDROID}
var
  Vibrator: JVibrator;
{$ENDIF}
begin
{$IFDEF ANDROID}
  // Obtain the Android Vibrator service
  Vibrator := TJvibrator.Wrap
    ((TAndroidHelper.Context.getSystemService
      (TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);

  // Check first – some tablets/TV boxes have no vibration motor
  if (Vibrator <> nil) and Vibrator.hasVibrator then
    Vibrator.vibrate(AMilliseconds);
{$ENDIF}
{$IFDEF IOS}
  // kSystemSoundID_Vibrate does nothing on devices that lack a Taptic engine,
  // so we can just call it – it's effectively our “is-supported” check.
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
{$ENDIF}
  // On Windows, macOS and Linux the call compiles away (no vibration support).
end;

end.
