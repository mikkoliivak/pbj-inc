type t
(** Abstract type representing the spelling dictionary. *)

val create : string -> string -> t
(** [create system_dict user_dict] loads the dictionaries from the file paths
    [system_dict] and [user_dict]. Raises an exception if the files cannot be
    accessed. *)

val check_word : t -> string -> bool
(** [check_word dict word] checks if [word] is in the dictionary [dict]. *)

val suggest_corrections : t -> string -> string list
(** [suggest_corrections dict word] returns a list of possible corrections for
    the misspelled [word]. The corrections are words with an edit distance of 1. *)

val create_from_lists : string list -> string list -> t
