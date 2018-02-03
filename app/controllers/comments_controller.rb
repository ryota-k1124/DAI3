class CommentsController < ApplicationController
  def create
    # instagramをパラメータの値から探し出し,instagramに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @instagram = @comment.instagram
    @notification = @comment.notifications.build(user_id: @instagram.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to instagram_path(@instagram), notice: 'コメントを投稿しました。' }
        # JS形式でレスポンスを返します。
        format.js { render :index }
        
        unless @comment.instagram.user_id == current_user.id
          Pusher.trigger("user_#{@comment.instagram.user_id}_channel", 'comment_created', {
            message: 'あなたの投稿した画像にコメントが付きました'
          })
          Pusher.trigger("user_#{@comment.instagram.user_id}_channel", 'notification_created', {
            unread_counts: Notification.where(user_id: @comment.instagram.user.id, read: false).count
          })
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    format.js { render :edit }
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @instagram = @comment.instagram
    respond_to do |format|
      @comment.update
      format.html { redirect_to instagram_path(@instagram), notice: 'コメントを編集しました。' }
      format.js { render :index }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @instagram = @comment.instagram
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to instagram_path(@instagram), notice: 'コメントを削除しました。' }
      format.js { render :index }
    end
  end
  
  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:instagram_id, :content)
    end
end
