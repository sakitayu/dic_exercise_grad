require 'rails_helper'

RSpec.describe Rainy, type: :model do
  
  it "have_umbrellaが空ならバリデーションが通らない" do
    user = User.new(have_umbrella: '', area: '渋谷', name: 'テストちゃん', gender: 'どちらでもない', age: '非公開')
    expect(user).not_to be_valid
  end

  it "areaが空ならバリデーションが通らない" do
    user = User.new(have_umbrella: 'true', area: '', name: 'テストちゃん', gender: 'どちらでもない', age: '非公開')
    expect(user).not_to be_valid
  end

  it "areaが11文字以上ならバリデーションが通らない" do
    user = User.new(have_umbrella: 'true', area: '1234567891011', name: 'テストちゃん', gender: 'どちらでもない', age: '非公開')
    expect(user).not_to be_valid
  end

  it "nameが空ならバリデーションが通らない" do
    user = User.create(have_umbrella: 'true', area: '渋谷', name: '', gender: 'どちらでもない', age: '非公開')
    expect(user).not_to be_valid
  end

  it "nameが11文字以上ならバリデーションが通らない" do
    user = User.new(have_umbrella: 'true', area: '渋谷', name: 'テストちゃんテストちゃん', gender: 'どちらでもない', age: '非公開')
    expect(user).not_to be_valid
  end

  it "genderが空ならバリデーションが通らない" do
    user = User.new(have_umbrella: 'true', area: '渋谷', name: 'テストちゃん', gender: '', age: '非公開')
    expect(user).not_to be_valid
  end

  it "ageが空ならバリデーションが通らない" do
    user = User.new(have_umbrella: 'true', area: '渋谷', name: 'テストちゃん', gender: 'どちらでもない', age: '')
    expect(user).not_to be_valid
  end

  it "introductionが255文字以上ならバリデーションが通らない" do
    user = User.new(introduction: '123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910')
    expect(user).not_to be_valid
  end

  it "bodyが255文字以上ならバリデーションが通らない" do
    message = Message.new(body: '123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910')
    expect(message).not_to be_valid
  end

  it "bodyが空ならバリデーションが通らない" do
    message = Message.new(body: '')
    expect(message).not_to be_valid
  end

  it "conversation_idが空ならバリデーションが通らない" do
    message = Message.new(conversation_id: '')
    expect(message).not_to be_valid
  end

  it "user_idが空ならバリデーションが通らない" do
    message = Message.new(user_id: '')
    expect(message).not_to be_valid
  end

  it "sender_idとrecipient_idが同じ場合バリデーションが通らない" do
    conversation = Conversation.create(sender_id: 1, recipient_id: 1)
    expect(conversation).not_to be_valid
  end
end
