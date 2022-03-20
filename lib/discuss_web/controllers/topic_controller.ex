defmodule DiscussWeb.TopicController do

  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

  def index(conn, _params) do
    # IO.inspect(conn.assigns)

    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do

    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset

    # struct = %Topic{}
    # params = %{}
    # changeset = Topic.changeset(struct, params)


    # IO.puts "++++"
    # IO.inspect conn
    # IO.puts "++++"
    # IO.inspect params
    # IO.puts "++++"
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      # {:ok, post} -> IO.inspect(post)
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Tema de filme criado!")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  # def create(conn, params) do
  #   %{"topic" => topic} = params
  # end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Tema de filme atualizado!")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end

    # old_topic = Repo.get(Topic, topic_id)
    # changeset = Topic.changeset(old_topic, topic)
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Tema de filme deletado!")
    |> redirect(to: Routes.topic_path(conn, :index))
  end


end
