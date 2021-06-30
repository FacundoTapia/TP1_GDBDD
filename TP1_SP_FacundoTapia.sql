/*
	Trabajo 1
    
    Crear los siguientes store procedures para la base negocioWebRopa
    
    _ Tabla clientes
		SP_Clientes_Insert_Min
        SP_Clientes_Insert_Full
        SP_Clientes_Update
        SP_Clientes_Delete
        SP_Clientes_All
    
    - Tabla articulos
		SP_Articulos_Insert_Min
        SP_Articulos_Insert_Full
        SP_Articulos_Delete
        SP_Articulos_Update
        SP_Articulos_All
        SP_Articulos_Reponer  listar articulos que tienen stock menor al stock min
        
	- Tabla facturas
		SP_Facturas_Insert  todos son not null (alter table)
        SP_Facturas_Delete
        SP_Facturas_Update
		SP_Facturas_All
		SP_Facturas_AgregarDetalle  inserta en tabla detalle con idFactura y idArticulo
        
	- Tabla detalles
		SP_Detalles_Delete
		SP_Detalles_All
*/

use negocioWebRopa;

call SP_Procedures;

-- TABLA CLIENTES

drop procedure if exists SP_Clientes_Insert_Min;

delimiter //
create procedure SP_Clientes_Insert_Min (in Pnombre varchar(20), Papellido varchar(20))
begin
	insert into clientes (nombre,apellido) values (Pnombre,Papellido);
end
// delimiter ;

drop procedure if exists SP_Clientes_Insert_Full;

delimiter //
create procedure SP_Clientes_Insert_Full (in Pnombre varchar(20), Papellido varchar(20),
		Pfenaci date, Pdireccion varchar(50), Pemail varchar(30), 
        Ptelefono  varchar(25), PtipoDocumento varchar(20), PnumeroDocumento char(8))
begin
	insert into clientes 
		(nombre,apellido,fenaci,direccion,email,telefono,tipoDocumento,numeroDocumento) 
        values 
        (Pnombre,Papellido,Pfenaci,Pdireccion,Pemail,Ptelefono,PtipoDocumento,PnumeroDocumento);
end
// delimiter ;

drop procedure if exists SP_Clientes_Delete;

delimiter //
create procedure SP_Clientes_Delete (in Pid int)
begin
	delete from clientes where id=Pid;
end
// delimiter ;

drop procedure if exists SP_Clientes_Update;

delimiter //
create procedure SP_Clientes_Update (in Pid int, Pnombre varchar(20), Papellido varchar(20),
		Pfenaci date, Pdireccion varchar(50), Pemail varchar(30), 
        Ptelefono  varchar(25), PtipoDocumento varchar(20), PnumeroDocumento char(8))
begin
	update clientes set nombre=Pnombre, apellido=Papellido, fenaci=Pfenaci, direccion=Pdireccion,
					email=Pemail, telefono=Ptelefono, tipoDocumento=PtipoDocumento,
					numeroDocumento=PnumeroDocumento where id=Pid;
end
// delimiter ;

drop procedure if exists SP_Clientes_All;

delimiter //
create procedure SP_Clientes_All ()
begin
	select id idCliente ,concat(apellido,' ',nombre) nombre, fenaci fecha_nacimiento, 
    TIMESTAMPDIFF(YEAR,fenaci,CURDATE()) edad, direccion, email, telefono,
    tipoDocumento, numeroDocumento from clientes;
end
// delimiter ;

-- TABLA ARTICULOS

describe articulos;

drop procedure if exists SP_Articulos_Insert_Min;

delimiter //

create procedure SP_Articulos_Insert_Min(in Pdescripcion varchar(25), Ptipo varchar(7), Pcolor varchar(20), Ptalle_num varchar(20))
begin
	insert into articulos(descripcion, tipo, color, talle_num) values(Pdescripcion, Ptipo, Pcolor, Ptalle_num);
end

// delimiter ;

drop procedure if exists SP_Articulos_Insert_Full;

delimiter //

create procedure SP_Articulos_Insert_Full(in Pdescripcion varchar(25), Ptipo varchar(7), Pcolor varchar(20), Ptalle_num varchar(20), Pstock int, 
											PstockMin int, PstockMax int, Pcosto double, Pprecio double, Ptemporada varchar(9))
begin
	insert into articulos(descripcion, tipo, color, talle_num, stock, stockMin, stockMax, costo, precio, temporada) 
		values(Pdescripcion, Ptipo, Pcolor, Ptalle_num, Pstock, PstockMin, PstockMax, Pcosto, Pprecio, Ptemporada);
