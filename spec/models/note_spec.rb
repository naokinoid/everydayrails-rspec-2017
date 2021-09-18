require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    @user = User.create(
      first_name: "Naoki",
      last_name: "Ito",
      email: "test@example.com",
      password: "pasword1",
    )
    @project = @user.projects.create(
      name: "test project",
    )
  end

  #ユーザー、プロジェクト、メッセージがあれば有効
  it "valid with a user, project, message" do
    note = Note.new(
      user: @user,
      project: @project,
      message: "message",
    )
    expect(note).to be_valid
  end

  describe "search message for a term" do
    before do
      @note1 = @project.notes.create(
        message: "this is first",
        user: @user,
      )
      @note2 = @project.notes.create(
        message: "this is second",
        user: @user,
      )
      @note3 = @project.notes.create(
        message: "first procedure is hahah",
        user: @user,
      )
    end

    context "when a match is found" do
      it "returns notes that matches the search term" do
        expect(Note.search("first")).to include(@note1,@note3)
        expect(Note.search("first")).not_to include(@note2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("hoge")).to be_empty
      end
    end

  end

end
