defmodule AwesomeCli do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: AwesomeCli.Worker.start_link(arg1, arg2, arg3)
      # worker(AwesomeCli.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AwesomeCli.Supervisor]
    Supervisor.start_link(children, opts)
  end

def main(args) do
  args 
  |> parse_args 
  |> do_process
end

def parse_args(args) do
  options = OptionParser.parse(args)

  case options do
    {[name: name], _, _} -> [name]
    {[help: true], _, _} -> :help
    _ -> :help

  end
end

def do_process([name]) do
  IO.puts "Hello, #{name}! You're awesome!!"
end

def do_process(:help) do
  IO.puts """
    Usage:
    ./awesome_cli --name [your name]

    Options:
    --help  Show this help message.

    Description:
    Prints out an awesome message.
  """

  System.halt(0)
end


end
