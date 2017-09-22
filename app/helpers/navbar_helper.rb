module NavbarHelper
  def transparent
     if controller_name == 'pages' && action_name == 'home'
      'transparent'
     else
      'black'
    end
  end
end
