unit Stack;

interface

uses
  SharedTypes, System.SysUtils, Vcl.Graphics;


Type
  TStack = ^TStackElement;


  TStackElement = record
    Prev: TStack;
    Element: TPicture;
  end;

Const
  maxLengthOfStack = 1000;
  SpecialCharacter = nil;

implementation
  Procedure MakeStack(var Stack: TStack);
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


Procedure PopStack(var Stack: TStack);
var
  X: TStack;
begin
  X := Stack^.Prev;
  Dispose(Stack);
  Stack := X;
end;


Procedure PushStack(var Stack: TStack; const Picture: TPicture);
var
  X: TStack;
begin
  Stack^.Element := Picture;
  New(X);
  X^.Prev := Stack;
  Stack := X;
end;



Function IsStackEmpty(var Stack: TStack): Boolean;
begin
  if Stack^.Prev = nil then
    Result := True
  else
    Result := False;
end;


end.
