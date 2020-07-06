create table actas
(
    id           int auto_increment
        primary key,
    proyecto_id  int          not null comment 'Id del proyecto relacionado',
    version      int          null comment 'identificación de la version del acta',
    titulo       varchar(300) not null comment 'Titulo del acta',
    objetivo     text         not null comment 'Objetivo de la reunión',
    ciudad_id    int          not null comment 'Id de la ciudad donde se lleva a cabo la reunión',
    usuario_id   int          not null comment 'Id del usuario quien creo el acta, solo este usuario puede modificarla',
    fecha_hora   datetime     not null comment 'Fecha y hora de inicio de la reunión, se guarda directo en la sentencia SQL, no lo envia el front',
    tipo_acta_id int          not null comment 'Relacion con la tabla tipos actas',
    estado       int          not null comment 'Estado de la reunión, 1=pendiente, 2=en proceso, 3=finalizada'
)
    comment 'Tabla para almacenar las actas' collate = latin1_spanish_ci;

create table compromisos
(
    id              int auto_increment comment 'Id del compromiso'
        primary key,
    descripcion     text                 not null comment 'Descripción del compromiso',
    fecha           date                 not null comment 'Fecha limite para cumplir el compromiso',
    participante_id int                  not null comment 'Id del participante responsable del compromiso',
    fecha_hora      datetime             not null comment 'Fecha y hora de registro del compromiso, se coloca directo en la sentencia SQL Insert',
    tema_id         int                  not null comment 'Id del tema relacionado',
    activo          tinyint(1) default 1 null comment '1=registro activo; 0=registro eliminado'
)
    comment 'Compromisos de los temas de las actas' collate = latin1_spanish_ci;

create table conclusiones
(
    id          int        not null comment 'Id de la conclusion',
    descripcion text       not null,
    fecha_hora  datetime   not null comment 'Fecha y hora de registro de la conclusion',
    acta_id     int        not null comment 'Id del acta relacionada',
    activo      tinyint(1) not null comment '1=registro activo, 0=registro eliminado'
)
    comment 'Registro de las conclusiones de las actas' collate = latin1_spanish_ci;

create table participantes
(
    id                     int auto_increment comment 'Id del participante'
        primary key,
    acta_id                int                  not null comment 'Id de acuerdo a la tabla actas',
    interno                tinyint(1) default 1 not null comment '1=interno, 0=externo; si es interno usa la columna usuario_id, en caso contario registra los datos del participante',
    nombre                 varchar(100)         null comment 'Nombre del particiopante externo',
    tipo_identificacion_id int                  null comment 'Id del tipo de identificacion del participante, relacion con la tabla tipos_identificacion',
    numero_documento       varchar(100)         null comment 'Numero del documento del participante externo',
    email                  varchar(100)         null comment 'Email del participante externo',
    entidad                varchar(100)         null comment 'Entidad que representa el participante externo',
    cargo                  varchar(100)         null comment 'Cargo del participante externo',
    activo                 tinyint(1) default 1 not null comment '1=registro activo, 0=registro eliminado',
    usuario_id             int                  null comment 'id del usuario para un participante interno'
)
    collate = latin1_spanish_ci;

