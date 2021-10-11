// 10 - 08 - 2007

UNIT    ObjStringStack; 

INTERFACE

TYPE

  pStringStackItem = ^tStringStackItem;
  tStringStackItem = Object
    Next    : pStringStackItem;
    Name    : ShortString;
  end;

  pStringStack = ^tStringStack;
  tStringStack = Object
    Head    : pStringStackItem;
    PROCEDURE Init;
    procedure PushString( Const S: String );
    procedure PopString;
    function FindString( Const S: String ):pStringStackItem;
    function DelString( Const S: String ):Boolean;
  end;

IMPLEMENTATION

{##############################################################################}
{##############################################################################}
PROCEDURE tStringStack.Init;
Begin
  head := nil;
End;

procedure tStringStack.PushString( Const S: String );
 Var    NewItem : pStringStackItem;
begin
  GetMem( NewItem,Length(S)+5 );
  NewItem^.Name:=S;
  NewItem^.Next:=Head;
  Head := NewItem;
end;

procedure tStringStack.PopString;
 Var    Item : pStringStackItem;
begin
  if Head=NIL then Exit;
  Item:=Head.Next;
  FreeMem( Head,Length(Head^.Name)+5 );
end;

function tStringStack.FindString( Const S: String ):pStringStackItem;
 Var    Item : pStringStackItem;
begin
  Item:=Head;
  while (Item<>NIL) do begin
    if (Item^.Name=S) then begin
        Result:=Item;
        Exit;
    end;
    Item:=Item^.Next;
  end;
  Result:=NIL;
end;

function tStringStack.DelString( Const S: String ):Boolean;
 Var    Current , Previous : pStringStackItem;
begin
  Previous:=Head;
  Current:=Head;
  while (Current<>NIL) do
    if (Current^.Name=S) then begin
        if (Current=Head)
            then begin
              Previous:=Current^.Next;
              Head:=Previous;
            end
            else Previous^.Next:=Current^.Next;
        FreeMem( Current,Length(Current^.Name)+5 );
        Result:=True;
        Exit;
    end else begin
        Previous:=Current;
        Current:=Current^.Next;
    end;
  Result:=False;
end;


END.