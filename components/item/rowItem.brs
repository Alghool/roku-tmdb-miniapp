sub Init()
  m.Poster = m.top.findNode("poster")
  m.Title = m.top.findNode("title")
end sub

sub itemContentChanged()
  'load content
  content = m.top.itemContent
  m.title.text = content.title
  
  'poster and title sizes are defaults for portait view 
  'in landscape mode needed to be adjusted 
  if content.row = "Now PLaying"
    m.poster.uri = content.herobannerurl
    m.poster.width = 476
    m.poster.height = 273
    
    m.title.width = 476
    m.title.height = 273
  else
    m.poster.uri = content.hdposterurl
  end if


end sub