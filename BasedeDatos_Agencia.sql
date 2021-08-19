drop database if exists Agencia;
create database Agencia;
use Agencia;

Create table TipoUsuario(
CodTipoUsuario int auto_increment,
Nombre varchar(30),
CONSTRAINT PK_TipoUsuario PRIMARY KEY (CodTipoUsuario)
)Engine=InnoDB;

Create table Usuario(
CodUsuario int auto_increment,
NombreUsuario varchar(50),
Contrasena varchar(25),
CodTipoUsuario int,
CONSTRAINT PK_Usuario PRIMARY KEY(CodUsuario),
CONSTRAINT FK_Usuario_TipoUsuario FOREIGN KEY(CodTipoUsuario) REFERENCES TipoUsuario(CodTipoUsuario)
)Engine=InnoDB;

create table Persona(
CodPersona int auto_increment,
Nombre varchar(30),
Apellido varchar(40),
DNI varchar(8),
FechaNac date,
CONSTRAINT PK_CodPersona PRIMARY KEY (CodPersona)
)Engine=InnoDB;

create table Cliente(
CodCliente int auto_increment,
CodPersona int,
Email varchar(70),
CONSTRAINT PK_CodCliente PRIMARY KEY (CodCliente),
CONSTRAINT FK_Persona_Cliente FOREIGN KEY (CodPersona) REFERENCES Persona(CodPersona)
)Engine=InnoDB;

create table TipoMicro(
CodTipoMicro int auto_increment,
Tipo varchar(30),
CantAsientos int,
CONSTRAINT PK_TipoMicro PRIMARY KEY (CodTipoMicro)
)Engine=InnoDB;

create table Destino(
CodDest int auto_increment,
NombreDest varchar(40),
TAprox time,
CONSTRAINT PK_CodDest PRIMARY KEY (CodDest)
)Engine=InnoDB;

create table PrecioDes(
CodPreDes int auto_increment,
CodDest int,
CodTipoMicro int,
Precio int,
CONSTRAINT PK_PrecioDes PRIMARY KEY (CodPreDes),
CONSTRAINT FK_Precio_Destino FOREIGN KEY (CodDest) REFERENCES Destino(CodDest),
CONSTRAINT FK_Precio_TipoMicro FOREIGN KEY (CodTipoMicro) REFERENCES TipoMicro(CodTipoMicro)
)Engine=InnoDB;

create table Horario(
CodHorario int auto_increment,
Hora time,
CONSTRAINT PK_CodHorario PRIMARY KEY (CodHorario)
)Engine=InnoDB;

create table Viaje(
CodViaje int auto_increment,
CodPreDes int,
Fecha date,
CodHorario int,
EstadoV varchar (30), /* Finalizado, En Viaje , En Espera */
CONSTRAINT PK_CodViaje PRIMARY KEY (CodViaje),
CONSTRAINT FK_Viaje_Horario FOREIGN KEY (CodHorario) REFERENCES Horario(CodHorario),
CONSTRAINT FK_Viaje_PrecioDes FOREIGN KEY (CodPreDes) REFERENCES PrecioDes(CodPreDes)
)Engine=InnoDB;

create table Asiento(
CodAsiento int auto_increment, 
CodViaje int,
NroAsiento int,
Estado varchar(20), /*Disponible, Ocupado*/
CONSTRAINT PK_CodAsiento PRIMARY KEY (CodAsiento),
CONSTRAINT FK_Asiento_Viaje FOREIGN KEY (CodViaje) REFERENCES Viaje(CodViaje)
)Engine=InnoDB;

create table Pasaje(
CodPasaje int auto_increment,
CodCliente int,
CodAsiento int,
EstadoP varchar(20), /*Pago, En Espera, Cancelado*/
CONSTRAINT PK_CodPasaje PRIMARY KEY (CodPasaje),
CONSTRAINT FK_Pasaje_Cliente FOREIGN KEY (CodCliente) REFERENCES Cliente(CodCliente),
CONSTRAINT FK_Pasaje_Asiento FOREIGN KEY (CodAsiento) REFERENCES Asiento(CodAsiento)
)Engine=InnoDB;

create table Reserva(
CodReserva int auto_increment,
CodPasaje int,
FReserva date,
HoraReserva time,
EstadoR varchar(20), /*Paga, En Espera, Cancelada*/
CONSTRAINT PK_CodReserva PRIMARY KEY (CodReserva),
CONSTRAINT FK_Reserva_Pasaje FOREIGN KEY (CodPasaje) REFERENCES Pasaje(CodPasaje)
)Engine=InnoDB;

 create table Hotel(
 CodHotel int auto_increment,
 CodDes int,
 Nombre varchar(60),
 Direccion varchar(60),
 CONSTRAINT PK_Hotel PRIMARY KEY (CodHotel),
 CONSTRAINT FK_Hotel_Destino FOREIGN KEY (CodDes) REFERENCES Destino (CodDest)
 )Engine=InnoDB;

