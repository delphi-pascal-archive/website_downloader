{ ------------------------------------

   WebPicker - Aspirateur d'image
   Programme de démonstration
   Ecrit par LEVEUGLE Damien (c) 2005

  ------------------------------------  }

program WebSiteDownloader;

uses
  Forms,
  main in 'main.pas' {MainPage},
  UnitFilter in 'UnitFilter.pas' {FormFilter},
  Extentions in 'Extentions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Web Picker';
  Application.CreateForm(TMainPage, MainPage);
  Application.CreateForm(TFormFilter, FormFilter);
  Application.Run;
end.
