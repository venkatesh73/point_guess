# PointGuess

A phoenix api app, with a single endpoint.  This app will return, at max 2 (it can return less), users with more than a random number of points.

# Running an API Server

  To start PointGuess server:

  * # Prerequisites
      * Assuming you already have elixir, phoenix, and postgres installed, you could skip prerequisites steps. Otherwise, you could follow the following steps:
      
      * First you would need to have elixir and phoenix installed in your local machine. You could follow [Installing Elixir](https://elixir-lang.org/install.html) and [Phoenix Installation](https://hexdocs.pm/phoenix/installation.html) guideline to have elixir and phoenix installed respectively. In this project elixir version 1.14.0 and phoenix version 1.6.13 are used.

 * # Starting a Server
    * Clone this repository into your local computer and cd into the directory.
        ```sh
        git clone https://github.com/venkatesh73/point_guess.git
        cd point_guess
        ```
    * Install dependencies with `mix deps.get`
    * Make sure `postgres` is running in your local and rename `.env.example` to `.env` with proper DB creds and then run `source .env`. 
    * Create and migrate your database with `mix ecto.setup`
    * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
    * Run the endpoint by visiting to http://localhost:4000 or 
    * By running below cURL 
    ```
    > curl http://localhost:4000/

    {
      "users": [{"id": 1, "points": 30}, {"id": 72, "points": 45}],
      "timestamp": "2022-12-25 20:00:56"
    }
    ```

 * # Run Unit Test
   * To run the project unit test you could run `source .env && mix test`.