create table Paquete(
CodPaquete int auto_increment,
CodHotel int,
Descripcion varchar(100), -- falta
PrecioP int,
CONSTRAINT PK_CodPaquete PRIMARY KEY (CodPaquete),
CONSTRAINT FK_Paquete_Hotel FOREIGN KEY (CodHotel) REFERENCES Hotel (CodHotel)
)Engine=InnoDB;

create table PaqueteViaje(
CodPaquete int,
CodViaje int,
Estado varchar(10), /*Comprado, Libre*/
CONSTRAINT PK_PaqueteViaje PRIMARY KEY(CodPaquete, CodViaje),
CONSTRAINT FK_Paquete FOREIGN KEY(CodPaquete) REFERENCES Paquete (CodPaquete),
CONSTRAINT FK_Viaje FOREIGN KEY(CodViaje) REFERENCES Viaje (CodViaje)
)Engine=InnoDB;

create table Sede(
CodSede int auto_increment,
Direccion varchar(30),
Telefono varchar(12),
CONSTRAINT PK_Sede PRIMARY KEY (CodSede)
)Engine=InnoDB;

create table Empleado(
CodEmp int auto_increment,
CodPersona int,
Tel varchar(12),
Direccion varchar(60),
FechaInicioAct date,
TipoEmpleado varchar(20),
CONSTRAINT PK_Empleado PRIMARY KEY (CodEmp),
CONSTRAINT FK_Emp_Per FOREIGN KEY (CodPersona) REFERENCES Persona (CodPersona)
)Engine=InnoDB;

create table Sueldo(
CodSueldo int,
SueldoBase int,
TipoEmpleado varchar(20),
CONSTRAINT PK_Sueldo PRIMARY KEY (CodSueldo)
)Engine=InnoDB;

create table SueldoEmpleado(
CodSueldoE int auto_increment,
CodEmp int,
Mes varchar(15),
Año int, 
Valor int,
CONSTRAINT PK_SueldoE PRIMARY KEY (CodSueldoE),
CONSTRAINT FK_Sueldo_Emp FOREIGN KEY (CodEmp) REFERENCES Empleado (CodEmp)
)Engine=InnoDB;
 
create table Administracion(
CodAdministrador int,
CodEmp int,
CodUsuario int,
CONSTRAINT PK_Administracion PRIMARY KEY(CodAdministrador),
CONSTRAINT FK_Admin_Empleado FOREIGN KEY(CodEmp) REFERENCES Empleado(CodEmp),
CONSTRAINT FK_Admin_Usuario FOREIGN KEY(CodUsuario) REFERENCES Usuario(CodUsuario)
)Engine=InnoDB;
 
create table Vendedor(
CodVend int auto_increment,
CodEmp int,
CodSede int,
CodUsuario int,
CONSTRAINT PK_Vendedor PRIMARY KEY (CodVend),
CONSTRAINT FK_Vend_Emp FOREIGN KEY (CodEmp) REFERENCES Empleado (CodEmp),
CONSTRAINT FK_Vend_Sede FOREIGN KEY (CodSede) REFERENCES Sede (CodSede),
CONSTRAINT FK_Ven_Usuario FOREIGN KEY (CodUsuario) REFERENCES Usuario (CodUsuario)
)Engine=InnoDB;
 
create table Chofer(
CodChofer int auto_increment, 
CodEmp int,
Estado varchar (20), /*Disponible, Descanso, Licencia, En Viaje*/
CONSTRAINT PK_Chofer PRIMARY KEY (CodChofer),
CONSTRAINT FK_Chofer_Emp FOREIGN KEY (CodEmp) REFERENCES Empleado (CodEmp)
)Engine=InnoDB;
 
create table ChoferViaje(
CodChoferViaje int auto_increment, 
CodChofer int,
CodViaje int,
Chofer1 boolean,
CONSTRAINT PK_ChoferViaje PRIMARY KEY (CodChoferViaje),
CONSTRAINT FK_ChoferViaje_Chofer FOREIGN KEY (CodChofer) REFERENCES Chofer (CodChofer),
CONSTRAINT FK_Chofer_Viaje FOREIGN KEY (CodViaje) REFERENCES Viaje (CodViaje)
)Engine=InnoDB;
 
create table Licencia(
CodLicen int auto_increment,
CodChofer int,
FInicio date,
FFin date,
Descripcion varchar(100),
Estado varchar(10), /*Rechazada, Aprobada, En espera*/
CONSTRAINT PK_Licencia PRIMARY KEY (CodLicen),
CONSTRAINT FK_Licen_Chofer FOREIGN KEY (CodChofer) REFERENCES Chofer (CodChofer)
)Engine=InnoDB;
 
create table Venta(
CodVen int auto_increment,
CodVend int,
Fecha date,
Hora time,
ValorVenta int,
ValorRecibido int,
TipoVenta varchar(25), /*Reserva, Pasaje, Paquete*/
CONSTRAINT PK_Venta PRIMARY KEY (CodVen), 
CONSTRAINT FK_Venta_Vend FOREIGN KEY (CodVend) REFERENCES Vendedor (CodVend)
)Engine=InnoDB;
 
