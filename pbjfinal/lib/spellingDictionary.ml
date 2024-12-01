open Batteries

(* Abstract type representing a dictionary using BatSet. *)
type t = {
  system_dict : BatSet.String.t;
  mutable user_dict : BatSet.String.t;
}

(* Helper function to load a dictionary from file. *)
let load_dict filename =
  try
    BatEnum.fold
      (fun acc word -> BatSet.String.add word acc)
      BatSet.String.empty
      (BatFile.lines_of filename)
  with Sys_error msg -> raise (Sys_error msg)

(* [create system_dict user_dict] loads words from system and user dictionary
   files. *)
let create system_file user_file =
  let system_dict = BatSet.String.of_enum (BatFile.lines_of system_file) in
  let user_dict = BatSet.String.of_enum (BatFile.lines_of user_file) in
  { system_dict; user_dict }

(* [check_word dict word] checks if a word is in the dictionary. *)
let check_word dict word =
  BatSet.String.mem word dict.system_dict
  || BatSet.String.mem word dict.user_dict

(* [suggest_corrections dict word] returns possible corrections for a misspelled
   word. *)
let suggest_corrections dict word =
  let all_words = BatSet.String.union dict.system_dict dict.user_dict in
  BatSet.String.filter (fun w -> BatString.edit_distance word w = 1) all_words
  |> BatSet.String.elements

let create_from_lists system_words user_words =
  let system_dict = BatSet.String.of_list system_words in
  let user_dict = BatSet.String.of_list user_words in
  { system_dict; user_dict }
