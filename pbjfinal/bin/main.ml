open Pbjfinal.PlayerAccess
open Csv

let () =
  let csv_file = "data/all_players.csv" in
  print_endline "Enter player name:";
  let player_name = read_line () in
  try
    let name, ovr, pac, sho, pas, dri, def, phy =
      get_player_attributes csv_file player_name
    in
    Printf.printf
      "Name: %s, OVR: %s, PAC: %s, SHO: %s, PAS: %s, DRI: %s, DEF: %s, PHY: %s\n"
      name ovr pac sho pas dri def phy
  with
  | PlayerNotFound msg -> Printf.printf "Error: %s\n" msg
  | e ->
      Printf.printf "An unexpected error occurred: %s\n" (Printexc.to_string e)