create table proyectos
(
    id                     int auto_increment comment 'Id autonumerico del proyecto'
        primary key,
    nombre                 varchar(300)                         not null comment 'Nombre del proyecto',
    cod_proyecto           varchar(100)                         not null comment 'Código del proyecto',
    no_contrato            varchar(100)                         not null comment 'Número del contrato',
    fecha_inicio           date                                 null comment 'Fecha de inicio del contrato',
    fecha_fin              date                                 not null comment 'Fecha fin del contrato',
    acta_inicio            varchar(100)                         not null comment 'Acta de incio del contrato',
    google_groups          varchar(200)                         null comment 'Enlace a google groups',
    tipo_contrato_id       int                                  not null comment 'Id del tipo de contrato',
    ciudad_id              int                                  not null comment 'Id del municipio seleccionado',
    direccion              varchar(200)                         null comment 'Dirección del contrato',
    telefono               varchar(100)                         null comment 'Telefono para el contrato',
    web                    varchar(100)                         null comment 'Página web del contrato',
    email                  varchar(100)                         null comment 'Email del contrato',
    objeto                 varchar(400)                         null comment 'Objeto del contrato',
    director               varchar(100)                         null comment 'Nombre del director de proyecto',
    tipo_doc_director      tinyint                              null comment '1=CC 2=NIT',
    cedula_director        varchar(100)                         null comment 'Cedula del director',
    email_director         varchar(100)                         null comment 'Email de director de proyecto',
    telefono_director      varchar(100)                         null comment 'Telefono del director de proyecto',
    representante          varchar(100)                         null comment 'Representante legal del proyecto',
    tipo_doc_representante tinyint                              null comment '1=CC 2=NIT',
    cedula_representante   varchar(100)                         null comment 'CC representante legal de proyecto',
    email_representante    varchar(100)                         null comment 'Email de representante del proyecto',
    telefono_representante varchar(100)                         null comment 'Telefono de representante legal',
    contratante            varchar(200)                         null comment 'Nombre del contratante',
    supervisor             varchar(200)                         null comment 'Nombre del supervisor',
    tipo_doc_supervisor    tinyint                              null comment '1=CC  2=NIT',
    cedula_supervisor      varchar(100)                         null comment 'Cedula del supervisor del contrato',
    email_supervisor       varchar(100)                         null comment 'Email supervisor de contrato',
    telefono_supervisor    varchar(100)                         null comment 'Telefono del supervisor de contrato',
    usuario_id             int                                  not null comment 'Id del usuario que creo el proyecto',
    fecha_registro         datetime default current_timestamp() not null comment 'Fecha de registro del proyecto',
    tecnico_operativa      tinyint  default 0                   null comment 'Indica si es tecnico operativa 0=no 1=si',
    financiera             tinyint  default 0                   null comment 'Indica si es financiera 0=no 1=si',
    juridica               tinyint  default 0                   null comment 'Indica si es juridica 0=no 1=si',
    administrativa         tinyint  default 0                   null comment 'Indica si es administrativa 0=no 1=si',
    estado                 tinyint  default 1                   not null comment 'Indica el estado del contrato 1=creado 2= iniciado 3=en ejecucion 4=finalizado 0=anulado',
    logo_archivo_id        int                                  null comment 'id del archivo del logo de acuerdo a la tabla archivos',
    logo_cont_archivo_id   int                                  null comment 'id del archivo  logo del contratante'
)
    collate = latin1_spanish_ci;

INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Proyecto 1', '4545', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'Calle 10', '12121212', 'www.web', 'email@12.com', 'Objeto del contrato 1212', 'Juan Jose Juarez', null, '12121212', 'director@email.com', '12121212', 'Luis Lopez', null, '13131313', 'representante@email.com', '13131313', 'Pedro Perez', 'Armando Alvarez', null, '14141414', 'supervisor@email.com', '14141414', 1, '2020-04-24 15:02:45', 0, 0, 0, 0, 3, null, 194);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto PRUEBA EDITAR', '4545', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1ASAS212', 'juan jose juarez', null, '12121212', 'director@email.Com', '12121212', 'luis lopez', null, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', null, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-04-24 20:33:44', 0, 0, 0, 0, 3, null, 193);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto uno uriel', '4545', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', null, '12121212', 'director@email.Com', '12121212', 'luis lopez', null, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', null, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-04-24 20:36:58', 0, 0, 0, 0, 3, null, 195);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 1', '4546', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', null, '12121212', 'director@email.Com', '12121212', 'luis lopez', null, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', null, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-04-24 20:39:06', 0, 0, 0, 0, 4, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 2', '4547', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, '2020-04-24 22:31:58', null, null, null, null, 3, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 2', '4548', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, '2020-04-25 16:35:46', null, null, null, null, 2, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 2', '4549', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, '2020-04-25 16:38:03', null, null, null, null, 4, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Nombre Proyecto Prueba Carlos Editado', '12345', '85963', '2020-04-01', '2020-04-30', 'Acta inicio prueba', 'ggprueba.com', 2, 295, 'Dirección prueba #1-01', '3128956541', 'pwprueba.com', 'prueba@prueba.co', 'Objeto del contrato prueba EDITADO', 'Director Prueba', 1, '91258474', 'director@prueba.com', '3156545859', 'Representante Prueba', 2, '1098725863', 'representante@prueba.com', '3125462301', 'Contratante Prueba Editado', 'Supervisor Prueba', 2, '10956325876', 'supervisor@prueba.com', '3132458989', 3, '2020-04-25 16:42:11', 0, 1, 0, 1, 3, 96, 182);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Proyecto  Prueba 1', '123451', '2131', '2020-04-10', '2020-04-20', '213REF', 'prueba.com', 2, 561, 'Dirección Prueba #548', '6547890', 'prueba.com', 'prueba@email.com', 'Objeto prueba', 'Director prueba', null, '10954682135', 'prueba@prueba.com', '3214567888', 'Representante prueba', null, '10985421855', 'prueba@prueba.com', '3112345679', null, null, null, null, null, null, 3, '2020-04-25 17:10:56', 1, 0, 0, 0, 1, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 2', '4560', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, '2020-04-25 17:44:07', null, null, null, null, 3, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 11', '4550', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', 1, '12121212', 'director@email.Com', '12121212', 'luis lopez', 2, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', null, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-04-24 15:02:45', 0, 0, 0, 0, 2, 68, 63);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Proyecto 3', '52312', '12312', '2020-05-01', '2020-06-01', 'WED2EW', 'prueba3', 3, 80, 'prueba 3 direccion', null, null, 'prueba3@gmail.com', 'Prueba 3 objeto', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 3, '2020-05-07 21:43:48', 1, 0, 0, 1, 1, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Prueba 4', '912592', '6812', '2020-05-11', '2020-06-11', 'DWA457', 'Prueba 4 google', 2, 229, 'Prueba 4 dirección', null, null, 'prueba4@email.com', 'Prueba 4 objeto', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 3, '2020-05-07 21:49:35', 0, 1, 0, 0, 1, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Prueba 5', '6125', '5824', '2020-05-08', '2020-07-16', 'DAW256', 'Prueba 4 google', 2, 356, 'Prueba 4 dirección', '618845', null, 'prueba4@email.co', 'Prueba 4 objeto', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 3, '2020-05-07 21:52:11', 0, 0, 1, 0, 3, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Prueba 5', '294646', '48489', '2020-05-04', '2020-06-04', 'DBD56', 'Prueba 5 google', 1, 178, 'Prueba 5 direccion', '6152488', 'www.prueba5.com', 'prueba5@email.co', 'Prueba 5 objeto', 'Director 5', null, null, 'dir5@email.com', null, 'Representante 5', null, null, 'rep5@email', null, null, null, null, null, null, null, 3, '2020-05-07 22:16:09', 0, 0, 0, 1, 3, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 1 editado con logo', '4585', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', 1, '12121212', 'director@email.Com', '12121212', 'luis lopez', 1, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', 1, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-04-24 15:02:45', 0, 0, 0, 0, 1, 50, 51);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Prueba logo', '2321', '231312', '2020-05-20', '2020-05-21', 'EDDW', 'www.google.com', 1, 454, 'prueba', null, null, 'prueba.imagen@email.com', 'prueba.imagen@email.com', null, null, null, null, null, null, null, null, null, null, 'Prueba logo', 'Prueba logo', null, null, 'prueba.logo@email.co', null, 3, '2020-05-20 19:40:21', 1, 0, 0, 0, 1, 61, 62);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Pruebas imagen', '3123', '1323', '2020-05-22', '2020-05-23', 'dwa', 'www.prueba.com', 1, 214, 'asd', null, null, 'ca@ca.co', 'ddd', null, null, null, null, null, null, null, null, null, null, 'ss', 'dd', null, null, 'ca@ca.coo', null, 3, '2020-05-23 14:51:05', 1, 0, 0, 0, 1, 71, 72);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Proyecto de prueba Jaime', '1', '122333', '2020-06-03', '2020-09-30', '2663553', 'ggsttag', 1, 362, 'De prueba dirección', '7366366', 'www.systemico.co', 'ja@gmail.com', 'Es un texto de prueba', 'Director de proyecto Jaga', 1, '889998', 'jh@gmail.com', '73664776', 'Representante Jaga', 1, '88999888', 'ju@gmail.com', '883773847', 'Contrante de prueba', 'Supervisor Jaga', 1, '88399388', 'ju@gmail.com', '8837738', 3, '2020-06-04 20:47:16', 1, 1, 1, 1, 1, 87, 89);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('Prueba consecutivo', '2133', '2312313', '2020-06-08', '2020-06-10', 'DAW123', 'www.prueba.com', 1, 129, 'Direccion prueba', null, null, 'prueba@email.com', 'Objeto prueba', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 3, '2020-06-06 13:20:42', 1, 0, 0, 0, 1, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 1', '8548', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', 1, '12121212', 'director@email.Com', '12121212', 'luis lopez', 1, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', 1, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-06-13 16:10:24', 0, 0, 0, 0, 1, null, null);
INSERT INTO proyectos (nombre, cod_proyecto, no_contrato, fecha_inicio, fecha_fin, acta_inicio, google_groups, tipo_contrato_id, ciudad_id, direccion, telefono, web, email, objeto, director, tipo_doc_director, cedula_director, email_director, telefono_director, representante, tipo_doc_representante, cedula_representante, email_representante, telefono_representante, contratante, supervisor, tipo_doc_supervisor, cedula_supervisor, email_supervisor, telefono_supervisor, usuario_id, fecha_registro, tecnico_operativa, financiera, juridica, administrativa, estado, logo_archivo_id, logo_cont_archivo_id) VALUES ('proyecto 1', '8648', '1212', '2020-04-24', '2020-05-30', '1313', 'que es esto?', 1, 362, 'calle 10', '12121212', 'www.Web', 'email@12.Com', 'objeto del contrato 1212', 'juan jose juarez', 1, '12121212', 'director@email.Com', '12121212', 'luis lopez', 1, '13131313', 'representante@email.Com', '13131313', 'pedro perez', 'armando alvarez', 1, '14141414', 'supervisor@email.Com', '14141414', 1, '2020-06-13 16:11:28', 0, 0, 0, 0, 1, null, null);

