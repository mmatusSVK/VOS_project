class ContactsController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      ContactMailer.send_contact(@message).deliver_now
      flash[:success] = "Správa bola odoslaná"
      redirect_to root_path
    else
      render :new
    end
  end

end
