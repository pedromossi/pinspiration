class CommentsController < ApplicationController

  def create
    the_comment = Comment.new
    the_comment.photo_id = params.fetch("photo_id")
    the_comment.commenter_id = current_user.id
    the_comment.text = params.fetch("text")

    if the_comment.valid?
      the_comment.save
      redirect_to("/photos/#{params.fetch("photo_id")}", { :notice => "Comment created successfully." })
    else
      redirect_to("/photos/#{params.fetch("photo_id")}", { :alert => the_comment.errors.full_messages.to_sentence })
    end
  end

end
