class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = name
  end

  def call
    send(action)
    self.status = 200
    self.headers = { 'Content-Type' => 'text/html' }
    self.content = [template.render(self)]
    self
  end

  def template # 3
    Slim::Template.new(File.join(App.root, 'app', 'views', "#{self.name}", "#{self.action}.slim")) 
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Not found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal server error"]
    self
  end
end