end

// delimiter ;

drop procedure if exists SP_Articulos_Update;

delimiter //

create procedure SP_Articulos_Update(in Pid int, Pdescripcion varchar(25), Ptipo varchar(7), Pcolor varchar(20), Ptalle_num varchar(20), Pstock int, 
											PstockMin int, PstockMax int, Pcosto double, Pprecio double, Ptemporada varchar(9))
begin
	update articulos set descripcion = Pdescripcion, tipo = Ptipo, color = Pcolor, talle_num = Ptalle_num, stock = Pstock, stockMin = PstockMin, 
			stockMax = PstockMax, costo = Pcosto, precio = Pprecio, temporada = Ptemporada where id = Pid;
end

// delimiter ;

drop procedure if exists SP_Articulos_Delete;

delimiter //

create procedure SP_Articulos_Delete(in Pid int)
begin
	delete from articulos where id = Pid;
end

// delimiter ;

drop procedure if exists SP_Articulos_All;

delimiter //

create procedure SP_Articulos_All()
begin
	select * from articulos;
end

// delimiter ;

drop procedure if exists SP_Articulos_Reponer;

delimiter //

create procedure SP_Articulos_Reponer()
begin
	select * from articulos where stock < stockMin;
end

// delimiter ;

/*
call SP_Articulos_Insert_Min('BUZO','ROPA','AZUL','XXL');
call SP_Articulos_Insert_Min('CAMPERA','ROPA','NEGRO','XL');
call SP_Articulos_Insert_Full('BUZO','ROPA','ROJO','XL', 40, 20, 60, 600, 1800, 'INVIERNO');
call SP_Articulos_Insert_Full('BUZO','ROPA','NEGRO','L', 15, 20, 50, 400, 1500, 'INVIERNO');
call SP_Articulos_Update(6, 'BUZO','ROPA','TRICOLOR','XXL', 10, 20, 60, 850, 2200, 'INVIERNO');
call SP_Articulos_Delete(7);
call SP_Articulos_All();
call SP_Articulos_Reponer();
*/


-- TABLA FACTURAS

describe facturas;

drop procedure if exists SP_Facturas_Insert;

delimiter //

create procedure SP_Facturas_Insert(in Pletra varchar(1), Pnumero int, Pfecha date, PmedioDePago varchar(9), PidCliente int)
begin
	insert into facturas(letra, numero, fecha, medioDePago, idCliente) values(Pletra, Pnumero, Pfecha, PmedioDePago, PidCliente);
end

// delimiter ;

drop procedure if exists SP_Facturas_Update;

delimiter //

create procedure SP_Facturas_Update(in Pid int, Pletra varchar(1), Pnumero int, Pfecha date, PmedioDePago varchar(9), PidCliente int)
begin
	update facturas set letra = Pletra, numero = Pnumero, fecha = Pfecha, medioDePago = PmedioDePago, idCliente = PidCliente 
		where id = Pid;
end

// delimiter ;

drop procedure if exists SP_Facturas_Delete;

delimiter //

create procedure SP_Facturas_Delete(in Pid int)
begin
	delete from facturas where id = Pid;
end

// delimiter ;

drop procedure if exists SP_Facturas_All;

delimiter //

create procedure SP_Facturas_All()
begin
	select * from facturas;
end

// delimiter ;

drop procedure if exists SP_Facturas_AgregarDetalle;

delimiter //

create procedure SP_Facturas_AgregarDetalle(in PidArticulo int, PidFactura int, Pprecio int, Pcantidad int)
begin
	insert into detalles(idArticulo, idFactura, precio, cantidad) values(PidArticulo, PidFactura, Pprecio, Pcantidad);
end

// delimiter ;

/*
call SP_Facturas_Insert('A',30, curdate(), 'EFECTIVO', 6);
call SP_Facturas_Update(13, 'B', 11, curdate(), 'DEBITO', 6);
call SP_Facturas_Delete(13);
call SP_Facturas_All();
call SP_Facturas_AgregarDetalle(6, 7, 850, 2);
*/


-- TABLA DETALLES

drop procedure if exists SP_Detalles_Delete;

delimiter //

create procedure SP_Detalles_Delete(in Pid int)
begin
	delete from detalles where id = Pid;
end

// delimiter ;

drop procedure if exists SP_Detalles_All;

delimiter //

create procedure SP_Detalles_All()
begin
	select *, (precio*cantidad) monto from detalles;
end

// delimiter ;
/*
call SP_Detalles_All();
call SP_Detalles_Delete(1);
*/

call SP_Procedures();