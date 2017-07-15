defmodule Askbywho.PageViewTest do
  use Askbywho.ConnCase, async: true
  alias Askbywho.PageView
  alias Askbywho.Repo
  alias Askbywho.Email
  alias Askbywho.Brand

  test "#count_emails should get the number of emails on database" do
    %Email{}
      |> Email.changeset(%{"email" => "test@email.com", "name" => "Test", "brands" => "Adidas, Nike"})
      |> Repo.insert

    assert PageView.count_emails == 1
  end

  test "#count_brands should get 'a brand' if the user nominated 1 brand" do
    assert PageView.count_brands_message(['adidas']) == "1 brand"
  end

  test "#count_brands should get '2 brands' if user nominated 2 brands" do
    assert PageView.count_brands_message(['adidas', 'nike']) == "2 brands"
  end

  test "#count_nominations/0 should sum how many nominations were sent" do
    %Email{}
      |> Email.changeset(%{"email" => "test@email.com", "name" => "Test", "brands" => "Adidas, Nike"})
      |> Repo.insert

    assert PageView.count_nominations == 2
  end

  test "#count_nominations/1 should sum how many nominations were sent for a brand" do
    %Email{}
      |> Email.changeset(%{"email" => "test@email.com", "name" => "Test", "brands" => "Adidas, Nike"})
      |> Repo.insert

    %Email{}
      |> Email.changeset(%{"email" => "test2@email.com", "name" => "Test 2", "brands" => "Adidas, Cavalera"})
      |> Repo.insert

    adidas = Repo.get_by(Brand, %{name: "Adidas"})

    assert PageView.count_nominations(adidas.id) == 2
  end

  test "#percent_nominations should calculate the percentage a brand arrived to get 1k nominations" do
    %Email{}
      |> Email.changeset(%{"email" => "test@email.com", "name" => "Test", "brands" => "Adidas, Nike"})
      |> Repo.insert

    %Email{}
      |> Email.changeset(%{"email" => "test2@email.com", "name" => "Test 2", "brands" => "Adidas, Cavalera"})
      |> Repo.insert

    adidas = Repo.get_by(Brand, %{name: "Adidas"})

    assert PageView.percent_nominations(adidas.id) == 0.002
  end

  test "#to_go should show the message of how many nominations a brand need to get 1k" do
    %Email{}
      |> Email.changeset(%{"email" => "test@email.com", "name" => "Test", "brands" => "Adidas, Nike"})
      |> Repo.insert

    %Email{}
      |> Email.changeset(%{"email" => "test2@email.com", "name" => "Test 2", "brands" => "Adidas, Cavalera"})
      |> Repo.insert

    adidas = Repo.get_by(Brand, %{name: "Adidas"})

    assert PageView.to_go(adidas.id) == "998 to go!"
  end

  test "#to_go should not show any message of the already got 1k+ of nominations" do
    for n <- 1..1000 do
      %Email{}
        |> Email.changeset(%{"email" => "test-#{n}@email.com", "name" => "Test #{n}", "brands" => "Adidas"})
        |> Repo.insert
    end

    adidas = Repo.get_by(Brand, %{name: "Adidas"})

    assert PageView.to_go(adidas.id) == ""
  end

end
