{
open Parser
open Source
module Script = Wasm.Script
module Utf8 = Wasm.Utf8

exception Syntax of Source.region * string

let token_to_string tok =
    match tok with
    | XOROP -> "XOROP"
    | WORD _ -> "WORD"
    | WHILE -> "WHILE"
    | VAR -> "VAR"
    | UNDERSCORE -> "UNDERSCORE"
    | TYPE -> "TYPE"
    | THEN -> "THEN"
    | TEXT _ -> "TEXT()"
    | SWITCH -> "SWITCH"
    | SUBOP -> "SUBOP"
    | STRING _ -> "STRING"
    | SHIFTROP  -> "SHIFTROP"
    | SHIFTLOP -> "SHIFTLOP"
    | SEMICOLON -> "SEMICOLON"
    | RPAR -> "RPAR"
    | ROTROP -> "ROTROP"
    | ROTLOP -> "ROTLOP"
    | RETURN -> "RETURN"
    | RCURLY -> "RCURLY"
    | RBRACKET -> "RBRACKET"
    | PRIVATE -> "PRIVATE"
    | OROP -> "OROP"
    | OR -> "OR"
    | OBJECT -> "OBJECT"
    | NULL -> "NULL"
    | NOTOP -> "NOTOP"
    | NOT -> "NOT"
    | NAT n ->  Printf.sprintf "NAT(%i)" n
    | MUT -> "MUL"
    | MULOP -> "MULOP"
    | MODOP -> "MODOP"
    | LT -> "LT"
    | LPAR -> "LPAR"
    | LOOP -> "LOOP"
    | LIKE -> "LIKE"
    | LET -> "LET"
    | LCURLY -> "LCURLY"
    | LBRACKET -> "LBRACKET"
    | LABEL -> "LABEL"
    | IS -> "IS"
    | INT i ->  Printf.sprintf "ID(%i)" i
    | IN -> "IN"
    | IF -> "IF"
    | ID id -> Printf.sprintf "ID(%s)" id
    | GT -> "GT"
    | FUNC -> "FUNC"
    | FOR -> "FOR"
    | FLOAT _ -> "FLOAT"
    | EQ -> "EQ"
    | EOF -> "EOF"
    | ELSE -> "ELSE"
    | DOT -> "DOT"
    | DIVOP -> "DIVOP"
    | CONTINUE -> "CONTINUE"
    | COMMA -> "COMMA"
    | COLON -> "COLON"
    | CLASS -> "CLASS"
    | CHAR _ -> "CHAR"
    | CATOP -> "CATOP"
    | CASE -> "CASE"
    | BREAK -> "BREAK"
    | BOOL _ -> "BOOL"  
    | AWAIT -> "AWAIT"
    | ASYNC -> "ASYNC"
    | ASSIGN -> "ASSING"
    | ASSERT -> "ASSERT"
    | ARROW -> "ARROW"
    | ANDOP -> "ANDOP"
    | AND -> "AND"
    | ADDOP -> "ADDOP"
    | ACTOR -> "ACTOR"


let convert_pos pos =
  { Source.file = pos.Lexing.pos_fname;
    Source.line = pos.Lexing.pos_lnum;
    Source.column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol
  }

let region lexbuf =
  let left = convert_pos (Lexing.lexeme_start_p lexbuf) in
  let right = convert_pos (Lexing.lexeme_end_p lexbuf) in
  {Source.left = left; Source.right = right}

(* let error lexbuf msg = raise (Script.Syntax (region lexbuf, msg)) *)
let error lexbuf msg = raise (Syntax (region lexbuf, msg))
let error_nest start lexbuf msg =
  lexbuf.Lexing.lex_start_p <- start;
  error lexbuf msg

let string s =
  let b = Buffer.create (String.length s) in
  let i = ref 1 in
  while !i < String.length s - 1 do
    let c = if s.[!i] <> '\\' then s.[!i] else
      match (incr i; s.[!i]) with
      | 'n' -> '\n'
      | 'r' -> '\r'
      | 't' -> '\t'
      | '\\' -> '\\'
      | '\'' -> '\''
      | '\"' -> '\"'
      | 'u' ->
        let j = !i + 2 in
        i := String.index_from s j '}';
        let n = int_of_string ("0x" ^ String.sub s j (!i - j)) in
        let bs = Utf8.encode [n] in
        Buffer.add_substring b bs 0 (String.length bs - 1);
        bs.[String.length bs - 1]
      | h ->
        incr i;
        Char.chr (int_of_string ("0x" ^ String.make 1 h ^ String.make 1 s.[!i]))
    in Buffer.add_char b c;
    incr i
  done;
  Buffer.contents b

(*
let value_type = function
  | "i32" -> Types.I32Type
  | "i64" -> Types.I64Type
  | "f32" -> Types.F32Type
  | "f64" -> Types.F64Type
  | _ -> assert false

let intop t i32 i64 =
  match t with
  | "i32" -> i32
  | "i64" -> i64
  | _ -> assert false

let floatop t f32 f64 =
  match t with
  | "f32" -> f32
  | "f64" -> f64
  | _ -> assert false

let numop t i32 i64 f32 f64 =
  match t with
  | "i32" -> i32
  | "i64" -> i64
  | "f32" -> f32
  | "f64" -> f64
  | _ -> assert false

let memsz sz m8 m16 m32 =
  match sz with
  | "8" -> m8
  | "16" -> m16
  | "32" -> m32
  | _ -> assert false

let ext e s u =
  match e with
  | 's' -> s
  | 'u' -> u
  | _ -> assert false

let opt = Lib.Option.get
*)
}

