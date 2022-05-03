module HashtagMethods
  extend ActiveSupport::Concern

  ## ----- ハッシュタグ抽出処理 createアクションで実行 -----
  def extract_hashtag(content)
    if content.blank? ## 引数が空の場合は処理を実行しない
      return
    end
    return content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
  end

  ## ----- ハッシュタグ保存処理 createアクションで実行 -----
  def save_hashtag(hashtag_array, post_instance)
    if hashtag_array.blank? ## ハッシュタグを付けずに投稿された場合、下記メソッドを実行しない
      return
    end
    hashtag_array.uqui.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashtag_name: hashtag.downcase.delete('#')) ## ハッシュタグは先頭'#'を外して保存

      ## ----- post_hashtagテーブルへの保存処理 -----
      post_hashtag = PostHashtag.new
      post_hashtag.post_id = post_instance.id
      post_hashtag.hashtag_id = tag.id
      post_hashtag.save
    end
  end

  ## ----- ハッシュタグの情報をpost_objectに含める処理 -----
  def creating_structures(posts: "", post_hashtags: "", hashtags: "")
    array = []
    posts.each do |post|
      hashtag = []
      post_hash = post.attributes
      related_hashtag_records = post_hashtag.select{|ph| ph.post_id == post.id }
      related_hashtag_records.each do |record|
        hashtag << hashtags.detect{|hashtag| hashtag.id == record.hashtag_id }
      end
      post_hash["hashtags"] = hashtag
      array << post_hash
    end
    return array
  end

  ## ----- ハッシュタグの情報をhashutag/post_hashtagテーブルから削除する処理 -----
  def delete_records_related_to_hashtag(post_id)
    relationship_records = PostHashtag.where(post_id: post_id)
    if relationship_records.present?
      relationship_records.each do |record|
        record.destroy
      end
    end
    all_hashtags = Hashtag.all
    all_related_records = PostHashtag.all
    all_hashtags.each do |hashtag|
      if all_related_records.none?{|record| hashtag.id == record.hashtag_id}
        hashtag.destroy
      end
    end
  end

end
