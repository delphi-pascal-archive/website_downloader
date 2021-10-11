unit UnitFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormFilter = class(TForm)
    GroupBox1: TGroupBox;
    IncFileExt: TRadioButton;
    ExcFileExt: TRadioButton;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    ExcHost: TRadioButton;
    IncHost: TRadioButton;
    ExcChilds: TRadioButton;
    IncChilds: TRadioButton;
    ExcParents: TRadioButton;
    IncParents: TRadioButton;
    EditParents: TEdit;
    EditChilds: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox5: TGroupBox;
    ExcParse: TRadioButton;
    IncParse: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFilter: TFormFilter;

  // filter
  useFilterHost : Boolean;
  useFilterParents : Boolean;
  useFilterChilds : Boolean;
  useFilterFileExt : Boolean;
  useFilterParseHtml : Boolean;
  FileExt : TStringList;

  ParentsCount : Integer;
  ChildsCount : Integer;

implementation

{$R *.dfm}



procedure TFormFilter.FormShow(Sender: TObject);
begin
 if usefilterhost then IncHost.Checked:=True else ExcHost.Checked:=True;
 if usefilterParents then IncParents.Checked:=True else ExcParents.Checked:=True;
 if usefilterChilds then begin
    IncChilds.Checked:=True;
    EditParents.Text:=IntToStr(ParentsCount);
 end else ExcChilds.Checked:=True;

 if usefilterChilds then ChildsCount:=StrToInt(EditChilds.Text);
 if usefilterFileExt then IncFileExt.Checked:=True else ExcFileExt.Checked:=True;
 if usefilterParseHtml then IncParse.Checked:=True else ExcParse.Checked:=True;
end;

procedure TFormFilter.Button1Click(Sender: TObject);
begin
 usefilterFileExt:=IncFileExt.Checked;
 usefilterhost:=IncHost.Checked;
 usefilterParents:=IncParents.Checked;
 if usefilterParents then ParentsCount:=StrToInt(EditParents.Text);
 usefilterChilds:=IncChilds.Checked;
 if usefilterChilds then ChildsCount:=StrToInt(EditChilds.Text);
 usefilterParseHtml:=IncParse.Checked;
 Close;
end;

procedure TFormFilter.Button2Click(Sender: TObject);
begin
 Close;
end;

initialization
  useFilterHost :=True;
  useFilterParents :=True;
  useFilterChilds :=True;
  useFilterFileExt :=True;
  useFilterParseHtml :=True;
  FileExt :=TStringList.Create;
end.
