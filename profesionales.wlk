class Universidad {
  var nombre
  var provincia
  var honorarios
  method nombre() = nombre
  method honorarios() = honorarios
  method provincia() = provincia
}
class ProfesionalVinculado {
  var nombre
  var universidad
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = universidad.honorarios()
  method dondePuedeTrabajar() = universidad.provincia()
}
class ProfesionalAsociado {
  var nombre
  var universidad
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = 3000
  method dondePuedeTrabajar() = #{'Entre Ríos', 'Santa Fe','Corrientes'}
}
class ProfesionalLibre {
  var nombre
  var universidad
  var honorarios
  var provincias
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = honorarios
  method dondePuedeTrabajar() = provincias
}
class Empresa {
  var empleados = #{}
  var honorarios
  method honorarios() = honorarios
  method empleados() = empleados
  method contratar(profesional) = empleados.add(profesional)
  method cuantosEstudiaronEn(uni) = empleados.filter({x=>x.universidad() == uni}).size()
  method conjuntoCaros() = empleados.map({e=>e.universidad()}).map({e=>e.nombre()}).asSet()
  method profesionalBarato() = #{empleados.min({e=>e.honorarios()}).nombre()}
  method uniFormadoras() = empleados.map({e=>e.universidad()})
  method esDeGenteAcotada() = empleados.all({e=>e.dondePuedeTrabajar().size() >= 3})
}