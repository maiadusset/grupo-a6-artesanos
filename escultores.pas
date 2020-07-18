Program escultores;
uses Windows;

// AMBIENTE
const
  numerosChar = ['0'..'9']; // del 0 al 9.
  a_dir = '../escultores-secuencia.txt';
var
  a_sec : File of Char;
  v_sec : Char;
  continente, nombre, anioChar : ShortString;
  eleccion_usuario : Char;
  total_escultores, anioInt, total_incorrectos : Integer;

// PROCEDIMIENTOS
procedure reiniciarTemp;
begin
  continente := '';
  nombre := '';
  anioChar := '';
end;

// FUNCIONES
function devolverContinente(continente: ShortString): ShortString;
var
  resp : ShortString;
begin
  case continente of
    'X' : resp := 'America';
    'E' : resp := 'Europa';
    'F' : resp := 'Africa';
    'A' : resp := 'Asia';
  end;
  devolverContinente := resp;
end;

function hayQueInvertir(anio : Integer): Boolean;
var
  resp : Boolean;
  dig1, dig2 : Integer;
begin
  resp := False;
  dig1 := (anio DIV 1000);
  if (dig1 >= 3) or (dig1 = 0) then
  begin
    resp := True;
  end
  else
  begin
    dig2 := ((anio DIV 100) MOD 10);
    if (dig2 <> 0) and (dig2 <> 9) then
    begin
      resp := True;
    end;
  end;
  WriteLn('+Invertir?: ', resp);
  hayQueInvertir := resp;
end;

function invertir(anioIncorrecto : Integer): Integer;
var
  n, m, i : Integer;
begin
  total_incorrectos := total_incorrectos + 1;
  n := anioIncorrecto;
  m := 0;

  for i:=1 to 4 do
  begin
    m := (m * 10) + (n MOD 10);
    n := (n DIV 10);
  end;
  WriteLn('Entrada: ', anioIncorrecto);
  WriteLn('Invertido: ', m);
  invertir := m;
end;

// ALGORITMO
begin

  // Colocar consola en UTF8 (acentos, ñ, etc).
  SetConsoleOutputCP(CP_UTF8);
  Assign(a_sec, a_dir);

  // Manejo de errores.
  {$I-}
  Reset(a_sec);
  {$I+}
  if IOResult <> 0 then // Si el IOResult es 0 no hay error.
  begin
    WriteLn('ERROR: Por favor, cree un archivo .txt llamado "escultores-secuencia.txt"');
    halt(2); // Detiene programa.
  end;

  // Iniciar contadores.
  total_escultores := 0;

  // Preguntar continente.
  WriteLn('¿Que continente desea consultar?');
  WriteLn('X -> América | E -> Europa | F -> Africa | A -> Asia');
  ReadLn(eleccion_usuario);

  // Análisis de secuencia.
  while not Eof(a_sec) do
  begin

    total_escultores := total_escultores + 1;

    // Reiniciar temporales.
    reiniciarTemp;

    Read(a_sec, v_sec);
    WriteLn('----------------');

    // CONTINENTE:
    continente := v_sec;
    WriteLn('Continente: ', devolverContinente(continente));
    Read(a_sec, v_sec);

    // NOMBRE:
    while not (v_sec in numerosChar) do // Mientras no sea un numero, es decir año, hacer:
    begin
      nombre := nombre + v_sec; // Concatenar dos caracteres.
      Read(a_sec, v_sec);
    end;
    WriteLn('Nombre es: ', nombre);

    // AÑO:
    while (v_sec <> '|') do
    begin
      anioChar := anioChar + v_sec;
      Read(a_sec, v_sec); 
    end;
    Val(anioChar, anioInt);

    if (hayQueInvertir(anioInt)) then
    begin
      anioInt := invertir(anioInt);
    end;
    WriteLn('Año: ', anioInt);


    // SIGUIENTE ESCULTOR...
  end;

  Close(a_sec);
  WriteLn('Análisis terminado.');

end.