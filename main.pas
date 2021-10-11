unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wininet, StdCtrls, Buttons, CheckLst, ComCtrls, Menus,
  UrlTools, FileDownloader, UnitFilter, Extentions;

type
  TMainPage = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditDestination: TEdit;
    Status: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    EditURL: TEdit;
    GroupBox2: TGroupBox;
    ListeLien: TListBox;
    Option1: TMenuItem;
    Filter1: TMenuItem;
    Label3: TLabel;
    ButDownload: TButton;
    ListBox1: TListBox;
    ProgressBar1: TProgressBar;
    procedure BtnDownLoadClick(Sender: TObject);
    procedure Filter1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
end;

var
    MainPage: TMainPage;

implementation

{$R *.dfm}

uses HtmlParser;

Const
 FilterCount = 13;
 ExtFilter : Array[1..FilterCount]of string =
      ( '.CSS',
        '.HTML', '.HTM',
        '.GIF', '.BMP', '.PNG','.ICO',
        '.H','.C','.CPP','.HPP','.PAS','.BAS'
      );
function FindExt(Ext:String):Boolean;
 Var    i: Integer;
begin
 for i:=1 to FilterCount do
   if (Ext=ExtFilter[i]) then begin
        Result:=True;
        Exit;
   end;
 Result:=False;
end;

procedure SaveShortCut(Const Url,name:string);
var
    Fichier   : File;
    S   :String;
begin
    AssignFile( Fichier, Name );
    Rewrite( Fichier, 1 );
    S:='[InternetShortcut]'#13#10'URL='+Url;
    BlockWrite( Fichier, S[1], Length(S) );
    CloseFile( Fichier );
end;   

{ Bouton Analyser & Télecharger }
procedure TMainPage.BtnDownLoadClick(Sender: TObject);
var
    Aspirateur  : tFileDownloader;
    DownFichier : tFileDownloader;
    X           : Integer;
    LocalName   : String;
    UrlSite     : String;
    NumDownloads:Integer;

Var SrcHost, SrcPath, Srcfname, Srcfext:String;
Var host1,path1,fname1,fext1:String;
    SrcPathCount , PathCount  : Integer;
    DestinationDir :String;
    HtmlFile    : THtmlParser;
    HtmlLinks   : TStringList;   // Liste des liens trouvés
begin
    HtmlFile:= THtmlParser.Create;
    HtmlLinks := TStringList.Create;
    HtmlLinks.Clear;
    { Verification de présence de l'URL }
    if Trim(EditURL.Text) = '' then
    begin
        MessageBoxA( Handle, PChar('Entrez une URL !'), PChar('URL ?'), MB_ICONINFORMATION );
        Exit;
    end;

    SrcPathCount:=SplitFullURL(Trim(EditURL.Text), Srchost,Srcpath,Srcfname,Srcfext);
    if (SrcPathCount=-1) then Exit;
    UrlSite:='http://'+SrcHost+SrcPath+Srcfname+Srcfext;

    Status.SimpleText := 'Connection au site ...';
    { Crée l'objet }
    Aspirateur := tFileDownloader.Create;

    { Etablie connexion sur la page, si erreur Stop }
    if Aspirateur.Connexion( UrlSite ) = False then
    begin
        MessageBox( Handle, PChar('Impossible de joindre cette URL !'), PChar('URL ?'), MB_ICONINFORMATION );
        Aspirateur.Free;
        Exit;
    end;
    Application.ProcessMessages;
    { Récupère la page }
    Status.SimpleText := 'Telecharge la page ...';
    if SrcfName='' then SrcfName:='Directory Default Page';
    if SrcfExt='' then SrcfExt:='.html';

    ChDir(EditDestination.Text);
    CreateDir(SrcHost);
    DestinationDir:=Slach(EditDestination.Text)+SrcHost+'\';
    LocalName:=Aspirateur.GetFileToLocalFile( DestinationDir + Srcfname + Srcfext );
    Aspirateur.Free;
    SaveShortCut(UrlSite, DestinationDir + Srcfname +'.url');
    Application.ProcessMessages;

    { Parse et recupère les liens }
    Status.SimpleText := 'Analyse de la page ...';
    HtmlFile.LoadFromFile(LocalName);
    HtmlFile.ParseHtml('http://'+SrcHost+SrcPath,HtmlLinks);

    ListeLien.Items:=HtmlLinks;
    ListBox1.Clear;
    Application.ProcessMessages;
    if HtmlLinks.Count <= 0 then
         Status.SimpleText := 'Aucune image trouvé sur ce site !'
    else begin
        ProgressBar1.Max:=HtmlLinks.Count;
        NumDownloads:=0;
        Label3.Caption:=IntToStr(HtmlLinks.Count)+' Fichiers trouves';
        for X := 0 to (HtmlLinks.Count-1) do begin
            ProgressBar1.Position:=X;
            PathCount:=SplitFullURL(HtmlLinks.Strings[X], host1,path1,fname1,fext1);
            if (fname1='') then Continue;
            fext1:=Uppercase(fext1);
            // Check For Host Filter
            if useFilterHost then if host1<>Srchost then Continue;
            // Check for File Extention Filter
            if useFilterFileExt then begin
                if not FindExt(fext1) then Continue;
            end;
            // Check for Parent dir
            if useFilterParents then begin
                if host1<>Srchost then Continue;
                if SrcPathCount>PathCount+ParentsCount then Continue;
                //if pos(path1,SrcPath)<>1 then Continue;
            end;
            // Check for Other Filters
            if useFilterChilds then begin
                if host1<>Srchost then Continue;
                if PathCount>SrcPathCount+ChildsCount then Continue;
                //if pos(SrcPath,path1)<>1 then Continue;
            end;
            // Download File
            Status.SimpleText := 'Telechargement de : ' + fname1+fext1;
            DownFichier := tFileDownloader.Create;
            if DownFichier.Connexion( HtmlLinks.Strings[X] ) then begin
                LocalName:=DownFichier.GetFileToLocalFile( DestinationDir + fname1 + fext1 );
                // Parse File if it's HTML
                if useFilterParseHtml then
                 if (fext1='.HTML')or(fext1='.HTM') then begin
                    HtmlFile.LoadFromFile(LocalName);
                    HtmlFile.ParseHtml('http://'+SrcHost+SrcPath,HtmlLinks);
                    HtmlFile.Clear;
                    ListeLien.Items:=HtmlLinks;
                    //Label3.Caption:=IntToStr(Liens.Count)+' Fichiers trouves';
                end;
                ListBox1.Items.Add( HtmlLinks.Strings[X] );
                Inc(NumDownloads);
            end;
            DownFichier.Destroy;
            Application.ProcessMessages;
            end;
            Status.SimpleText := 'Terminé avec ' + IntToStr(NumDownloads) + ' fichiers téléchargés.';
        end;
   HtmlLinks.Destroy;
   HtmlFile.Destroy;
end;

{ A Propos }
procedure TMainPage.Filter1Click(Sender: TObject);
begin
 FormFilter.ShowModal;
end;

procedure TMainPage.FormCreate(Sender: TObject);
begin
 //Ext.Init;
 //Ext.LoadFromString('*.CSS;*.HTML;*.HTM;*.GIF;*.BMP;*.PNG;*.ICO;*.H;*.C;*.CPP;*.HPP;*.PAS;*.BAS');
end;

end.
