class ContactsController < ApplicationController

  def new
    @message = Message.new
    @string_data =
        if params[:how_to] == '1'
          "V prípade, že sa chcete zaregistrovať vyplňte pole 'Email' validnou e-mailovou adresou. Do obsahu správy napíšte názov inštitúcie, v ktorej pracujete,
           Vaše meno a prípadné otázky. Ohľadom systému používania budete následne informovaný administrátorom stránky"
        else
          "V prípade vyžiadania dodatočných informácií ohľadom používania, registrácií alebo záujmu
           o produkt, napíšte svoje požiadavky a otázky do časti 'Obsah správy'. Na Vami zadaný e-mail budete následne kontaktovaný
           administrátorom stránky"
        end
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
