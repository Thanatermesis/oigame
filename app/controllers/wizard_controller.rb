# encoding: utf-8
class WizardController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_sub_oigame

  layout 'application'

  # para el wizard de creación de campaña
  include Wicked::Wizard

  steps :first, :second

  def show
    @campaign = Campaign.find_by_slug(params[:campaign_id])
    render_wizard
  end

  def update
    @campaign = Campaign.find_by_slug(params[:campaign_id])
    params[:campaign][:wstatus] = step.to_s
    params[:campaign][:wstatus] = 'active' if step == steps.last
    @campaign.update_attributes(params[:campaign])
    render_wizard @campaign
  end

  def create
    @campaign = Campaign.create
    redirect_to new_campaign_path(:campaign_id => @campaign.slug)
  end

  private

  def finish_wizard_path
    @campaign = Campaign.find_by_slug(params[:campaign_id])
    if @campaign.sub_oigame
      Mailman.send_campaign_to_sub_oigame_admin(@campaign.sub_oigame.id, @campaign.id).deliver
      flash[:notice] = t(:thanks_for_propossing_sub)
      redirect_to sub_oigame_campaign_path(@sub_oigame)
    else
      Mailman.send_campaign_to_social_council(@campaign.id).deliver
      flash[:notice] = t(:thanks_for_propossing)
      redirect_to campaigns_path
    end

  end
end
