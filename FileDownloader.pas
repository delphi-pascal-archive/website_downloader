unit FileDownloader;

interface

uses Windows, Forms, Classes, WinInet, SysUtils, Grids, StdCtrls, Dialogs,
    StrUtils, FonctionsChaine, UrlTools;

Type
 tFileDownloader = class
    PConnexionInternet : HINTERNET;
    PConnexionHTTP     : HINTERNET;
    destructor Destroy;
    function  Connexion   ( URL : string ) : Boolean;
    function GetFileToLocalFile( FileName : string ):String;
 end;

implementation

function tFileDownloader.Connexion( URL : string ) : Boolean;
begin
  Result:=False;
  PConnexionInternet := InternetOpen( PChar( Application.Title ), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0 );
  if PConnexionInternet<>nil then begin
    PConnexionHTTP := InternetOpenUrl( PConnexionInternet, PChar( URL ), nil , 0, INTERNET_FLAG_RELOAD, 0 );
    if (PConnexionHTTP = nil)
        then InternetCloseHandle( PConnexionInternet )
        else Result:=True;
  end;
end;

function tFileDownloader.GetFileToLocalFile( FileName : string ):String;
var
    Buffer    : Array[1..4096] of Char;
    BufferLen : DWORD;
    Fichier   : File;
    indexF    : Integer;
    TempFileName : string;
begin
    TempFileName := FileName;
    indexF := 0;
    AssignFile( Fichier, TempFileName );
    Rewrite   ( Fichier, 1 );
    repeat
        Wininet.InternetReadFile( PConnexionHTTP, @Buffer, SizeOf(Buffer), BufferLen );
        BlockWrite( Fichier, Buffer, BufferLen );
        Application.ProcessMessages
    until (BufferLen = 0);
    CloseFile( Fichier );

    Result:=TempFileName;
end;

destructor tFileDownloader.Destroy;
begin
    inherited Destroy();
    InternetCloseHandle( PConnexionInternet );
    InternetCloseHandle( PConnexionHTTP     );
end;

end.