let sign = '+' | '-'
let digit = ['0'-'9']
let hexdigit = ['0'-'9''a'-'f''A'-'F']
let num = digit ('_'? digit)*
let hexnum = hexdigit ('_'? hexdigit)*

let letter = ['a'-'z''A'-'Z']
let symbol =
  ['+''-''*''/''\\''^''~''=''<''>''!''?''@''#''$''%''&''|'':''`''.''\'']

let space = [' ''\t''\n''\r']
let ascii = ['\x00'-'\x7f']
let ascii_no_nl = ['\x00'-'\x09''\x0b'-'\x7f']
let utf8cont = ['\x80'-'\xbf']
let utf8enc =
    ['\xc2'-'\xdf'] utf8cont
  | ['\xe0'] ['\xa0'-'\xbf'] utf8cont
  | ['\xed'] ['\x80'-'\x9f'] utf8cont
  | ['\xe1'-'\xec''\xee'-'\xef'] utf8cont utf8cont
  | ['\xf0'] ['\x90'-'\xbf'] utf8cont utf8cont
  | ['\xf4'] ['\x80'-'\x8f'] utf8cont utf8cont
  | ['\xf1'-'\xf3'] utf8cont utf8cont utf8cont
let utf8 = ascii | utf8enc
let utf8_no_nl = ascii_no_nl | utf8enc

let escape = ['n''r''t''\\''\'''\"']
let character =
    [^'"''\\''\x00'-'\x1f''\x7f'-'\xff']
  | utf8enc
  | '\\'escape
  | '\\'hexdigit hexdigit 
  | "\\u{" hexnum '}'

let nat = num | "0x" hexnum
let int = sign nat
let frac = num
let hexfrac = hexnum
let float =
    sign? num '.' frac?
  | sign? num ('.' frac?)? ('e' | 'E') sign? num
  | sign? "0x" hexnum '.' hexfrac?
  | sign? "0x" hexnum ('.' hexfrac?)? ('p' | 'P') sign? num
  | sign? "inf"
  | sign? "nan"
  | sign? "nan:" "0x" hexnum
