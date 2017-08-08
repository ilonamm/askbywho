defmodule Askbywho.Repo do
  @moduledoc """
   TODO add documentation
   """

  use Ecto.Repo, otp_app: :askbywho
  use Scrivener, page_size: 10
end
