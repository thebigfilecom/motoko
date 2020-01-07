open Source
open Mo_types

type t
val empty : t
val string_of_index : t -> string

type value_decl = {
    name : string;
    typ: Type.typ;
    definition: region option;
  }

type type_decl = {
    name : string;
    typ: Type.con;
    definition: region option;
  }

type ide_decl =
  | ValueDecl of value_decl
  | TypeDecl of type_decl

val string_of_ide_decl : ide_decl -> string
val name_of_ide_decl : ide_decl -> string

type path = string
val lookup_module : path -> t -> ide_decl list option

val make_index : Vfs.t -> string list -> t Diag.result