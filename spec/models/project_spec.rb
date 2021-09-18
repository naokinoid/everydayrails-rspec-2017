require 'rails_helper'

RSpec.describe Project, type: :model do

  #ユーザー単位では同じ名前のプロジェクトは許可しない
  it "does not allow duplicate project names per user" do

    user = User.create(
      first_name: "Naoki",
      last_name: "Ito",
      email: "test@example.com",
      password: "pasword1",
    )

    user.projects.create(
      name: "duplicate name"
    )

    new_project = user.projects.build(
      name: "duplicate name"
    )

    new_project.valid?

    expect(new_project.errors[:name]).to include("has already been taken")

  end

  #二人のユーザーが同じ名前を使うのは許可する
  it "allows two users to share a project name" do

    user1 = User.create(
      first_name: "Naoki",
      last_name: "Ito",
      email: "test1@example.com",
      password: "pasword1",
    )

    user1.projects.create(
      name: "same name"
    )

    user2 = User.create(
      first_name: "Naoki",
      last_name: "Ito",
      email: "test2@example.com",
      password: "pasword1",
    )

    other_project = user2.projects.create(
      name: "same name"
    )

    expect(other_project).to be_valid


  end

end
