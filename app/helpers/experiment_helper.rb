module ExperimentHelper


include CodeTypesHelper
#retrieve user from partner see function auth_user(pid) in code_types_helper.rb

  #retrieve user from partner from experiment
  def auth_experiment_user(sid)
    @experiment = Experiment.find(sid)
    return auth_user(@experiment.partner_id)
  end


end
