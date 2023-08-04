let count = ref 0

let count_requests inner_handler request =
  count := !count + 1;
  inner_handler request

let () =
  Dream.run ~port:3015
  @@ Dream.logger
  @@ count_requests
  @@ Dream.router [
    Dream.get "/"
    (fun _ ->
      Dream.html "Good morning, world");
    
      Dream.get "/echo/:word"
      (fun request ->
        Dream.html (Dream.param request "word"));
  
      Dream.get "/app/**" (Dream.static "./public");
  
      Dream.get "/num-requests"
        (fun _ ->
          Dream.html (Printf.sprintf "Saw %i request(s)!" !count));
  ]