Program escultores;
const
  numerosChar = ['0'..'9']; // del 0 al 9.
  a_dir = 'escultores-secuencia.txt';
var
  a_sec : File of Char;
  v_sec : Char;
  continente, nombre, anioChar : ShortString;
begin
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
  // Análisis de secuencia.
  while not Eof(a_sec) do
  begin
    // Reiniciar temporales.
    continente := '';
    nombre := '';
    anioChar := '';

    Read(a_sec, v_sec);
    // CONTINENTE:
    continente := v_sec;
    WriteLn('Continente: ', continente);
    Read(a_sec, v_sec);
    // NOMBRE:
    while not (v_sec in numerosChar) do // Mientras no sea un numero, es decir año, hacer:
    begin
      nombre := nombre + v_sec; // Concatenar dos caracteres.
      Read(a_sec, v_sec);
    end;
    WriteLn('Nombre es: ', nombre);
    // Año:
    while (v_sec <> '|') do
    begin
      anioChar := anioChar + v_sec;
      Read(a_sec, v_sec); 
    end;
    WriteLn('Anio: ', anioChar);
    // Siguiente:
    // Write(v_sec);
  end;
  Close(a_sec);
  WriteLn('Secuencia terminada.');
end.