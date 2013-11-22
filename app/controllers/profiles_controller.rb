class ProfilesController < AuthenticatedController
  def show
    # nothing here
  end

  def edit
    # neither here
  end

  def update
    if current_registered_player.update_attributes(profile_params)
      redirect_to profile_path, notice: 'Your profile was successfully updated'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:registered_player).permit(Player.column_names)
  end
end
