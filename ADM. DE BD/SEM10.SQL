-- TEMA: PROCEDIMIENTO ALMACENADO

-- CREAMOS LA TABLA 
create table categorias (
   id_categoria     number primary key,
   nombre_categoria varchar2(100),
   desc_categoria   varchar2(500)
)

-- CREAMOS UN PROCEDIMIENTO ALMACENADO PARA INSERTAR
create or replace procedure proc_insertar_categorias (
   p_id_categoria     in number,
   p_nombre_categoria in varchar2,
   p_desc_categoria   in varchar2
   ) is
begin
   insert into categorias (id_categoria,nombre_categoria,desc_categoria) 
   values (p_id_categoria,p_nombre_categoria,p_desc_categoria);
   commit;
end;

EXECUTE  proc_insertar_categorias(1,'Reposteros','Reportero de 4x4, color marrón');   
