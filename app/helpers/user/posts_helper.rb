module User::PostsHelper
  def render_with_hashtags(content) ## ハッシュタグをクリックすると指定のURLに遷移するように設定
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post/hashtag/#{word.delete("#")}"}.html_safe
  end
end
