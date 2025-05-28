class Universidad {
  var nombre
  var provincia
  var honorarios
  var donacionTotal = 0
  method donacionTotal() = donacionTotal
  method nombre() = nombre
  method honorarios() = honorarios
  method provincia() = provincia
  method donacion(cantidad) {donacionTotal += cantidad}
}
class ProfesionalVinculado {
  var nombre
  var universidad
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = universidad.honorarios()
  method dondePuedeTrabajar() = universidad.provincia()
  method cobro(cantidad) {universidad.donacion(cantidad / 2)}
}
class ProfesionalAsociado {
  var nombre
  var universidad
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = 3000
  method dondePuedeTrabajar() = #{'Entre Ríos', 'Santa Fe','Corrientes'}
  method cobro(cantidad) {apl.donacion(cantidad)}
}
object apl {
  var donacionTotal = 0
  method donacionTotal() = donacionTotal
  method donacion(cantidad) {donacionTotal += cantidad}
}
class ProfesionalLibre {
  var nombre
  var universidad
  var honorarios
  var provincias
  var plata = 0
  method nombre() = nombre
  method universidad() = universidad
  method honorarios() = honorarios
  method dondePuedeTrabajar() = provincias
  method cobro(cantidad) {plata += cantidad}
  method pasarPlata(persona,cantidad) {
    if(plata < cantidad) {
      self.error('plata insuficiente')
    } else {
      plata -= cantidad
      persona.cobro(cantidad)
    }
  }
  method plata() = plata
}
class Empresa {
  var empleados = #{}
  var honorarios
  var clientes = #{}
  method clientes() = clientes
  method honorarios() = honorarios
  method empleados() = empleados
  method contratar(profesional) = empleados.add(profesional)
  method cuantosEstudiaronEn(uni) = empleados.filter({x=>x.universidad() == uni}).size()
  method conjuntoCaros() = empleados.filter({e=>e.honorarios() > self.honorarios()}).map({e=>e.nombre()}).asSet()
  method profesionalBarato() = #{empleados.min({e=>e.honorarios()}).nombre()}
  method uniFormadoras() = empleados.map({e=>e.universidad()}).asSet()
  method esDeGenteAcotada() = empleados.all({e=>e.dondePuedeTrabajar().size() >= 3})
  method puedeSatisfacer(solicitante) = empleados.any({e=>solicitante.puedeSerAtendido(e)})

  method darServicio(solicitante){
    if(not self.puedeSatisfacer(solicitante)){
      self.error('No hay profesionales para atenderte flaco')
    }
    else {
      var profesionalATrabajar = empleados.find({e=>solicitante.puedeSerAtendido(e)})
      profesionalATrabajar.cobro(profesionalATrabajar.honorarios())
      clientes.add(solicitante.nombre())
    }
  }
}
class Persona {
  const nombre
  const provincia
  method nombre() = nombre
  method puedeSerAtendido(profesional) = profesional.dondePuedeTrabajar().contains(provincia)
}
class Institucion {
  const universidades
  method puedeSerAtendido(profesional) = universidades.contains(profesional.universidad())
}
class Club {
  const provincias
  method provincias() = provincias
  method puedeSerAtendido(profesional) = provincias.any({p=> profesional.dondePuedeTrabajar().contains(p)})
}
// asd