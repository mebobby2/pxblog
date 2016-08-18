defmodule Pxblog.CommentControllerTest do
  use Pxblog.ConnCase

  alias Pxblog.Comment

  @valid_attrs %{author: "Some Person", body: "This is a sample comment"}
  @invalid_attrs %{}

  setup do
    user = insert(:user)
    post = insert(:post, user: user)
    comment = insert(:comment)

    {:ok, conn: build_conn(), user: user, post: post, comment: comment}
  end

  test "creates resource and redirects when data is valid", %{conn: conn, post: post} do
    conn = post conn, post_comment_path(conn, :create, post), comment: @valid_attrs
    assert redirected_to(conn) == user_post_path(conn, :show, post.user, post)
    assert Repo.get_by(assoc(post, :comments), @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, post: post} do
    conn = post conn, post_comment_path(conn, :create, post), comment: @invalid_attrs
    assert html_response(conn, 200) =~ "Oops, something went wrong"
  end

  test "deletes the comment", %{ conn: conn, post: post, comment: comment } do
    conn = delete(conn, post_comment_path(conn, :delete, post, comment))
    assert redirected_to(conn) == user_post_path(conn, :show, post.user, post)
    refute Repo.get(Comment, comment.id)
  end
end