create table temas
(
    id          int auto_increment comment 'Id del tema'
        primary key,
    descripcion text                 not null comment 'Descripción del tema',
    fecha_hora  datetime             not null comment 'Fecha y hora de creacion del tema, no la envia el front se inserta en el insert',
    acta_id     int                  not null comment 'id del acta relacionada',
    activo      tinyint(1) default 1 not null comment '1=registro activo; 0=registro eliminado'
)
    comment 'Temas de la reunion y el acta' collate = latin1_spanish_ci;

create table tipos_actas
(
    id     int auto_increment comment 'Tipos de actas, interno o externo'
        primary key,
    nombre varchar(100) not null comment 'Nombre del tipo de acta'
)
    comment 'Tipos de actas' collate = latin1_spanish_ci;

INSERT INTO tipos_actas (id, nombre) VALUES (1, 'Acta de seguimiento interno');
INSERT INTO tipos_actas (id, nombre) VALUES (2, 'Acta de seguimiento de proyecto');

create table usuario
(
    id                bigint auto_increment comment 'Id del Usuario'
        primary key,
    cuenta_id         int                                  null,
    nombre_completo   varchar(200)                         not null comment 'Nombre completo del Usuario (Nombre y Apellidos)',
    tipo_documento    int                                  null comment 'tipo de identificación',
    num_documento     varchar(45)                          null comment 'Número de documento de identidad',
    ciudad_id         int                                  null comment 'Id de la Ciudad',
    direccion         varchar(200)                         null comment 'Dirección del Usuario',
    telefono          varchar(15)                          null comment 'Teléfono del Usuario',
    correo_personal   varchar(50)                          null,
    correo_empresa    varchar(50)                          null,
    tipo_actividad_id int                                  null,
    area_gestion_id   int                                  null,
    perfil_archivo_id int                                  null comment 'id del archivo de la imagen de perfil de acuerdo a tabla archivos',
    firma_archivo_id  int                                  null comment 'id del archivo de la firma de acuerdo a tabla archivos',
    estado            int      default 1                   not null comment 'Estado del usuario, estos son:
1. Activo, 0 Eliminado',
    fecha_creado      datetime default current_timestamp() not null comment 'Fecha en que se creo el registro'
)
    comment 'Tabla que contiene los registros de usuarios.' charset = utf8;

INSERT INTO usuario (cuenta_id, nombre_completo, tipo_documento, num_documento, ciudad_id, direccion, telefono, correo_personal, correo_empresa, tipo_actividad_id, area_gestion_id, perfil_archivo_id, firma_archivo_id, estado, fecha_creado) VALUES (3, 'Carlos Rueda', 1, null, null, null, null, null, null, null, null, null, null, 1, '2020-04-11 16:53:35');