let string = '"' character* '"'
let name =  letter  ((letter | digit | '_')*)
let reserved = ([^'\"''('')'';'] # space)+  (* hack for table size *)

let ixx = "i" ("32" | "64")
let fxx = "f" ("32" | "64")  
let nxx = ixx | fxx
let mixx = "i" ("8" | "16" | "32" | "64")
let mfxx = "f" ("32" | "64")
let sign = "s" | "u"
let mem_size = "8" | "16" | "32"

rule token = parse
  | "(" { LPAR }
  | ")" { RPAR }
  | "[" { LBRACKET }
  | "]" { RBRACKET }
  | "{" { LCURLY }
  | "}" { RCURLY }
  | ":" { COLON }
  | ";" { SEMICOLON }
  | "," { COMMA }
  | "." { DOT }
  | "=" { EQ }
  | "<" { LT }
  | ">" { GT }
  | "+" { ADDOP }
  | "-" { SUBOP }
  | "*" { MULOP }
  | "/" { DIVOP }
  | "%" { MODOP }
  | "&" { ANDOP }
  | "|" { OROP }
  | "^" { XOROP }
  | "~" { NOTOP }
  | "<<" { SHIFTLOP}
  | ">>" { SHIFTROP}
(* 
  | ?? { ROTLOP }
  | ?? { ROTROP }
 *)
  | "@" { CATOP}  (*??*)
  | "->" { ARROW }
  | ":=" { ASSIGN }
  | "_" { UNDERSCORE }
(*TODO: literals need reworking*)
  | nat as s { NAT (int_of_string s) }
  | int as s { INT (int_of_string s) }
  | float as s { FLOAT (float_of_string s) }

  | string as s { STRING (string s) }
  | '"'character*('\n'|eof) { error lexbuf "unclosed string literal" }
  | '"'character*['\x00'-'\x09''\x0b'-'\x1f''\x7f']
    { error lexbuf "illegal control character in string literal" }
  | '"'character*'\\'_
    { error_nest (Lexing.lexeme_end_p lexbuf) lexbuf "illegal escape" }
(*
  | (nxx as t)".const"
    { let open Source in
      CONST (numop t
        (fun s -> let n = I32.of_string s.it in
          i32_const (n @@ s.at), Values.I32 n)
        (fun s -> let n = I64.of_string s.it in
          i64_const (n @@ s.at), Values.I64 n)
        (fun s -> let n = F32.of_string s.it in
          f32_const (n @@ s.at), Values.F32 n)
        (fun s -> let n = F64.of_string s.it in
          f64_const (n @@ s.at), Values.F64 n))
    }
*)
  | "actor" { ACTOR }
  | "and" { AND }
  | "async" { ASYNC }
  | "await" { AWAIT }
  | "break" { BREAK }
  | "case" { CASE }
  | "class" { CLASS }
  | "continue" { CASE }
  | "else" { ELSE }
  | "false" {BOOL false}
  | "for" { FOR }
  | "func" { FUNC }
  | "if" { IF }
  | "in" { IN }
  | "is" { IS }
  | "mut" { MUT }
  | "not" { NOT }
  | "null" { NULL }
  | "or" { OR }
  | "label" { LABEL }
  | "let" { LET }
  | "loop" { LOOP }
  | "private" { PRIVATE }
  | "return" { RETURN }
  | "switch" { SWITCH }
  | "true" {BOOL true}
  | "then" { THEN }
  | "type" { TYPE }
  | "var" { VAR }
  | "while" { WHILE }
  | name as s { ID s }
  | "//"utf8_no_nl*eof { EOF }
  | "//"utf8_no_nl*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | "//"utf8_no_nl* { token lexbuf (* causes error on following position *) }
  | "(*" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space#'\n' { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }

(*| reserved { error lexbuf "unknown operator" } *)
  | utf8 { error lexbuf "malformed operator" }
  | _ { error lexbuf "malformed UTF-8 encoding" }

and comment start = parse
  | "*)" { () }
  | "(*" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | utf8 { comment start lexbuf }
  | _ { error lexbuf "malformed UTF-8 encoding" }

(* debugging *)

(* This rule looks for a single line, terminated with '\n' or eof.
   It returns a pair of an optional string (the line that was found)
   and a Boolean flag (false if eof was reached). *)

and line = parse
| ([^'\n']* '\n') as line
    (* Normal case: one line, no eof. *)
    { Some line, true }
| eof
    (* Normal case: no data, eof. *)
    { None, false }
| ([^'\n']+ as line) eof
    (* Special case: some data but missing '\n', then eof.
       Consider this as the last line, and add the missing '\n'. *)
    { Some (line ^ "\n"), false }