create table VentaReserva(
CodVen int,
CodReserva int,
CONSTRAINT PK_VenReserva PRIMARY KEY (CodVen, CodReserva),
CONSTRAINT PK_VenR FOREIGN KEY (CodVen) REFERENCES Venta (CodVen),
CONSTRAINT PK_Reserva FOREIGN KEY (CodReserva) REFERENCES Reserva (CodReserva)
)Engine=InnoDB;

create table VentaPasaje(
CodVen int,
CodPasaje int,
CONSTRAINT PK_VenPasaje PRIMARY KEY (CodVen, CodPasaje),
CONSTRAINT PK_VenP FOREIGN KEY (CodVen) REFERENCES Venta (CodVen),
CONSTRAINT PK_Pasaje FOREIGN KEY (CodPasaje) REFERENCES Pasaje (CodPasaje)
)Engine=InnoDB;
    
create table VentaPaquete(
CodVen int,
CodPaquete int,
CodCliente int,
CONSTRAINT PK_VenPaquete PRIMARY KEY (CodVen, CodPaquete),
CONSTRAINT PK_VenPaq FOREIGN KEY (CodVen) REFERENCES Venta (CodVen),
CONSTRAINT PK_Paquete FOREIGN KEY (CodPaquete) REFERENCES PaqueteViaje (CodPaquete),
CONSTRAINT FK_Ven_Cliente FOREIGN KEY (CodCliente) REFERENCES Cliente (CodCliente)
)Engine=InnoDB;

create table CierreCaja(
CodCierreCaja int auto_increment,
CodSede int,
Fecha date,
CantidadInicial int,
CantidadFinal int,
CONSTRAINT PK_CierreCaja PRIMARY KEY (CodCierreCaja),
CONSTRAINT FK_Cierre_Sede FOREIGN KEY (CodSede) REFERENCES Sede (CodSede)
)Engine=InnoDB;

create table Micro(
CodMicro int auto_increment,
CodTipoMicro int,
Patente varchar (10),
Marca varchar(20),
Modelo varchar(30),
Anio int,
Estado varchar(30), /*Disponible, Dado de Baja, En Reparacion*/
CONSTRAINT PK_Micro PRIMARY KEY (CodMicro),
CONSTRAINT FK_Micro_TipoMicro FOREIGN KEY (CodTipoMicro) REFERENCES TipoMicro (CodTipoMicro)
)Engine=InnoDB;

create table MicroViaje(
CodMicro int, 
CodViaje int, 
CONSTRAINT PK_MicroViaje PRIMARY KEY (CodMicro, CodViaje),
CONSTRAINT PK_Micro FOREIGN KEY (CodMicro) REFERENCES Micro (CodMicro), 
CONSTRAINT PK_Viaje FOREIGN KEY (CodViaje) REFERENCES Viaje (CodViaje)
)Engine=InnoDB;

create table Zona(
CodZona int auto_increment,
Nombre varchar(40),
Provincia varchar(40),
CONSTRAINT PK_Zona PRIMARY KEY (CodZona)
)Engine=InnoDB;

create table Taller (
CodTaller int auto_increment,
CodZona int, 
Direccion varchar(30), /*Ruta y Kilometro o Calle*/
CONSTRAINT PK_Taller PRIMARY KEY (CodTaller),
CONSTRAINT PK_Zona FOREIGN KEY (CodZona) REFERENCES Zona (CodZona)
)Engine=InnoDB;

create table Reparacion(
CodReparacion int auto_increment,
CodMicro int,
CodTaller int,
Descripcion varchar(100),
CONSTRAINT PK_Reparacion PRIMARY KEY (CodReparacion),
CONSTRAINT FK_Reparacion_Micro FOREIGN KEY (CodMicro) REFERENCES Micro (CodMicro),
CONSTRAINT FK_Reparacion_CodTaller FOREIGN KEY (CodTaller) REFERENCES Taller (CodTaller)
)Engine=InnoDB;

create table CambioMicro(
CodCambioMicro int auto_increment,
CodViaje int,
CodMicroNuevo int,
Hora time,
Descripcion varchar(100),
CONSTRAINT PK_CodCambioMicro PRIMARY KEY (CodCambioMicro), 
CONSTRAINT FK_CambioM_Viaje FOREIGN KEY (CodViaje) REFERENCES Viaje (CodViaje),
CONSTRAINT FK_CambioM_MicroNuevo FOREIGN KEY (CodMicroNuevo) REFERENCES Micro (CodMicro)
)Engine=InnoDB;
 
create table Nota(
NroNota int,
CodCierreCaja int,
CodVend int,
Cantidad int,
Descripcion varchar(100),
tiponota varchar(20),
CONSTRAINT pk_Nota PRIMARY KEY (NroNota),
CONSTRAINT FK_CierreCaja_Nota FOREIGN KEY(CodCierreCaja) REFERENCES CierreCaja(CodCierreCaja),
CONSTRAINT FK_Vendedor_Nota FOREIGN KEY(CodVend) REFERENCES Vendedor(CodVend)
)Engine=InnoDB;
