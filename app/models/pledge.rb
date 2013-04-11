class Pledge < ActiveRecord::Base
  attr_accessible :amount
                        # , :project_id, :user_id -- should not be modifiable through mass assignment

  belongs_to :user
  belongs_to :project

  after_create :send_new_pledge_email 		#this is call back to 

  validates :user,    :presence => true
  validates :project, :presence => true

  validates :amount,  :numericality => {:only_integer => true, :greater_than => 0}, :presence => true

  def send_new_pledge_email
  	UserMailer.new_pledge(self).deliver    #it is better to do this here in model than in controller because 
  end										# you want lean controllers, fat models. and DRY

end
