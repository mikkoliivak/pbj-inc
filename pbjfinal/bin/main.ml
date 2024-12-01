open Pbjfinal.PlayerAccess
open Csv
open Pbjfinal.SpellingDictionary
open Pbjfinal

let load_player_names csv_file =
  let csv_data = Csv.load csv_file in
  let data_rows = List.tl csv_data in
  let player_names = List.map (fun row -> List.nth row 0) data_rows in
  player_names

let () =
  let csv_file = "data/all_players.csv" in
  let player_names = load_player_names csv_file in
  let dict = SpellingDictionary.create_from_lists player_names [] in
  print_endline "Enter player name:";
  let player_name = read_line () in
  try
    let name, ovr, pac, sho, pas, dri, def, phy =
      get_player_attributes csv_file player_name
    in
    Printf.printf
      "Name: %s, OVR: %s, PAC: %s, SHO: %s, PAS: %s, DRI: %s, DEF: %s, PHY: %s\n"
      name ovr pac sho pas dri def phy
  with PlayerNotFound msg -> (
    Printf.printf "Error: %s\n" msg;
    let suggestions = SpellingDictionary.suggest_corrections dict player_name in
    match suggestions with
    | [] -> Printf.printf "No suggestions found.\n"
    | _ ->
        Printf.printf "Did you mean:\n";
        List.iteri (fun i s -> Printf.printf "%d: %s\n" (i + 1) s) suggestions;
        Printf.printf "Enter the number of the correct player, or 0 to cancel: ";
        let choice =
          try int_of_string (read_line ())
          with Failure _ ->
            Printf.printf "Invalid input.\n";
            0
        in
        if choice > 0 && choice <= List.length suggestions then
          let corrected_name = List.nth suggestions (choice - 1) in
          let name, ovr, pac, sho, pas, dri, def, phy =
            get_player_attributes csv_file corrected_name
          in
          Printf.printf
            "Name: %s, OVR: %s, PAC: %s, SHO: %s, PAS: %s, DRI: %s, DEF: %s, \
             PHY: %s\n"
            name ovr pac sho pas dri def phy
        else Printf.printf "No selection made.\n")
