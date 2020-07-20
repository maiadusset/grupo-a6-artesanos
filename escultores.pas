Program escultores;
uses Windows;

// AMBIENTE
const
  numerosChar = ['0'..'9']; // del 0 al 9.
  a_dir = './escultores-secuencia.txt';
var
  a_sec : File of Char;
  v_sec : Char;
  continente, nombre, anioChar : ShortString;
  eleccion_usuario : Char;
  total_escultores, anioInt, total_incorrectos : Integer;
  porcentaje : Real;
  guardarEscultor : Boolean;

// PROCEDIMIENTOS
procedure reiniciarTemp;
begin
  continente := '';
  nombre := '';
  anioChar := '';
  guardarEscultor := False;
end;

procedure iniciarVariables;
begin
  total_escultores := 0;
  total_incorrectos := 0;
  guardarEscultor := False;
end;

// FUNCIONES
function devolverContinente(continente: ShortString): ShortString;
var
  resp : ShortString;
begin
  case continente of
    'X' : resp := 'América';
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

  // Iniciar variables.
  iniciarVariables;

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

    // CONTINENTE:
    continente := v_sec;
    if (continente = eleccion_usuario) then
      guardarEscultor := True;
    // devolverContinente(continente));
    Read(a_sec, v_sec);

    // NOMBRE:
    while not (v_sec in numerosChar) do // Mientras no sea un numero, es decir año, hacer:
    begin
      nombre := nombre + v_sec; // Concatenar dos caracteres.
      Read(a_sec, v_sec);
    end;

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

    if (guardarEscultor) then
    begin
      // Escribir secuencia de salida acá. Usando variables temporales guardadas anteriormente.

    end;
    // SIGUIENTE ESCULTOR...
  end;

  Close(a_sec);
  WriteLn('Análisis terminado.');

  porcentaje := (total_incorrectos * 100) / total_escultores;
  WriteLn('Porcentaje de incorrectos sobre total de escultores: ', Round(porcentaje), '%');

  

end.