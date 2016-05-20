class Agent < ActiveRecord::Base
  validates :ip, :presence => true, :uniqueness => true, :format => { :with => /([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}/ } 
  validates :cpu, numericality: true
  validates :disk, numericality: true
  validates :memory, numericality: true
          
end
