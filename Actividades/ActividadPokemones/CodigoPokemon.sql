Create database PKM;
-- DROP DATABASE PKM
use PKM;

Create table Regiones
(
	IDRegion int primary key not null auto_increment,
    Nombre varchar(25),
    Clima varchar(25)
);
Create table Ciudades
(
	IDCiudad int primary key not null auto_increment,
    Nombre varchar(25),
    Poblacion int, 
    IDRegion int,
    foreign key (IDRegion) references Regiones(IDRegion)
);
Create table Entrenadores
(
	IDEntrenador int primary key not null auto_increment,
    Nombre varchar(25),
    Edad int, 
    IDCiudad int,
    foreign key (IDCiudad) references Ciudades(IDCiudad)
);
Create table Especies
(
	IDEspecie int primary key not null auto_increment,
    Nombre varchar(25),
    NumPokeDex int, 
    TipoElemento varchar(25),
    IDRegion int,
    foreign key (IDRegion) references Regiones(IDRegion)
);
Create table Pokemones
(
	IDPokemon int primary key not null auto_increment,
    Nombre varchar(25),
    Nivel int,
    IDEntrenador int,
    foreign key (IDEntrenador) references Entrenadores(IDEntrenador),
    IDEspecie int,
    foreign key (IDEspecie) references Especies(IDEspecie)
);
Create table Evoluciones
(
	IDEvolucion int primary key not null auto_increment,
    IDFaseNueva int,
    foreign key (IDFaseNueva) references Especies(IDEspecie),
    IDFasePrevia int,
    foreign key (IDFasePrevia) references Especies(IDEspecie)
);
Create table HistorialEvoluciones
(
	IDHistorial int primary key not null auto_increment,
    Fecha date, 
    MetodoEvolucion text,
    IDPokemon int,
    foreign key (IDPokemon) references Pokemones(IDPokemon),
    IDEvolucion int,
    foreign key (IDEvolucion) references Evoluciones(IDEvolucion)
);
Create table Gimnasios
(
	IDGimnasio int primary key not null auto_increment,
    Nombre Varchar(50), 
    TipoElemento varchar(25),
    IDLider int,
    foreign key (IDLider) references Entrenadores(IDEntrenador),
    IDCiudad int,
    foreign key (IDCiudad) references Ciudades(IDCiudad)
);
Create table Objetos
(
	IDObjeto int primary key not null,
    Nombre varchar(25),
    descripcion text
);
Create table Equipos
(
	IDRegistro int primary key not null,
    IDEntrenador int,
    foreign key (IDEntrenador) references Entrenadores(IDEntrenador),
    IDPokemon int,
    foreign key (IDPokemon) references Pokemones(IDPokemon),
    IDObjeto int, 
    foreign key (IDObjeto) references Objetos(IDObjeto)
);
Create table Batallas
(
	IDBatalla int primary key not null auto_increment,
    Fecha date, 
    Ganador enum("Atacante", "Defensor"),
    IDAtacante int,
    foreign key (IDAtacante) references Entrenadores(IDEntrenador),
    IDDefensor int,
    foreign key (IDDefensor) references Entrenadores(IDEntrenador)
);
Create table BatallasGimnasios
(
	IDBatallaGimnasio int primary key not null auto_increment,
    IDBatalla int,
    foreign key (IDBatalla) references Batallas(IDBatalla),
    IDGimnasio int,
    foreign key (IDGimnasio) references Gimnasios(IDGimnasio)
);

insert into Regiones(Nombre, Clima) values
( "Kanto", "Templado"),
("Johto", "Humedo");

insert into Ciudades(Nombre, Poblacion, IDRegion) values
("Isla Canela", 50, 1),
("Ciudad Malva", 200, 2);

insert into Entrenadores(Nombre, Edad, IDCIudad) values
("Red", 10, 1),
("Gold", 11, 2);

insert into Especies(Nombre, NumPokeDex, TipoElemento, IDRegion) values
("Charmander", 4, "Fuego", 1),
("Charmeleon", 5, "Fuego", 2);

insert into Pokemones(Nombre, Nivel, IDEntrenador, IDEspecie) values
("Pepe", 4, 1, 1),
("Pepe", 20, 2, 2);

insert into Evoluciones(IDFaseNueva, IDFasePrevia) values
(2, 1);

insert into HistorialEvoluciones(Fecha, MetodoEvolucion, IDPokemon, IDEvolucion) values
("2026-08-03", "Nivel", 2, 1);

insert into Gimnasios(Nombre, TipoElemento, IDLider, IDCiudad) values
("Gimnasio de Isla Canela", "Fuego", 1, 1),
("Gimnasio de Ciudad Malva", "Volador", 2, 2);

insert into Equipos(IDEquipo, ObjetoEquipado, IDPokemon) values
(1, "Restos", 2), (1, "Restos", 1);




select e.nombre, e.edad, c.nombre as ciudad
from entrenadores e
inner join ciudades c on e.IDCiudad = c.IDCiudad
