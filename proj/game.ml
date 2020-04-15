open Yojson.Basic.Util

type points = int
type letter = string

type alphabet =  { vowels: (letter * points) list; 
                   consonants: (letter * points) list }

type t = { vowels: (letter * points) list; 
           consonants: (letter * points) list }

(** type t = (letter * points) list *)

(** [points_as_int e] is a letter-points pair pased from json with points as 
    integer.*)
let points_as_int e = (fst e, snd e |> to_int)

let from_json j : alphabet = { 
  vowels = j |> member "vowels" |> to_assoc |> List.map points_as_int;
  consonants = j|> member "consonants" |> to_assoc |> List.map points_as_int;
}

let rand_l a b = (List.nth a (Random.int b))

let letter_set (a : alphabet) : t = {
  vowels = [(rand_l a.vowels 5);(rand_l a.vowels 5)];
  consonants = [(rand_l a.consonants 21); (rand_l a.consonants 21); 
                (rand_l a.consonants 21); (rand_l a.consonants 21)];
}

let rec get_points l set = match set with 
  | [] -> failwith "not in letter set" (* can be changed when implementing legal/illegal inputs! *)
  | (l', p) :: t -> if l = l' then p else get_points l t