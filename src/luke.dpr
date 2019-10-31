program luke;

uses
  lox.main in 'lox.main.pas',
  lox.consts in 'lox.consts.pas',
  lox.chunk in 'lox.chunk.pas',
  lox.memory in 'lox.memory.pas',
  lox.debug in 'lox.debug.pas',
  lox.value in 'lox.value.pas',
  lox.vm in 'lox.vm.pas',
  lox.compiler in 'lox.compiler.pas',
  lox.scanner in 'lox.scanner.pas',
  lox.utils in 'lox.utils.pas',
  lox.obj in 'lox.obj.pas',
  lox.table in 'lox.table.pas',
  lox.types in 'lox.types.pas';

begin
  Main();
end.
