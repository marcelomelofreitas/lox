unit lox.main;

interface

procedure Main;

implementation

uses
  System.IOUtils,
  windows,
  SysUtils,
  lox.chunk,
  lox.debug,
  lox.vm;

procedure Repl();
var
  Linha: array[0..1023] of Byte;
  str: UTF8String;
  Count: LongInt;
begin

  Writeln('Bem-vindo ao Luke 1.0.1 (alpha) 31/10/2019 - Se7e Sistemas LTDA - Todos os direitos reservados.');

  while true do
  begin
    Write('> ');

    Count := Length(Linha);

    if not ReadFile(GetStdHandle(STD_INPUT_HANDLE), Linha, Count, LongWord(Count), nil) then
      Count := 0;

    if Count = 0 then
    begin
      Writeln('');
      break;
    end;


    str := UTF8Encode(TEncoding.ANSI.GetString(Linha));
    str[Count-1] := #0;

    Interpret(Str);
  end;

end;

procedure RunFile(Path: string);
var
  Source: string;
  Return: TInterpretResult;
begin
  Source := TFile.ReadAllText(Path);

  Return := Interpret(UTF8Encode(Source));

  if (Return = TInterpretResult.INTERPRET_COMPILE_ERROR) then
    Halt(65)
  else if (Return = TInterpretResult.INTERPRET_RUNTIME_ERROR) then
    Halt(70);
end;


procedure Main;
begin
  InitVM();

  if (ParamCount = 0) then
    Repl()
  else if (ParamCount = 1) then
    RunFile(ParamStr(1))
  else
  begin
    Writeln('Usage: luke [path]');
    Halt(64);
  end;

  FreeVM();
end;

end.
