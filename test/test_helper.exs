ExUnit.start

# Mix.Task.run "ecto.create", ~w(-r Askbywho.Repo --quiet)
# Mix.Task.run "ecto.migrate", ~w(-r Askbywho.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(Askbywho.Repo, :manual)


# FOR < Ecto 2.0
# Ecto.Adapters.SQL.begin_test_transaction(Askbywho.Repo)

