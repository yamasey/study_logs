# ActiveRecordは素晴らしいがSQLクエリから隔離されすぎており、機能を理解しないと意図しないクエリが発行される

# 3つ
# count, where, present?

# .countは毎回SQLを発行する
# .sizeで代用する
# レコードが存在する場合は、length。ない場合はcountを実行

def size
  loaded? ? @records.length : count(:all)
end

countはメモ化はせず常に問い合わせる
def count(column_name = nil)
  if block_given?
    # ...
    return super()
  end

  calculate(:count, column_name)
end

# .where

<% @posts.each do |post| %>
  <%= post.content %>
  # active_commentsの中身でcomenntを呼び出してるのでn+1発生
  <%= render partial: :comment, collection: post.active_comments %>
<% end %>

# しかもwhereは即時発酵するのでincludeできない
class Post < ActiveRecord::Base
  def active_comments
    comments.where(soft_deleted: false)
  end
end
# コレクションをレンダリングする場合は関連付のスコープは呼び出さない
# 代わりに新しいリレーションを定義することでインクルードできるようになる。
class Post
  has_many :comments
  has_many :active_comments, -> { active }, class_name: "Comment"
end

class Comment
  belongs_to :post
  scope :active, -> { where(soft_deleted: false) }
end

class PostsController
  def index
    @posts = Post.includes(:active_comments)
  end
end
