require 'httparty'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


URL='https://sepa.utem.cl/rest/api/v1'
AUTH = {username: '2E5Vw7WUCm', password: '0754e0cbf6df85c40be0715e643c9f1c'}

#Anio Docentes
#
#
#
def anio
  docente = '/academia/docentes'
  respuesta = HTTParty.get(URL.encode+docente, basic_auth: AUTH)

  lista = []
  lista2 = []
  respuesta.each do |data|
    lista2 = data['fechaNacimiento']
    if lista2 < '1980'
    lista << data['nombres']
      lista << data['fechaNacimiento']
    end
    File.open('alhambrasaavedra',"w") do |f|
      f.puts lista
    end
  end

  puts lista

end

def asignaturas1
  asignatura = '/docencia/asignaturas'
  respuesta = HTTParty.get(URL.encode+asignatura, basic_auth: AUTH)
  lista = []
  lista2 = []
  respuesta.each do |data|
    lista2 = data['codigo']
    if lista2.include? "INF"
      lista << data['nombre']
      lista << data['codigo']
    end
    File.open('alhambrasaavedra',"w") do |f|
      f.puts lista
    end
  end
  puts lista
end

def anio2015
  #asignatura2015 = '/docencia/asignaturas/'{codigo}'/cursos'
  respuesta = HTTParty.get(URL.encode+asignatura2015, basic_auth: AUTH)
  lista = []
  lista2 = []
  respuesta.each do |data|
    lista2 = data['anio']
    if lista2 == 2015
    lista << data['asignatura']
    lista << data['anio']
    end
    File.open('alhambrasaavedra',"w") do |f|
      f.puts lista
    end
  end
  puts lista
end



def menu
  print "Tarea 1 Ingenieria de Software\n"
  print "1.- Asignaturas INF\n"
  print "2.- Total asignaturas INF impartidas en 2015\n"
  print "3.- Nómina de todos los docentes nacidos antes del 1980\n"
  print "4.- Salir\n"
  print "0.- Volver al menu\n"
  opcion = gets.to_i
  case opcion
  when 1
    asignaturas1
    menu
  when 2
    anio2015
    menu
    print "\n"
  when 3
    anio
    menu
    print "\n"
  when 4
    print "Adios\n"
  when 0
    menu

  end
end

menu
