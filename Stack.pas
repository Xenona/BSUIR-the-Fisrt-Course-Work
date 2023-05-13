unit Stack;

interface

uses
  SharedTypes, System.SysUtils, Vcl.Graphics;


Type
  TStack = ^TStackElement;




  TStackElement = record
    Element: TPicture;
    Prev: TStack;

  end;

  TUStack = class
  Procedure MakeStack(var Stack: TStack);
  Procedure PopStack(var Stack: TStack);
  Procedure PushStack(var Stack: TStack; const Picture: TPicture);
  Function IsStackEmpty(var Stack: TStack): Boolean;
  Function TopStack(var Stack: TStack): TPicture;


  Private


  Public


  end;

Const
  maxLengthOfStack = 1000;
  SpecialCharacter = nil;

var
  CStack: TUStack;

implementation

Procedure TUStack.MakeStack(var Stack: TStack);
var
  X: TStack;
begin
  New(Stack);
  Stack^.Element := specialCharacter;
  Stack^.Prev := nil;
  X := Stack;
  New(Stack);
  Stack^.Prev := X;
end;


Procedure TUStack.PopStack(var Stack: TStack);
var
  X: TStack;
begin
  X := Stack^.Prev;
  Dispose(Stack);
  Stack := X;
end;


Procedure TUStack.PushStack(var Stack: TStack; const Picture: TPicture);
var
  X: TStack;
begin
  Stack^.Element := Picture;
  New(X);
  X^.Prev := Stack;
  Stack := X;
end;



Function TUStack.IsStackEmpty(var Stack: TStack): Boolean;
begin
  if Stack^.Prev = nil then
    Result := True
  else
    Result := False;
end;

Function TUStack.TopStack(var Stack: TStack): TPicture;
begin
//  Result := Stack^.Prev^.Element;
  Result := Stack^.Element;
end;


Procedure PopStack(var Stack: TStack);
var
  X: TStack;
begin
  X := Stack^.Prev;
  Dispose(Stack);
  Stack := X;
end;


end.
