open Pbjfinal.PlayerAccess
open OUnit2

let csv_file = "../data/all_players.csv"

let test_file_not_found _ =
  assert_raises (Failure "The file 'non_existent_file.csv' does not exist.")
    (fun () -> get_player_attributes "non_existent_file.csv" "Some Player")

let test_player_not_found _ =
  assert_raises
    (PlayerNotFound "Player 'Nonexistent Player' not found in the CSV file.")
    (fun () -> get_player_attributes csv_file "Nonexistent Player")

let test_valid_player _ =
  let expected_attributes =
    [ "Kylian Mbappé"; "91"; "97"; "90"; "80"; "92"; "36"; "78" ]
  in
  let actual_attributes =
    let name, ovr, pac, sho, pas, dri, def, phy =
      get_player_attributes csv_file "Kylian Mbappé"
    in
    [ name; ovr; pac; sho; pas; dri; def; phy ]
  in
  assert_equal expected_attributes actual_attributes

let tests =
  "test suite"
  >::: [
         "test_file_not_found" >:: test_file_not_found;
         "test_player_not_found" >:: test_player_not_found;
         "test_valid_player" >:: test_valid_player;
       ]

let _ = run_test_tt_main tests
