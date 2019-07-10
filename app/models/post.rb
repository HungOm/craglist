class Post < ActiveRecord::Base
    belongs_to :category
    belongs_to :post

    # def self.post_date(id)
    #     post = Post.find_by(id:id)
    #     post.created_at
    # end

    def self.get_post_time(from_time)
        time =Time.now.utc-from_time
        hour = Time.at(time).utc.strftime "%H"
        hour
    end

end