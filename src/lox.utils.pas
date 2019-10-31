unit lox.utils;

interface

{$I lox.inc}

uses
  Classes,
  Generics.Collections;

type

  TEnumConversor<T: record> = class
  public
    class function ToString(const Enum: T): string; reintroduce; overload;
    class function ToEnum(const Str: string): T;
    class function ToEnumDef(const Str: string; const Default: T): T;
  end;

function AnsiStringToFloat(const Str: PAnsiChar; endptr: Pointer): Double; {$IFNDEF CPU64BITS} cdecl; {$ENDIF}

implementation

uses
  SysUtils,
  TypInfo,
  windows;

function AnsiStringToFloat; external 'msvcrt' name 'strtod';

{ TEnumConversor }

class function TEnumConversor<T>.ToEnum(const Str: string): T;
var
  P: ^T;
  num: Integer;
begin
  try
    num := GetEnumValue(TypeInfo(T), Str);
    if num = -1 then
      abort;

    P := @num;
    result := P^;
  except
    raise EConvertError.Create('O Par�metro "' + Str + '" passado n�o ' +
      sLineBreak + ' corresponde a um Tipo Enumerado ' + GetTypeName(TypeInfo(T)));
  end;
end;

class function TEnumConversor<T>.ToEnumDef(const Str: string; const Default: T): T;
var
  P: ^T;
  num: Integer;
begin
  try
    num := GetEnumValue(TypeInfo(T), Str);
    if num = -1 then
      abort;

    P := @num;
    result := P^;
  except
    Result := Default;
  end;
end;

class function TEnumConversor<T>.ToString(const Enum: T): string;

type
  TGenerico = 0..255;

var
  P: PInteger;
  num: Integer;
begin

  try
    P := @Enum;
    num := Integer(TGenerico((P^)));
    result := GetEnumName(TypeInfo(T), num);
  except
    raise EConvertError.Create('O Par�metro passado n�o corresponde a ' +
      sLineBreak + 'Ou a um Tipo Enumerado ' + GetTypeName(TypeInfo(T)));
  end;
end;

end.
