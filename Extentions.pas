unit Extentions;

interface

uses ObjStringStack;

TYPE
  TExtentionStack = Object( TStringStack )
    procedure LoadFromString( Const Str:String ); // *.xxx; *.yyy; ....
    //procedure SaveToString( Var Str:String );
  end;
  
implementation

procedure TExtentionStack.LoadFromString( Const Str:String ); // *.xxx; *.yyy; ....
 Var  i:Integer;
      State:(  ST_COLON, ST_STAR, ST_POINT, ST_EXT );
      PointPos  : Integer;
      C :Char;
      S : String;

begin
  State:=ST_COLON;
  for i:= 1 to Length(Str) do begin
    C:=Str[i];
    Case C of
      '*': if State=ST_COLON then State:=ST_STAR else Break;
      '.':
        if State=ST_STAR then begin
          State:=ST_POINT;
          PointPos:=i;
        end else Break; // an error occured
      ';': begin
        if State=ST_EXT then begin// Save
          S:=Copy(Str,PointPos, i-PointPos);
          PushString( S );
        end;
         State:=ST_COLON;// Save
      end;
      'a'..'z','A'..'Z','0'..'9','_','$':
        if State=ST_POINT
          then State:=ST_EXT
          else if State<>ST_EXT then Break;
      else
        if State=ST_EXT then begin// Save
          PushString( Copy(Str,PointPos, i-PointPos) );
        end
        else if State<>ST_COLON then Break;
    end;
  end;
end;

end.
 